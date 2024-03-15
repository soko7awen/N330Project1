extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	GameController.player_movement = true

func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact"):
		var actionables = $ActionableFinder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func _input(event):
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var pause_menu_scene = load("res://menus/pause_menu/pause_menu.tscn").instantiate()
		get_tree().root.add_child(pause_menu_scene)
		get_tree().paused = true

func _physics_process(delta):
	if GameController.player_movement == true:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta
		# Handle jump.
		if Input.is_action_just_pressed("move_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		# Get the input direction and handle the movement/deceleration.
		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
