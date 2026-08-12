extends NodeState

@export var player: Player
@export var animatedSprite2d: AnimatedSprite2D
@export var walkSpeed: int = 50

var direction: Vector2

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = GameInputEvents.movementInput()
	
	if direction == Vector2.UP:
		animatedSprite2d.play("walkBack")
	elif direction == Vector2.DOWN:
		animatedSprite2d.play("walkFront")
	elif direction == Vector2.LEFT:
		animatedSprite2d.play("walkLeft")
	elif direction == Vector2.RIGHT:
		animatedSprite2d.play("walkRight")
	
	if direction != Vector2.ZERO:
		player.playerDirection = direction
	
	player.velocity = direction * walkSpeed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvents.isMovementInput():
		transition.emit("Idle") 


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animatedSprite2d.stop()
