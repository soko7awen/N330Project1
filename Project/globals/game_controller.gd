extends Node
var player_movement = false

func set_player_movement(value: bool):
	if value == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		await get_tree().create_timer(.1).timeout
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	player_movement = value
