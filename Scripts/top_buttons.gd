extends Control

func _on_algorithms_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")

func _on_programs_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Programs.tscn")

func _on_threads_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Threads.tscn")
