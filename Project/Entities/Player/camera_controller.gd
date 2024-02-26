extends Node3D

@export var mouse_sensitivity = 0.05
var mouse_capturable

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_capturable = true

func _input(event):
	#Mouse Capture
	if event.is_action_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if GameController.movement == true and mouse_capturable == true:
		if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)) and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#Camera Rotation
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_x(deg_to_rad(event.relative.y * mouse_sensitivity * -1))
			$"../".rotate_y(deg_to_rad(event.relative.x * mouse_sensitivity * -1))
			var camera_rot = rotation_degrees
			camera_rot.x = clamp(camera_rot.x, -70, 70)
			rotation_degrees = camera_rot
