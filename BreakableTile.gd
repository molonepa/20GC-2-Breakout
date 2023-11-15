extends StaticBody2D

var hitpoints = 1

func _ready():
	set_collision_layer(Collision.breakable_collision_layer)

func hit():
	hitpoints -= 1

	if hitpoints == 0:
		_destroy()

func _destroy():
	queue_free()
	SignalBus.breakable_tile_destroyed.emit()
