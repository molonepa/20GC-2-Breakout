extends Node2D

const SPEED : int = 100

var radius = 4
var direction : Vector2
var rng = RandomNumberGenerator.new()

@onready var ray_cast = $RayCast2D

func _ready():
	direction = Vector2(rng.randf_range(-1.0, 1.0), rng.randf()).normalized()
	ray_cast.target_position = direction * radius

func _physics_process(delta):
	self.global_position += delta * direction * SPEED

	if ray_cast.is_colliding():
		var normal = ray_cast.get_collision_normal()
		direction = direction.bounce(normal).normalized()
		ray_cast.target_position = direction * radius
