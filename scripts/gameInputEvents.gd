class_name GameInputEvents

static var direction: Vector2

static func movementInput() -> Vector2:
	if Input.is_action_pressed("walkUp"):
		direction = Vector2.UP
	elif Input.is_action_pressed("walkDown"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("walkLeft"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("walkRight"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
	return direction

static func isMovementInput() -> bool:
	return direction != Vector2.ZERO
