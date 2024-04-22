extends Control
@export var card_scene: PackedScene
var caller = null
var level = 2
var card_count = 0
var started = false
var card_starred = 0
var markers_used = []
var cards_landing = []
var cards_finished = []
signal ended(node,caller,winlose,score)

func _ready():
	if level == 1:
		card_count = 3
	if level == 2:
		card_count = 5
	card_starred = randi_range(0,card_count-1)
	for i in card_count:
		var card_node = card_scene.instantiate()
		card_node.index = i
		card_node.position = $Markers.get_child(i).position
		if i == card_starred:
			card_node.texture = load("res://menus/minigames/shuffle/card-red-king.png")
		card_node.get_node('AnimationPlayer').seek(randf_range(0,1))
		$Cards.add_child(card_node)
		card_node.connect('timeout',_on_timer_timeout)
		card_node.connect('pressed',_on_card_pressed)

func _input(event):
	if !started and (event is InputEventKey or event is InputEventMouseButton):
		for i in $Cards.get_children():
			i.get_node('AnimationPlayer').play("flip")
		#await $Cards.get_child(get_children().size()-1).get_node('AnimationPlayer').animation_finished
		await get_tree().create_timer(1.6).timeout
		for i in $Cards.get_children():
			i.get_node('AnimationPlayer').play("Card"+str(i.index))
			i.get_node('Timer').start(randf_range(6,8))
		started = true

func _process(delta):
	for i in cards_landing:
		i[0].position = lerp(i[0].position,i[1],.1)
		if round(i[0].position) == round(i[1]):
			cards_finished.append(i)
			if cards_finished.size() == card_count:
				make_selectable()
	
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
		anim_player.play('unflip_king')
	else:
		anim_player.play('unflip')
	for i in $Cards.get_children():
		i.get_node('Button').mouse_filter = MOUSE_FILTER_IGNORE
		i.get_node('Button').focus_mode = FOCUS_NONE
	await get_tree().create_timer(1).timeout
	for i in $Cards.get_children():
		i.get_node('Button').hide()
	await get_tree().create_timer(2).timeout
	if index == card_starred:
		ended.emit(self,caller,"win",level)
	else:
		ended.emit(self,caller,"lose",-1*level)

func make_selectable():
	for i in $Cards.get_children():
		i.get_node('Button').show()

