class_name HurtComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal hurt

func _on_area_entered(area: Area2D) -> void:
	var hitComponent = area as HitComponent
	
	if tool == hitComponent.currentTool:
		hurt.emit(hitComponent.hitDamage)
