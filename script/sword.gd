extends Node2D

@export var damage := 25
@export var attack_cooldown := 0.4

var can_attack := true

func _process(delta):
	if Input.is_action_just_pressed("attack") and can_attack:
		_attack()

func _attack():
	can_attack = false
	print("Swing!")

	# Enable hitbox briefly
	$Hitbox.monitoring = true
	$Hitbox.collision_layer = 1  # adjust if needed
	$Hitbox.collision_mask = 1

	# Turn off after 0.2s
	await get_tree().create_timer(0.2).timeout
	$Hitbox.monitoring = false

	# Cooldown
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func _on_Hitbox_area_entered(area: Area2D):
	if area.has_method("take_damage"):
		area.take_damage(damage)
