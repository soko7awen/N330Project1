extends Area3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:
	DialogueManager.show_dialogue_balloon_scene("res://menus/dialogue_balloon/balloon.tscn",dialogue_resource, dialogue_start)
