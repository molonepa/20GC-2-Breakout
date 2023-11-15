extends StaticBody2D

func _ready():
	set_collision_layer(Collision.wall_collision_layer)
	set_collision_mask(Collision.paddle_collision_layer)

func destroy():
	queue_free()
