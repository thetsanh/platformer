extends CanvasLayer

@onready var score_label: Label = $coin_score
@onready var message_label: Label = $message

func _ready() -> void:
	GameManager.save_level_start_score()
	GameManager.update_score_label()
