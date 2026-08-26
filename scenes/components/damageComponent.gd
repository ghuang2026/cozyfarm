class_name DamageComponent
extends Node2D

@export var maxDamage = 1
@export var curDamage = 0

signal maxDamageReached

func applyDamage(damage: int) -> void:
	curDamage = clamp(curDamage + damage, 0, maxDamage)
	
	if curDamage == maxDamage:
		maxDamageReached.emit()
