extends StaticBody2D

func _ready():
	self.set_collision_layer(Collision.wall_collision_layer)
	self.set_collision_mask(Collision.paddle_collision_layer)

func destroy():
	self.queue_free()
