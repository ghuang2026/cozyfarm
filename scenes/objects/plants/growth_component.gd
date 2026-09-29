class_name GrowthComponent
extends Node

@export var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Germination
@export_range(5, 365) var days_until_harvest: int = 7

signal crop_maturity
signal crop_harvest

var is_watered: bool
var starting_day: int
var current_day: int

func _ready() -> void:
	DayNightManager.time_tick_day.connect(on_time_tick_day)

func on_time_tick_day(day: int) -> void:
	if is_watered:
		if !starting_day:
			starting_day = day
		growth_states(starting_day, day)
		harvest_state(starting_day, day)

func growth_states(starting_day: int, current_day:int):
	if(current_growth_state == DataTypes.GrowthStates.Mature):
		return
	
	var num_states = 5
	
	var growth_days_passed = (current_day - starting_day) % num_states
	var state_index = growth_days_passed % num_states + 1
	
	current_growth_state = state_index
	
	var name = DataTypes.GrowthStates.keys()[current_growth_state]
	print("current growth state: ", name, " state index: ", state_index)
	
	if current_growth_state == DataTypes.GrowthStates.Mature:
		crop_maturity.emit()

func harvest_state(starting_day: int, current_day: int) -> void:
	if current_growth_state == DataTypes.GrowthStates.Harvest:
		return
	
	var days_passed = (current_day - starting_day) % days_until_harvest
	
	if days_passed == days_until_harvest - 1:
		current_growth_state = DataTypes.GrowthStates.Harvest
		crop_harvest.emit()

func get_current_growth_state() -> DataTypes.GrowthStates:
	return current_growth_state
