class_name CollectableComponent
extends Area2D

@export var itemTag: String

func _onBodyEntered(body: Node2D) -> void:
	if body is Player:
		print("collected " + itemTag)
		get_parent().queue_free()
