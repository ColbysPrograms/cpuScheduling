class_name ProgramsMenu
extends Control

const ATTRIBUTES_LIST: Array[ProgramResources] = [
	preload("res://CreatedResources/emptyProgram.tres")
]
var emptyProgram = load("res://CreatedResources/emptyProgram.tres")
#@export var programsArray: Array[ProgramResources] = [emptyProgram]
@export var programsArray = [emptyProgram]
var program = load("res://Scenes/Program.tscn")

func _ready() -> void:
	for i in range(programsArray.size()):
		$MarginContainer/VBoxContainer2/VBoxContainer.get_child(1)

func _on_algorithms_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")

func _on_programs_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Programs.tscn")

func _on_threads_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Threads.tscn")

func _on_add_program_button_pressed() -> void:
	programsArray.append(emptyProgram)
	var instancedProgram = program.instantiate()
	$MarginContainer/VBoxContainer2/VBoxContainer.add_child(instancedProgram)
