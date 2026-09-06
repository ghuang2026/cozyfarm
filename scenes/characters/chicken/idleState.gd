extends NodeState

@export var character: CharacterBody2D
@export var animatedSprite2d: AnimatedSprite2D
@export var idleStateTimeInterval: Array = [4, 6];

@onready var idleStateTimer : Timer = Timer.new()

var rng = RandomNumberGenerator.new()
var idleStateTimeout: bool = false

func _ready() -> void:
	idleStateTimer.wait_time = rng.randf_range(idleStateTimeInterval[0], idleStateTimeInterval[1])
	idleStateTimer.timeout.connect(onIdleStateTimeout)
	add_child(idleStateTimer)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if idleStateTimeout:
		transition.emit("Walk")


func _on_enter() -> void:
	animatedSprite2d.play("Idle")
	
	idleStateTimeout = false
	idleStateTimer.start()

func _on_exit() -> void:
	animatedSprite2d.stop()
	idleStateTimer.stop()

func onIdleStateTimeout() -> void:
	idleStateTimeout = true
