extends Sprite2D

@onready var damageComponent: DamageComponent = $damageComponent
@onready var hurtComponent: HurtComponent = $HurtComponent

var stoneScene = preload("res://scenes/objects/rock/stone.tscn")

func _ready() -> void:
	hurtComponent.hurt.connect(onHurt)
	damageComponent.maxDamageReached.connect(onMaxDamageReached)

func onHurt(hit:int) -> void:
	print('hit')
	damageComponent.applyDamage(hit)
	material.set_shader_parameter("shakeIntensity", 0.3)
	await get_tree().create_timer(.6).timeout
	material.set_shader_parameter("shakeIntensity", 0.0)

func onMaxDamageReached() -> void:
	call_deferred("addStoneScene")
	print('no more hp')
	queue_free()

func addStoneScene() -> void:
	var stoneInstance = stoneScene.instantiate() as Node2D
	stoneInstance.global_position = global_position.move_toward(Vector2(global_position.x, global_position.y + 20), 20)
	get_parent().add_child(stoneInstance)
