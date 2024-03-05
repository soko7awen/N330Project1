extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Unpause.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_unpause_pressed():
	get_tree().paused = false
	if GameController.player_movement == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()
