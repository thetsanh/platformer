extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body):
	GameManager.add_points()
	animation_player.play("pickup")
