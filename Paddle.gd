extends CharacterBody2D

const SPEED = 100.0

var start_height : int

func _ready():
	start_height = global_position.y

	self.set_collision_layer(Collision.paddle_collision_layer)
	self.set_collision_mask(Collision.wall_collision_layer)

func _physics_process(delta):
	global_position.y = start_height

	velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		velocity = Vector2.RIGHT * SPEED
	if Input.is_action_pressed("move_left"):
		velocity = Vector2.LEFT * SPEED

	move_and_slide()
