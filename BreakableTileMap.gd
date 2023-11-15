extends TileMap

var wall_tile = preload("res://BreakableTile.tscn")

func _ready():
	var cells = get_used_cells(0)
	remove_layer(0)
	for cell in cells:
		var tile_position = to_global(map_to_local(cell))
		var tile_instance = wall_tile.instantiate()
		tile_instance.global_position = tile_position
		add_child(tile_instance)
