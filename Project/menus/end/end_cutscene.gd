extends Control
@export var description_node: Node
@export var label_node: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameController.jester_score >= 5:
		description_node.text = "The king is impressed with you..."
		label_node.text = "Good End"
	if GameController.jester_score <= 0:
		description_node.text = "You fool..."
		label_node.text = "Worst End"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
