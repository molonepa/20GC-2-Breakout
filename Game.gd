extends Node2D

var score : int = 0

@onready var score_label : Label = $UI/HBoxContainer/ScoreLabel

func _ready():
	SignalBus.connect("breakable_tile_hit", _on_breakable_tile_hit)
	SignalBus.connect("breakable_tile_destroyed", _on_breakable_tile_destroyed)

func _on_breakable_tile_hit(tile):
	tile.hit()

func _on_breakable_tile_destroyed():
	score += 100
	score_label.text = "SCORE: %d" % score 
