extends Node2D

var score : int = 0
var lives : int = 3

@onready var score_label : Label = $UI/HBoxContainer/ScoreLabel
@onready var lives_label : Label = $UI/HBoxContainer/LivesLabel

func _ready():
	SignalBus.connect("breakable_tile_hit", _on_breakable_tile_hit)
	SignalBus.connect("breakable_tile_destroyed", _on_breakable_tile_destroyed)
	SignalBus.connect("ball_missed", _on_ball_missed)

func _on_breakable_tile_hit(tile):
	tile.hit()

func _on_breakable_tile_destroyed():
	score += 1
	score_label.text = "SCORE: %d" % score

func _on_ball_missed():
	lives -= 1

	if lives == 0:
		SignalBus.reset_level.emit()
		_reset()

	lives_label.text = "LIVES: %d" % lives

func _reset():
	score = 0
	score_label.text = "SCORE: %d" % score

	lives = 3
	lives_label.text = "LIVES: %d" % lives
