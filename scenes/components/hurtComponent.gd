class_name HurtComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal onHurt

func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
