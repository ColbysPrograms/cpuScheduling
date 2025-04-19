class_name Program
extends Control

var database: DatabaseResources

func _ready() -> void:
	database = DatabaseResources.loadOrCreate()

func _on_burst_time_line_edit_text_changed(new_text: String) -> void:
	var index: int = int(%PIDLabel.text.replace("P", ""))
	database.programsArray.get(index - 1).burstTime = int(new_text)
	database.save()

func _on_priority_line_edit_text_changed(new_text: String) -> void:
	var index: int = int(%PIDLabel.text.replace("P", ""))
	database.programsArray.get(index - 1).priority = int(new_text)
	database.save()

func _on_arrival_time_line_edit_text_changed(new_text: String) -> void:
	var index: int = int(%PIDLabel.text.replace("P", ""))
	database.programsArray.get(index - 1).arrivalTime = int(new_text)
	database.save()
