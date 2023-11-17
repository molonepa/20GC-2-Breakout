extends CharacterBody2D

var speed : float = 150.0
var start_position : Vector2

func _ready():
	start_position = global_position
	set_collision_layer(Collision.paddle_collision_layer)
	set_collision_mask(Collision.wall_collision_layer)
	SignalBus.connect("reset_level", _reset)

func _physics_process(delta):
	velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		velocity = Vector2.RIGHT * speed
	if Input.is_action_pressed("move_left"):
		velocity = Vector2.LEFT * speed

	move_and_slide()

func _reset():
	global_position = start_position
