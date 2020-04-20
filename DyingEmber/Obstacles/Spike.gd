extends Node

onready var area2d = $Area2D

func _ready():
	area2d.connect("body_entered",self,"on_Player_entred")
	
	
func on_Player_entred(body):
	body.die()
