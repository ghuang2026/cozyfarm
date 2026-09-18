extends NodeState

@export var player: Player
@export var animatedSprite2d: AnimatedSprite2D

var not_on_ui : bool = false

func _on_process(_delta : float) -> void:
	if not Input.is_action_pressed("useItem"):
		not_on_ui = false

func _unhandled_input(event):
	if event.is_action_pressed("useItem"):
		not_on_ui = true

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
	
	if not_on_ui:
		if GameInputEvents.useItem():	
			if player.currentTool == DataTypes.Tools.ChopWood:
				transition.emit("Chop")
				
			elif player.currentTool == DataTypes.Tools.TillGround:
				transition.emit("Till")
			
			elif player.currentTool == DataTypes.Tools.WaterCrop:
				transition.emit("Water")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animatedSprite2d.stop()
