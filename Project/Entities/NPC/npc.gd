extends CharacterBody3D

func _ready():
	pass

func _physics_process(_delta):
	var camera_pos = get_viewport().get_camera_3d().global_transform.origin
	var camera_distance = Vector2(position.x,position.z).distance_to(Vector2(camera_pos.x,camera_pos.z))
	if camera_distance > 1:
		look_at(Vector3(camera_pos.x,position.y,camera_pos.z))
	
