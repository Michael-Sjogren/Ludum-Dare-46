extends KinematicBody2D
onready var Globals = $"/root/Globals"
onready var max_jump_height = 2* Globals.UNIT_SIZE
onready var min_jump_height = .25 * Globals.UNIT_SIZE

export var ACCELERATION_MULTIPLIER = 10
export var MAX_MOVE_SPEED_MULTIPLIER = 3
export var life_time = 20
export var lives = 3
export(float) var FRICTION = 1.0

var _acceleration
var _max_move_speed
var _velocity =  Vector2.ZERO
var _move_direction = Vector2.ZERO
var is_moving = false
var gravity = 0
var max_jump_velcoity
var min_jump_velcoity
var is_dead = false
var hasPressedJump = false
onready var jumpTimer = $JumpTimer
onready var fuelTimer = $FuelTimer
onready var light2d = $Light2D
onready var flame_particles = $FlamesParticles
onready var health_sprite = $HealthVisual
onready var original_health_scale = health_sprite.scale
const UP = Vector2.UP


var jump_duration = .5

func _ready():
	fuelTimer.start()
	fuelTimer.paused = true
	gravity = 2* max_jump_height / pow(jump_duration,2)
	max_jump_velcoity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velcoity = -sqrt(2 * gravity * min_jump_height)
	_max_move_speed = Globals.UNIT_SIZE * MAX_MOVE_SPEED_MULTIPLIER
	_acceleration = Globals.UNIT_SIZE * ACCELERATION_MULTIPLIER

func get_input():
	var LEFT = int(Input.get_action_strength("left"))
	var RIGHT = int(Input.get_action_strength("right"))

	_move_direction.x = RIGHT - LEFT
	if _move_direction == Vector2.ZERO:
		_velocity.x = lerp(_velocity.x , 0 , FRICTION)
		is_moving = false
	else:
		is_moving = true
			
	if _velocity.x == 0 or !is_moving:
		fuelTimer.paused = true
	else:
		if fuelTimer.paused:
			fuelTimer.paused = false
	
func jump(vel):
	_velocity.y += vel
	_velocity = move_and_slide(_velocity , UP)
	hasPressedJump = false
	jumpTimer.start()

func move(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(max_jump_velcoity)
	if (Input.is_action_just_released("jump") &&
		_velocity.y < min_jump_velcoity):
			print(min_jump_velcoity)
			_velocity.y = min_jump_velcoity
			_velocity = move_and_slide(_velocity , UP)
	
	_velocity.x += _move_direction.x * _acceleration * delta
	_velocity.x = clamp(_velocity.x , -_max_move_speed , _max_move_speed)
	_velocity = move_and_slide(_velocity , UP)
	_velocity.y += gravity * delta
	_velocity = move_and_slide(_velocity , UP)
	

func _physics_process(delta):
	if is_dead:
		return
	get_input()
	move(delta)	
	if fuelTimer.time_left > 0:
		var energy = fuelTimer.time_left / fuelTimer.wait_time
		var scale = (Vector2.ONE * fuelTimer.time_left) / original_health_scale
		health_sprite.scale = scale
		light2d.energy = energy 

func add_fuel(fuel_amount):
	fuelTimer.start(fuelTimer.time_left + fuel_amount)

func _on_JumpTimer_timeout():
	pass


func _on_FuelTimer_timeout():
	die()

func die():
	light2d.energy = 0
	flame_particles.emitting = false
	$Sun.visible = false
	is_dead = true
