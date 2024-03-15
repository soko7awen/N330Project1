extends Node
var player_movement = false
var state = null
var stateNode = null

func _process(_delta):
	if state != null:
		if state == 'riddle_success':
			get_node('../main/'+stateNode).collision_layer = 0
		elif state == 'strength_minigame':
			print(get_node('../main/'+stateNode))
		state = null

func set_player_movement(value: bool):
	if value == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		await get_tree().create_timer(.1).timeout
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	player_movement = value
