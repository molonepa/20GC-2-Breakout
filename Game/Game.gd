extends Node2D

var score : int = 0
var high_score : int = 0
var lives : int = 3

@onready var high_score_label : Label = $UI/HBoxContainer/HighScoreLabel
@onready var lives_label : Label = $UI/HBoxContainer/LivesLabel
@onready var score_label : Label = $UI/HBoxContainer/ScoreLabel

func _ready():
	_load_high_score()
	high_score_label.text = str(high_score)
	SignalBus.connect("breakable_tile_hit", _on_breakable_tile_hit)
	SignalBus.connect("breakable_tile_destroyed", _on_breakable_tile_destroyed)
	SignalBus.connect("ball_missed", _on_ball_missed)

func _process(_delta):
	if score > high_score:
		high_score = score

	_update_labels()

func _on_breakable_tile_hit(tile):
	tile.hit()

func _on_breakable_tile_destroyed():
	score += 1

func _on_ball_missed():
	lives -= 1

	if lives == 0:
		SignalBus.reset_level.emit()
		_reset()

func _reset():
	score = 0
	lives = 3
	_save_high_score()
	high_score_label.text = str(high_score)

func _update_labels():
	var lives_text = ""
	for i in range(lives):
		lives_text += "|"
	lives_label.text = lives_text

	score_label.text = str(score)

func _save_high_score():
	var high_score_file = FileAccess.open("user://high_score.txt", FileAccess.WRITE)
	high_score_file.store_string(str(high_score))

func _load_high_score():
	var high_score_file = FileAccess.open("user://high_score.txt", FileAccess.READ)
	high_score = int(high_score_file.get_as_text())
