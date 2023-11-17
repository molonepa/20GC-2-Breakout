extends TileMap

var collision_layer

func _ready():
	collision_layer = Collision.wall_collision_layer
