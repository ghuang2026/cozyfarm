extends Node2D

var wheat_harvest_scene = preload("res://scenes/objects/plants/wheat.tscn")

@onready var flowering_particles: GPUParticles2D = $FloweringParticles
@onready var watering_particles: GPUParticles2D = $WateringParticles
@onready var wheat_sprite: Sprite2D = $WheatSprite
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var growth_component: GrowthComponent = $GrowthComponent

var growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Germination

func _ready() -> void:
	watering_particles.emitting = false
	flowering_particles.emitting = false
	
	hurt_component.hurt.connect(on_hurt)
	growth_component.crop_maturity.connect(on_crop_maturity)
	growth_component.crop_harvest.connect(on_max_maturity)

func _process(delta:float) -> void:
	growth_state = growth_component.get_current_growth_state()
	wheat_sprite.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Mature:
		flowering_particles.emitting = true

func on_hurt(hit_damage: int) -> void:
	if !growth_component.is_watered:
		print("watering")
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		growth_component.is_watered = true

func on_crop_maturity() -> void:
	flowering_particles.emitting = true

func on_max_maturity() -> void:
	call_deferred("on_crop_harvesting")
	print("matured")
	queue_free()

func on_crop_harvesting() -> void:
	for i in range(3):
		var wheat_harvest = wheat_harvest_scene.instantiate() as Node2D
		wheat_harvest.global_position = global_position.move_toward(
			Vector2(global_position.x + randf_range(-10.0, 10.0), 
					global_position.y + randf_range(-10.0, 10.0) + 20),
			20)
		get_parent().add_child(wheat_harvest)
