extends Node2D

@onready var ball = $Ball

func _ready():
	ball.connect("breakable_tile_hit", _on_breakable_tile_hit)

func _on_breakable_tile_hit(tile):
	tile.destroy()
