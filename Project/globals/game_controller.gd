extends Node
var player_movement = false
var state = {
	'node': null,
	'event': null,
	'level': 1
	}
var jester_score = 0

func _process(_delta):
	if state.event != null:
		if state.event == 'riddle_won':
			print('won')
			state_clear()
		elif state.event == 'riddle_lose':
			print('lose')
			state_clear()
		elif state.event == 'shuffle_minigame':
			print(get_node('../main/'+state.node))
			state_clear()
		elif state.event == 'strength_minigame':
			if player_movement == true:
				set_player_movement(false)
				var minigame_node = load("res://menus/minigames/strength/strength.tscn").instantiate()
				minigame_node.level = state.level
				$/root/main/CanvasLayer.add_child(minigame_node)
				minigame_node.ended.connect(_on_minigame_ended)
				print(get_node('../main/'+state.node))
				state_clear()
		elif state.event == 'boss_minigame':
			print(get_node('../main/'+state.node))
			state_clear()


func set_player_movement(value: bool):
	if value == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		await get_tree().create_timer(.1).timeout
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	player_movement = value
	
func _on_minigame_ended(node):
	node.queue_free()
	
func state_clear():
	state.node = null
	state.event = null
	state.level = 1
