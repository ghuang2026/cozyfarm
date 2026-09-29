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

func _process(delta:float) -> void:
	growth_state = growth_component.get_current_growth_state()
	wheat_sprite.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Mature:
		flowering_particles.emitting = true

func on_hurt(hit_damage: int) -> void:
	if !growth_component.is_watered:
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		growth_component.is_watered = true

func on_crop_maturity() -> void:
	flowering_particles.emitting = true
