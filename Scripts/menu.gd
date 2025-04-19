extends Control

var database: DatabaseResources

func _ready() -> void:
	database = DatabaseResources.create()
	#database.test()
	database.save()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Algorithms.tscn")
