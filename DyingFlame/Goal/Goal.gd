extends Area2D

signal level_win()

func _on_Goal_body_entered(body):
	emit_signal("level_win")
