extends CanvasLayer

onready var rect = $Control/ColorRect

func _ready():
	rect.hide()
	get_parent().connect("player_died",self,"_on_Player_death")
	

func _on_Player_death():
	print("player died")
	rect.show()
	
