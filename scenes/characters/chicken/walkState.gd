extends NodeState

@export var character : CharacterBody2D
@export var animatedSprite2d : AnimatedSprite2D
@export var navigationAgent2d : NavigationAgent2D
@export var minSpeed : float = 5.0
@export var maxSpeed : float = 10.0 

var rng = RandomNumberGenerator.new()
var speed: float

func _ready() -> void:
	call_deferred("characterSetup")
	

func characterSetup() -> void:
	await get_tree().physics_frame
	setMovementTarget()


func setMovementTarget() -> void:
	var targetPosition: Vector2 = NavigationServer2D.map_get_random_point(navigationAgent2d.get_navigation_map(), navigationAgent2d.navigation_layers, false)
	navigationAgent2d.target_position = targetPosition
	speed = rng.randf_range(minSpeed, maxSpeed)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if navigationAgent2d.is_navigation_finished():
		setMovementTarget()
		return
	
	var targetPosition: Vector2 = navigationAgent2d.get_next_path_position()
	var targetDirection: Vector2 = character.global_position.direction_to(targetPosition)
	animatedSprite2d.flip_h = targetDirection.x < 0
	character.velocity = speed * targetDirection
	character.move_and_slide()


func _on_next_transitions() -> void:
	if navigationAgent2d.is_navigation_finished():
		transition.emit("Walk")


func _on_enter() -> void:
	if randi() % 2:
		animatedSprite2d.play("Walk1")
	else:
		animatedSprite2d.play("Walk2")


func _on_exit() -> void:
	animatedSprite2d.stop()
