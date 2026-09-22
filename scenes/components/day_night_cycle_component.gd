class_name DayNightCycleComponent
extends CanvasModulate

@export var initial_day: int = 0:
	set(id):
		initial_day = id
		DayNightManager.initial_day = id
		DayNightManager.set_initial_time()

@export var initial_hour: int = 0:
	set(ih):
		initial_hour = ih
		DayNightManager.initial_hour = ih
		DayNightManager.set_initial_time()

@export var initial_minute: int = 0:
	set(im):
		initial_minute = im
		DayNightManager.initial_minute = im
		DayNightManager.set_initial_time()

@export var time_cast_shadow_texture: GradientTexture1D

func _ready() -> void:
	DayNightManager.initial_day = initial_day
	DayNightManager.initial_hour = initial_hour
	DayNightManager.initial_minute = initial_minute
	DayNightManager.set_initial_time()
	
	DayNightManager.game_time.connect(on_game_time)

func on_game_time(time:float) -> void:
	var sample_value = .5 * (sin(time - PI * .5) + 1)
	color = time_cast_shadow_texture.gradient.sample(sample_value)
