extends Sprite2D

@onready var damageComponent: DamageComponent = $damageComponent
@onready var hurtComponent: HurtComponent = $HurtComponent

var logScene = preload("res://scenes/objects/tree/log.tscn")

func _ready() -> void:
	hurtComponent.hurt.connect(onHurt)
	damageComponent.maxDamageReached.connect(onMaxDamageReached)

func onHurt(hit: int) -> void:
	print("hit")
	damageComponent.applyDamage(hit)
	material.set_shader_parameter("shakeIntensity", 0.8)
	await get_tree().create_timer(.4).timeout
	material.set_shader_parameter("shakeIntensity", 0.0)

func onMaxDamageReached() -> void:
	call_deferred("addLogScene")
	print("no more hp")
	queue_free()

func addLogScene() -> void:
	var logInstance = logScene.instantiate() as Node2D
	logInstance.global_position = global_position.move_toward(Vector2(global_position.x, global_position.y + 20), 20)
	get_parent().add_child(logInstance)
