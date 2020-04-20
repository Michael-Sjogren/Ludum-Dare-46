extends CanvasLayer

signal scene_changed()
onready var player = $AnimationPlayer
onready var colored_rect = $Control/ColorRect

func change_scene(path, delay = .5):
	yield(get_tree().create_timer(delay), "timeout")
	player.play("fade")
	yield(player, "animation_finished")
	assert(get_tree().change_scene(path) == OK, "Failed to load scene")
	player.play_backwards("fade")
	emit_signal("scene_changed")
