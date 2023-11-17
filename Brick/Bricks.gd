extends Node2D

func _ready():
	SignalBus.connect("reset_level", _reset)

func _reset():
	for child in get_children():
		if child.name != "BreakableTileMap":
			child.queue_free()
