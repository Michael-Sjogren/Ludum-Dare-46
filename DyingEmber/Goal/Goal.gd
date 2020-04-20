extends Area2D

signal level_win()

func _ready():
	self.connect("body_entered",self,"_on_Goal_body_entered")

func _on_Goal_body_entered(body):
	body.hide_and_disable_player()
	LevelManager.load_next_level()
