extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	print("You died!")

	# Optional slow-motion effect
	Engine.time_scale = 0.5

	# Disable player so it can't move/jump
	#body.set_process(false)
	#body.set_physics_process(false)
	body.get_node("CollisionShape2D").queue_free()

	# Update game manager
	GameManager.reset_to_level_start()
	GameManager.update_score_label()

	# Start timer to reset level
	timer.start()

func _on_timer_timeout():
	# Reset time scale before reloading
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
