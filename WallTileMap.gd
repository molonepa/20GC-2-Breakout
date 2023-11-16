extends TileMap

var wall_tile = preload("res://WallTile.tscn")

func _ready():
	hide()
	_initialise_tiles()

func _initialise_tiles():
	var cells = get_used_cells(0)
	for cell in cells:
		var tile_position = to_global(map_to_local(cell))
		var tile_instance = wall_tile.instantiate()
		tile_instance.global_position = tile_position
		get_parent().add_child.call_deferred(tile_instance)
