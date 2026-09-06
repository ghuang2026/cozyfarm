extends NPC

func _ready() -> void:
	walkCycles = randi_range(minWalkCycle, maxWalkCycle)
