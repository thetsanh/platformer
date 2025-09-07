extends Node

var score: int = 0
var level_start_score: int = 0
var score_label: Label

func update_score_label():
	score_label = get_tree().get_first_node_in_group("coin_ui")
	if score_label:
		update_score()

func add_points():
	score += 1
	update_score()

func update_score():
	if score_label:
		score_label.text = "Coin: " + str(score)

func save_level_start_score():
	level_start_score = score

func reset_to_level_start():
	score = level_start_score
	update_score()
