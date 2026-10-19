class_name CollectableComponent
extends Area2D

@export var itemTag: String

func _onBodyEntered(body: Node2D) -> void:
	if body is Player and !get_parent().is_in_group("no_collection"):
		InventoryManager.add_collectable(itemTag)
		print("collected " + itemTag)
		get_parent().queue_free()
