class_name ProgramsMenu
extends Control

@onready var programContainer = %ProgramContainer

var database: DatabaseResources

var newProgram = load("res://Scenes/Program.tscn")

func _ready() -> void:
	database = DatabaseResources.loadOrCreate()
	programContainer.get_child(0).get_child(0).get_child(1).text = str(database.programsArray.get(0).burstTime)
	programContainer.get_child(0).get_child(0).get_child(2).text = str(database.programsArray.get(0).priority)
	programContainer.get_child(0).get_child(0).get_child(3).text = str(database.programsArray.get(0).arrivalTime)
	for i in database.programsIndex - 1:
		i += 1
		var instance = newProgram.instantiate()
		programContainer.add_child(instance)
		programContainer.get_child(i).get_child(0).get_child(0).text = "         P" + str(i + 1)
		programContainer.get_child(i).get_child(0).get_child(1).text = str(database.programsArray.get(i).burstTime)
		programContainer.get_child(i).get_child(0).get_child(2).text = str(database.programsArray.get(i).priority)
		programContainer.get_child(i).get_child(0).get_child(3).text = str(database.programsArray.get(i).arrivalTime)

func _on_add_program_button_pressed() -> void:
	database.programsArray.append(ProgramResources.new())
	database.programsIndex += 1
	var instance = newProgram.instantiate()
	programContainer.add_child(instance)
	programContainer.get_child(database.programsIndex - 1).get_child(0).get_child(0).text = "         P" + str(database.programsIndex)
	database.save()

func _on_delete_program_button_pressed() -> void:
	if programContainer.get_child_count() > 1:
		database.programsArray.pop_back()
		database.programsIndex -= 1
		programContainer.remove_child(programContainer.get_child(programContainer.get_child_count() - 1))
		database.save()

func _on_tree_exiting() -> void:
	for i in database.programsArray.size():
		database.programsArray.get(i).index = i
	database.save()
