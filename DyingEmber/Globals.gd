extends Node

var GRAVITY
const UNIT_SIZE = 16

func _input(event):
	if Input.is_action_just_released("restart"):
		LevelManager.restart()
	if Input.is_action_just_released("quit"):
		get_tree().quit()
