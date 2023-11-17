extends Node2D

var is_paused : bool = true
var start_speed : int = 100
var current_speed : int = 0
var radius : int = 4
var direction : Vector2
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var start_position : Vector2 = Vector2(268, 100)

@onready var ray_cast = $RayCast2D

func _ready():
	_initialise()

	ray_cast.set_collision_mask(Collision.wall_collision_layer | Collision.paddle_collision_layer | Collision.breakable_collision_layer | Collision.boundary_collision_layer)

	SignalBus.connect("breakable_tile_destroyed", _increase_speed)
	SignalBus.connect("ball_missed", _reset)

func _process(delta):
	if is_paused and Input.is_action_just_pressed("start"):
		current_speed = start_speed

func _physics_process(delta):
	global_position += delta * direction * current_speed

	if ray_cast.is_colliding():
		var normal = ray_cast.get_collision_normal()
		direction = direction.bounce(normal).normalized()
		ray_cast.target_position = direction * radius

		var collider = ray_cast.get_collider()
		if collider.collision_layer == Collision.breakable_collision_layer:
			SignalBus.breakable_tile_hit.emit(collider)
		if collider.collision_layer == Collision.boundary_collision_layer:
			SignalBus.ball_missed.emit()

func _initialise():
	global_position = start_position
	is_paused = true
	current_speed = 0
	direction = Vector2(-1, 1).normalized()
	ray_cast.target_position = direction * radius

func _increase_speed():
	current_speed *= 1.01
	start_speed = current_speed

func _reset():
	_initialise()
