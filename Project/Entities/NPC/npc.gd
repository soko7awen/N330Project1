extends CharacterBody3D

func _ready():
	pass

func _process(_delta):
	#var camera_pos = get_viewport().get_camera_3d().global_transform.origin
	#look_at(Vector3(camera_pos.x,0,camera_pos.z), Vector3(0, 1, 0))
	pass

func _on_interact_area_body_entered(body):
	if body is player:
		DialogueManager.show_dialogue_balloon(load("res://Entities/NPC/TestPenguin/test.dialogue"), "test")
