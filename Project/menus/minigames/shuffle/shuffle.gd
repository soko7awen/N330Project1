extends Control
var card_starred = 0
var markers_used = []
var cards_landing = []

func _ready():
	card_starred = randi_range(0,4)
	for i in $Cards.get_children():
		if i.get_index() == card_starred:
			i.texture = load("res://menus/minigames/shuffle/card-red-king.png")
		i.get_node('AnimationPlayer').seek(randf_range(0,1))
		i.get_node('AnimationPlayer').play(i.name)
		i.get_node('Timer').start(randf_range(6,8))

func _process(delta):
	for i in cards_landing:
		i[0].position = lerp(i[0].position,i[1],.1)
	
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

func _on_animation_finished(index):
	pass
func _on_timer0_timeout():
	_on_timer_timeout(0)
func _on_timer1_timeout():
	_on_timer_timeout(1)
func _on_timer2_timeout():
	_on_timer_timeout(2)
func _on_timer3_timeout():
	_on_timer_timeout(3)
func _on_timer4_timeout():
	_on_timer_timeout(4)
func _on_animation0_finished(_anim_name):
	_on_animation_finished(0)
func _on_animation1_finished(_anim_name):
	_on_animation_finished(1)
func _on_animation2_finished(_anim_name):
	_on_animation_finished(2)
func _on_animation3_finished(_anim_name):
	_on_animation_finished(3)
func _on_animation4_finished(_anim_name):
	_on_animation_finished(4)
