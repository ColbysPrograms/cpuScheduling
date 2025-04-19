class_name DatabaseResources
extends Resource

@export var algoChoice: bool = false
@export var priority: bool = false
@export var timing: bool = false

@export var programsArray: Array[ProgramResources] = [ProgramResources.new()]
@export var programsIndex: int = 1

@export var threadCount: int = 1
@export var threadIndex: int = 1

@export var schedule: Array[Array] = []

func save() -> void:
	ResourceSaver.save(self, "user://save.tres")
	
static func create() -> DatabaseResources:
	return DatabaseResources.new()

static func loadOrCreate() -> DatabaseResources:
	var res: DatabaseResources = load("user://save.tres") as DatabaseResources
	if !res:
		res = DatabaseResources.new()
	return res

func duplicate_deep() -> DatabaseResources:
	var res: DatabaseResources = load("user://save.tres") as DatabaseResources
	var resDuplicate: DatabaseResources = res.duplicate(true)
	resDuplicate.programsArray = []
	for i in res.programsArray.size():
		resDuplicate.programsArray.append(res.programsArray.get(i).duplicate(true))
	return resDuplicate
