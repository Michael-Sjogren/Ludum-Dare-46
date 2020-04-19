extends Area2D

export var fuel_amount = 5.0


func _on_Oxygen_body_entered(body):
	body.add_fuel(fuel_amount)
	queue_free()
