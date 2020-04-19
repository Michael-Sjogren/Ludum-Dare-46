extends Area2D


func _ready():
	connect("body_entered",self,"on_Player_entred")
	
	
func on_Player_entred(body):
	body.die()
