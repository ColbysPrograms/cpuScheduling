class_name AlgorithmsMenu
extends Control

var database: DatabaseResources

@onready var algoButton = %AlgoButton
@onready var priorityButton = %PriorityButton
@onready var timingButton = %TimingButton

func _ready() -> void:
	database = DatabaseResources.loadOrCreate()
	algoButton.button_pressed = database.algoChoice
	priorityButton.button_pressed = database.priority
	timingButton.button_pressed = database.timing

func _on_algorithms_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")

func _on_programs_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Programs.tscn")

func _on_threads_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Threads.tscn")

func _on_algo_button_toggled(toggled_on: bool) -> void:
	database.algoChoice = toggled_on
	database.save()

func _on_priority_button_toggled(toggled_on: bool) -> void:
	database.priority = toggled_on
	database.save()

func _on_timing_button_toggled(toggled_on: bool) -> void:
	database.timing = toggled_on
	database.save()
