class_name Simulation
extends Control

@onready var processContainer = %processContainer

var newThread = load("res://Scenes/SimulationProcess.tscn")
var newBlock = load("res://Scenes/SimulationBlock.tscn")

var database: DatabaseResources
var databaseBackup: DatabaseResources
var schedule: Array[Array]

func _ready() -> void:
	database = DatabaseResources.loadOrCreate()
	databaseBackup = database.duplicate_deep()
	for i in database.threadCount:
		var instance = newThread.instantiate()
		processContainer.add_child(instance)
		processContainer.get_child(i).get_child(0).get_child(0).text = "T" + str(i + 1)
	run_simulation()

func run_simulation() -> void:
	var time: Array[int]
	var i: int = 0
	var currentPriority: int = 0
	
	var waiting: Array[ProgramResources]
	var ready: Array[ProgramResources]
	var running: Array[ProgramResources]
	var terminated: Array[ProgramResources]
	
	#Put all processes in waiting queue
	waiting = database.programsArray
	if database.algoChoice:
		waiting = sort(waiting)
	
	while(true):
		i+=1
		#Initializes process of each thread in current time slot as 0
		time = []
		for j in database.threadCount:
			time.append(0)
		#When a process's arrival time happens, it is put in the ready queue and popped from waiting
		for j in waiting.size():
			#First Come First Serve
			if waiting.get(j) != null && waiting.get(j).arrivalTime <= i:
				ready.append(waiting.get(j))
				waiting.set(j, null)
		#When a thread is available and a process is in the ready queue, it is moved to the running queue
		for j in ready.size():
			if ready.get(j) != null && !ready.is_empty():
				for k in database.threadCount:
					var empty: bool = true
					for l in running.size():
						if running.get(l) != null && running.get(l).thread == k + 1:
							empty = false
					if empty:
						if database.algoChoice:
							ready = sort(ready)
						elif database.priority:
							ready = sort(ready)
						running.append(ready.get(j))
						running.get(j).thread = k + 1
						time.set(k, ready.get(j).index + 1)
						ready.set(j, null)
						break
		#When a process has completed (burst time = 0), it is moved to the terminated queue
		for j in running.size():
			if running.get(j) != null:
				running.get(j).burstTime -= 1
				time.set(running.get(j).thread - 1, running.get(j).index + 1)
				if running.get(j).burstTime == 0:
					for k in database.threadCount:
						if running.get(j) != null && running.get(j).thread == k + 1:
							terminated.append(ready.get(j))
							running.set(j, null)
		schedule.append(time)
		if terminated.size() == database.programsArray.size():
			break
	update()
	
func update() -> void:
	for time in schedule.size():
		for thread in schedule.get(time).size():
			var process = int(schedule.get(time).get(thread))
			var instance = newBlock.instantiate()
			processContainer.get_child(thread).get_child(0).add_child(instance)
			if process == 0:
				processContainer.get_child(thread).get_child(0).get_child(time + 1).get_node("NinePatchRect/HBoxContainer/Label").text = "X"
			else:
				processContainer.get_child(thread).get_child(0).get_child(time + 1).get_node("NinePatchRect/HBoxContainer/Label").text = "P" + str(process)

func sort(array: Array[ProgramResources]) -> Array[ProgramResources]:
	if database.algoChoice == true:
		var n = array.size()
		for i in n - 1:
			var minIndex = i
			for j in range(i + 1, n):
				if array.get(j) != null && array.get(minIndex) != null && array.get(j).burstTime < array.get(minIndex).burstTime:
					minIndex = j
			var swap = array.get(i)
			array.set(i, array.get(minIndex))
			array.set(minIndex, swap)
	if database.priority == true:
		var n = array.size()
		for i in n - 1:
			var minIndex = i
			for j in range(i + 1, n):
				if array.get(j) != null && array.get(minIndex) != null && array.get(j).priority < array.get(minIndex).priority:
					minIndex = j
			var swap = array.get(i)
			array.set(i, array.get(minIndex))
			array.set(minIndex, swap)
	return array

func _on_skip_button_pressed() -> void:
	databaseBackup.schedule = schedule
	databaseBackup.save()
	get_tree().change_scene_to_file("res://Scenes/Results.tscn")
