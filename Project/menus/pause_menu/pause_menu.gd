extends CanvasLayer
var unpause_cooldown = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Unpause.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("pause") and unpause_cooldown == false:
		unpause_cooldown = true
	if unpause_cooldown == true and Input.is_action_pressed("pause"):
		_on_unpause_pressed()


func _on_unpause_pressed():
	get_tree().paused = false
	if GameController.player_movement == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()
