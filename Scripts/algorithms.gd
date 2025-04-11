class_name AlgorithmsMenu
extends Control

const ATTRIBUTES_LIST: Array[AlgorithmResources] = [
	preload("res://CreatedResources/algorithmFalse.tres")
]
@export var stats: AlgorithmResources = load("res://CreatedResources/algorithmFalse.tres")

func _ready() -> void:
	$MarginContainer/VBoxContainer2/HBoxContainer2/AlgoButton.button_pressed = stats.algoChoice
	$MarginContainer/VBoxContainer2/HBoxContainer3/PriorityButton.button_pressed = stats.priority
	$MarginContainer/VBoxContainer2/HBoxContainer4/TimingButton.button_pressed = stats.timing

func _on_algorithms_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")

func _on_programs_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Programs.tscn")

func _on_threads_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Threads.tscn")

func _on_algo_button_toggled(toggled_on: bool) -> void:
	stats.algoChoice = toggled_on

func _on_priority_button_toggled(toggled_on: bool) -> void:
	stats.priority = toggled_on

func _on_timing_button_toggled(toggled_on: bool) -> void:
	stats.timing = toggled_on

func _on_quit_button_pressed() -> void:
	get_tree().quit()
