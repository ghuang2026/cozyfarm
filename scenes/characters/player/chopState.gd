extends NodeState

@export var player: Player
@export var animatedSprite2d: AnimatedSprite2D
@export var hitComponentCollisionShape: CollisionShape2D

func _ready() -> void:
	hitComponentCollisionShape.disabled = true
	hitComponentCollisionShape.position = Vector2(0, 0)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animatedSprite2d.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	if player.playerDirection == Vector2.UP:
		animatedSprite2d.play("chopBack")
		hitComponentCollisionShape.position = Vector2(0, -17)
	elif player.playerDirection == Vector2.LEFT:
		animatedSprite2d.play("chopLeft")
		hitComponentCollisionShape.position = Vector2(-8, -5)
	elif player.playerDirection == Vector2.RIGHT:
		animatedSprite2d.play("chopRight")
		hitComponentCollisionShape.position = Vector2(8, -5)
	else:
		animatedSprite2d.play("chopFront")
		hitComponentCollisionShape.position = Vector2(0, 1)
		
	hitComponentCollisionShape.disabled = false

func _on_exit() -> void:
	animatedSprite2d.stop()
	hitComponentCollisionShape.disabled = true
	hitComponentCollisionShape.position = Vector2(0, 0)
