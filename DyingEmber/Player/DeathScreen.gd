extends CanvasLayer

onready var rect = $Control/ColorRect
onready var control = $Control

func _ready():
	control.hide()
	rect.hide()
	get_parent().connect("player_died",self,"_on_Player_death")
	

func _on_Player_death():
	print("player died")
	control.show()
	rect.show()
	
