extends NodeState

@export var player: Player
@export var animatedSprite2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	if !animatedSprite2d.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	if player.playerDirection == Vector2.UP:
		animatedSprite2d.play("waterBack")
	elif player.playerDirection == Vector2.LEFT:
		animatedSprite2d.play("waterLeft")
	elif player.playerDirection == Vector2.RIGHT:
		animatedSprite2d.play("waterRight")
	else:
		animatedSprite2d.play("waterFront")

func _on_exit() -> void:
	animatedSprite2d.stop()
