extends Area2D
const FILE_BEGIN = "res://levels/level"

@onready var lock_sprite: Sprite2D = $lock_sprite
@onready var message_label: Label = get_tree().get_first_node_in_group("message_ui")


func _ready():
	lock_sprite.visible = true
	message_label.visible = false

func unlock_door():
	lock_sprite.visible = false
	print("Door unlocked!")

func _on_body_entered(body: Node2D) -> void:
	print("Portal touched by:", body.name, "has_key =", body.has_key)
	if body.is_in_group("player"):
		if body.has_key:
			print("Door is open! Going to next level...")
			var curr_scene_file = get_tree().current_scene.scene_file_path
			var next_lvl = curr_scene_file.to_int() + 1
			var next_lvl_path = FILE_BEGIN + str(next_lvl) + ".tscn"
			get_tree().change_scene_to_file(next_lvl_path)
		else:
			show_message("Door is locked! Find the key.")


func _on_key_key_picked_up() -> void:
	unlock_door()
	
func show_message(text: String) -> void:
	message_label.text = text
	message_label.visible = true
	await get_tree().create_timer(2.0).timeout
	message_label.visible = false
