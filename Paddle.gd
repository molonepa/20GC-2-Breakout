extends CharacterBody2D

var speed : float = 100.0
var start_height : int

func _ready():
	start_height = global_position.y

	set_collision_layer(Collision.paddle_collision_layer)
	set_collision_mask(Collision.wall_collision_layer)

func _physics_process(delta):
	global_position.y = start_height

	velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		velocity = Vector2.RIGHT * speed
	if Input.is_action_pressed("move_left"):
		velocity = Vector2.LEFT * speed

	move_and_slide()
