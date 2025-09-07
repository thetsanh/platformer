extends Node2D   # or CharacterBody2D if using physics

const SPEED = 20
var direction = 1

@onready var ray_right = $Killzone/RayCastRight
@onready var ray_left = $Killzone/RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	# flip direction if ray hits something
	if ray_right.is_colliding():
		direction = -1
	elif ray_left.is_colliding():
		direction = 1

	# flip sprite
	animated_sprite.flip_h = direction == -1

	# move
	translate(Vector2(direction * SPEED * delta, 0))
