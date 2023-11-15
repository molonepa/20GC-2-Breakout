extends StaticBody2D

func _ready():
	self.set_collision_layer(Collision.breakable_collision_layer)

func destroy():
	self.queue_free()
