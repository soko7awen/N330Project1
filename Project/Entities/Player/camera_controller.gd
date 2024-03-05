extends Node3D

@export var mouse_sensitivity = 0.05

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
		#Camera Rotation
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity * -1))
			$"../".rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity * -1))
			var camera_rot = rotation_degrees
			camera_rot.x = clamp(camera_rot.x, -70, 70)
			rotation_degrees = camera_rot
