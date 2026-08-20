class_name InteractableComponent
extends Area2D

signal interactableActivated
signal interactableDeactivated

func _on_body_entered(body: Node2D) -> void:
	interactableActivated.emit()

func _on_body_exited(body: Node2D) -> void:
	interactableDeactivated.emit()
