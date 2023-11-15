extends Node2D

signal breakable_tile_hit

const SPEED : int = 100

var radius = 4
var direction : Vector2
var rng = RandomNumberGenerator.new()

@onready var ray_cast = $RayCast2D

func _ready():
	direction = Vector2(rng.randf_range(-.15, .15), rng.randf()).normalized()
	ray_cast.target_position = direction * radius

	ray_cast.set_collision_mask(Collision.wall_collision_layer | Collision.paddle_collision_layer | Collision.breakable_collision_layer)

func _physics_process(delta):
	self.global_position += delta * direction * SPEED

	if ray_cast.is_colliding():
		var normal = ray_cast.get_collision_normal()
		direction = direction.bounce(normal).normalized()
		ray_cast.target_position = direction * radius

		var collider = ray_cast.get_collider()
		if collider.collision_layer == Collision.breakable_collision_layer:
			emit_signal("breakable_tile_hit", collider)
