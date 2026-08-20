extends StaticBody2D

@onready var collisionShape2d: CollisionShape2D = $CollisionShape2D
@onready var interactableComponent: Area2D = $InteractableComponent
@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	interactableComponent.interactableActivated.connect(on_interactable_activated)
	interactableComponent.interactableDeactivated.connect(on_interactable_deactivated)
	collision_layer = 1

func on_interactable_activated () -> void:
	animatedSprite2d.play("openDoor")
	collision_layer = 2
	print("open door")

func on_interactable_deactivated () -> void:
	animatedSprite2d.play("closeDoor")
	collision_layer = 1
	print("close door")
