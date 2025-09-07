extends Area2D

@export var weapon_scene: PackedScene
@onready var dialog_label: Label = $"../CanvasLayer/sword"

var opened := false

func _ready():
	$AnimatedSprite2D.play("closed")
	body_entered.connect(_on_body_entered)
	dialog_label.visible = false  # hide dialogue at start

func _on_body_entered(body: Node):
	if opened or not body.is_in_group("player"):
		return
	opened = true

	# Open chest
	$AnimatedSprite2D.play("open")

	# Spawn floating sword
	_spawn_floating_sword(body)

func _spawn_floating_sword(player: Node):
	var weapon = weapon_scene.instantiate()
	get_parent().add_child(weapon)

	# Start at chest position
	weapon.global_position = global_position
	weapon.z_index = 10

	# Add sparkle effect (assumes your Sword scene has a Particles2D child)
	var particles = weapon.get_node_or_null("Particles2D")
	if particles:
		particles.emitting = true

	# Animate rising up
	var tween := create_tween()
	tween.tween_property(
		weapon, "global_position", 
		weapon.global_position + Vector2(0, -32), 
		0.6
	).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

	# Wait 2 seconds while it sparkles
	tween.tween_interval(2.0)

	# Then give sword to player
	tween.tween_callback(Callable(self, "_give_weapon_to_player").bind(player, weapon))

func _give_weapon_to_player(player: Node, weapon: Node):
	if weapon:
		weapon.queue_free()  # remove floating sword

	# Flag player as having weapon
	player.set("has_weapon", true)

	# Show dialogue
	_show_dialogue("You've obtained a basic sword!")

func _show_dialogue(text: String):
	dialog_label.text = text
	dialog_label.visible = true

	var tween := create_tween()
	tween.tween_interval(2.5)  # show for 2.5s
	tween.tween_callback(func(): dialog_label.visible = false)
