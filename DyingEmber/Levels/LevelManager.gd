extends Node
var level_index = 0
var levels = [
	"res://Levels/Tutorial.tscn",
	"res://Levels/Level_01.tscn",
	"res://Levels/Level_02.tscn",
	"res://Levels/Level_03.tscn",
	"res://Levels/Level_04.tscn",
	"res://Levels/Level_05.tscn",
]

onready var scene_changer = SceneChanger

signal level_completed()
signal retry_level()

func get_current_level():
	var scene_name = get_tree().current_scene.filename
	var index = 0
	for level_path in levels:
		if level_path == scene_name:
			return index
		index += 1
	return -1
	
	
func load_next_level():
	if get_current_level() != -1:
		level_index = get_current_level()
	var next_level_index = level_index+1
	if next_level_index >= levels.size():
		level_index = 0
	else:
		level_index = next_level_index
	scene_changer.change_scene(
		levels[level_index]
	)

func restart():
	if get_current_level() != -1:
		level_index = get_current_level()
	scene_changer.change_scene(levels[level_index] , 0.05)
