class_name ThreadsMenu
extends Control

@onready var threadCountList = %ThreadCountList

var database: DatabaseResources

func _ready() -> void:
	database = DatabaseResources.loadOrCreate()
	threadCountList.select(database.threadIndex)

func _on_item_list_item_selected(index: int) -> void:
	database.threadCount = threadCountList.get_item_text(index)
	database.threadIndex = index
	database.save()
