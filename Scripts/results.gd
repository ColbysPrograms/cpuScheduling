extends Control

var database: DatabaseResources

var maxSchedule: int = 0
var totalSchedule: int = 0

func _ready() -> void:
	database = DatabaseResources.loadOrCreate()
	findMaxSchedule()
	findTotalSchedule()
	var utilization = findUtilization()
	var waiting = findWaiting()
	var throughput = findThroughput()
	%UtilizationLabel.text += str(utilization)
	%WaitingLabel.text += str(waiting)
	%ThroughputLabel.text += str(throughput)
	

func _on_reset_button_pressed() -> void:
	database = DatabaseResources.create()
	database.save()
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")
	
func findMaxSchedule() -> void:
	maxSchedule = database.schedule.size() * database.schedule.get(0).size()

func findTotalSchedule() -> void:
	for i in database.schedule.size():
		for j in database.schedule.get(i).size():
			if database.schedule.get(i).get(j) != 0:
				totalSchedule += 1

func findUtilization() -> float:
	var utilization = float(totalSchedule) / maxSchedule
	return utilization

func findThroughput() -> float:
	var throughput = 0
	var processesCompleted = database.programsArray.size()
	throughput = float(processesCompleted) / maxSchedule
	return throughput

func findTurnaround() -> float:
	var turnaround = 0
	
	return turnaround

func findWaiting() -> float:
	var waiting = 0
	for i in database.schedule.size():
		for j in database.schedule.get(i).size():
			if database.schedule.get(i).get(j) == 0:
				waiting += 1
	return waiting
