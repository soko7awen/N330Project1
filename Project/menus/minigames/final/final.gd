extends Control
@export var card_scene: PackedScene
var caller = null
var level = 0
var card_count = 3
var input_ready = false
var started = false
var card_starred = 2
var markers_used = []
var cards_landing = []
var cards_finished = []
var strength_ready = false
var strength_started = false
var ticks = 0
var enemy_slowness = 16
var enemy_speed = 37
var player_strength = 450
var space_presses = []
var strength_position = Vector2.ZERO
signal ended(node,caller,winlose,score)

func _ready():
	for i in card_count:
		var card_node = card_scene.instantiate()
		card_node.index = i
		card_node.position = $Markers.get_child(i).position
		card_node.texture = load("res://menus/minigames/common/card-red-blank.png")
		if i == 0:
			card_node.get_node('Label').text = "A cake"
		if i == 1:
			card_node.get_node('Label').text = "A car"
		if i == 2:
			card_node.get_node('Label').text = "A coffin"
		card_node.get_node('AnimationPlayer').seek(randf_range(0,1))
		$Cards.add_child(card_node)
		card_node.connect('timeout',_on_timer_timeout)
		card_node.connect('pressed',_on_card_pressed)
	await get_tree().create_timer(1).timeout
	input_ready = true

func _input(event):
	if input_ready and !started and (event is InputEventKey or event is InputEventMouseButton):
		for i in $Cards.get_children():
			i.get_node('AnimationPlayer').play("flip")
		await get_tree().create_timer(1.6).timeout
		for i in $Cards.get_children():
			i.get_node('AnimationPlayer').play("Card"+str(i.index))
			i.get_node('Timer').start(randf_range(6,8))
		started = true
	if strength_ready and event.is_action_pressed("move_jump") and !strength_started:
			var the_card = $Cards.get_child(card_starred)
			strength_position = the_card.position
			the_card.position.y += player_strength/4
			#$Hands/AnimationPlayer.play("shake")
			strength_started = true
	

func _process(delta):
	for i in cards_landing:
		if round(i[0].position) != round(i[1]):
			i[0].position = lerp(i[0].position,i[1],.1)
		else:
			cards_landing.remove_at(cards_landing.find(i))
			cards_finished.append(i)
			if cards_finished.size() == card_count:
				make_selectable()
	if strength_started:
		var the_card = $Cards.get_child(card_starred)
		if the_card.position.y <= strength_position.y-300:
			print('lose')
		elif the_card.position.y >= strength_position.y+400:
			print('win')
			ended.emit(self,caller,'win',0)
		if Input.is_action_just_pressed("move_jump"):
			space_presses.append(1)
		if ticks <= enemy_slowness:
			ticks += 60 * delta
		else:
			if space_presses.size() >= 2:
				the_card.position.y += player_strength * delta
				space_presses = []
			ticks = 0
		the_card.position.y -= enemy_speed*2 * delta
	
func _on_timer_timeout(index):
	var card = $Cards.get_child(index)
	card.get_node('AnimationPlayer').pause()
	var marker_dist_x
	var closest_marker
	var closest_marker_dist_x
	for i in $Markers.get_children():
		if markers_used.find(i) == -1:
			marker_dist_x = abs(card.position.x - i.position.x)
			if closest_marker == null or marker_dist_x < closest_marker_dist_x:
				closest_marker = i
				closest_marker_dist_x = marker_dist_x
	markers_used.append(closest_marker)
	cards_landing.append([card,closest_marker.position])

func _on_card_pressed(index):
	var anim_player = $Cards.get_child(index).get_node('AnimationPlayer')
	if index == card_starred:
		anim_player.play('unflip_space')
	else:
		anim_player.play('unflip_blank')
	for i in $Cards.get_children():
		i.get_node('Button').mouse_filter = MOUSE_FILTER_IGNORE
		i.get_node('Button').focus_mode = FOCUS_NONE
	await get_tree().create_timer(2).timeout
	if index == card_starred:
		strength_ready = true
	else:
		ended.emit(self,caller,"lose",0)

func make_selectable():
	for i in $Cards.get_children():
		i.get_node('Button').show()

