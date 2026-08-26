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

func onMaxDamageReached() -> void:
	call_deferred("addLogScene")
	print("no more hp")
	queue_free()

func addLogScene() -> void:
	var logInstance = logScene.instantiate() as Node2D
	logInstance.global_position = global_position.move_toward(Vector2(global_position.x, global_position.y + 20), 20)
	get_parent().add_child(logInstance)
