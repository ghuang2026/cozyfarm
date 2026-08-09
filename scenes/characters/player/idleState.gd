extends NodeState

@export var player: Player
@export var animatedSprite2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if player.playerDirection == Vector2.UP:
		animatedSprite2d.play("idleBack")
	elif player.playerDirection == Vector2.LEFT:
		animatedSprite2d.play("idleLeft")
	elif player.playerDirection == Vector2.RIGHT:
		animatedSprite2d.play("idleRight")
	else:
		animatedSprite2d.play("idleFront")

func _on_next_transitions() -> void:
	GameInputEvents.movementInput()
	
	if GameInputEvents.isMovementInput():
		transition.emit("Walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animatedSprite2d.stop()
