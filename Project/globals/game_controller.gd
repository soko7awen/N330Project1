extends Node
var player_movement = false
var state = null
var state_node = null
var jester_points

func _process(_delta):
	if state != null:
		if state == 'riddle_success':
			get_node('../main/'+state_node).collision_layer = 0
		elif state == 'shuffle_minigame':
			print(get_node('../main/'+state_node))
		elif state == 'strength_minigame':
			print(get_node('../main/'+state_node))
		elif state == 'boss_minigame':
			print(get_node('../main/'+state_node))
		state = null

func set_player_movement(value: bool):
	if value == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		await get_tree().create_timer(.1).timeout
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	player_movement = value
