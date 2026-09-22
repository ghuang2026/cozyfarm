extends Control

@onready var day_label: Label = $DayTimeCounter/MarginContainer/Day
@onready var time_label: Label = $DayTimeCounter/MarginContainer/Time

@export var normal_speed: int = 10
@export var fast_speed: int = 100
@export var very_fast_speed: int = 200

func _ready() -> void:
	DayNightManager.time_tick.connect(on_time_tick)

func calculate_day(day:int):
	var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
	var days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	
	for i in range(months.size()):
		if day < days_in_months[i]:
			var day_of_month = day + 1
			return "%s %d" % [months[i], day_of_month]
		day -= days_in_months[i]

func on_time_tick(day:int, hour:int, minute:int) -> void:
	day_label.text = calculate_day(day)
	if minute % 10 == 0:
		time_label.text = "%02d:%02d" % [hour, minute]

func _on_normal_speed_button_pressed() -> void:
	DayNightManager.game_speed = normal_speed

func _on_fast_speed_button_pressed() -> void:
	DayNightManager.game_speed = fast_speed

func _on_very_fast_speed_button_pressed() -> void:
	DayNightManager.game_speed = very_fast_speed
