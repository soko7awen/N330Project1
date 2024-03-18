extends Sprite2D
var index: int
signal pressed(i)
signal timeout(i)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	pressed.emit(index)

func _on_timeout():
	timeout.emit(index)

func _on_button_focus_entered():
	z_index += 1
func _on_button_focus_exited():
	z_index -= 1
