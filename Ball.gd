extends Node2D

var speed : int = 100
var radius : int= 4
var direction : Vector2
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

@onready var ray_cast = $RayCast2D

func _ready():
	direction = Vector2(rng.randf_range(-.15, .15), rng.randf()).normalized()
	ray_cast.target_position = direction * radius

	ray_cast.set_collision_mask(Collision.wall_collision_layer | Collision.paddle_collision_layer | Collision.breakable_collision_layer)

	SignalBus.connect("breakable_tile_destroyed", _increase_speed)

func _physics_process(delta):
	global_position += delta * direction * speed

	if ray_cast.is_colliding():
		var normal = ray_cast.get_collision_normal()
		direction = direction.bounce(normal).normalized()
		ray_cast.target_position = direction * radius

		var collider = ray_cast.get_collider()
		if collider.collision_layer == Collision.breakable_collision_layer:
			SignalBus.breakable_tile_hit.emit(collider)

func _increase_speed():
	speed *= 1.01
