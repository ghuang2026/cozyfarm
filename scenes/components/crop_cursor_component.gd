class_name CropsCursorComponent
extends Node

@export var tilled_dirt: TileMapLayer

@onready var player: Player = get_tree().get_first_node_in_group("player")

var tomato_crop = preload("res://scenes/objects/plants/tomato_crop.tscn")
var wheat_crop = preload("res://scenes/objects/plants/wheat_crop.tscn")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("useItem"):
		if ToolManager.selected_tool == DataTypes.Tools.PlantWheat or ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
			get_cell_under_mouse()
			add_crop()

func get_cell_under_mouse() -> void:
	mouse_position = tilled_dirt.get_local_mouse_position() + Vector2(15, -10)
	cell_position = tilled_dirt.local_to_map(mouse_position)
	cell_source_id = tilled_dirt.get_cell_source_id(cell_position)
	local_cell_position = tilled_dirt.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	print("mouse pos: ", mouse_position, ", cell pos: ", cell_position, ", cell source id: ", cell_source_id, ", distance: ", distance)
	print(player.global_position)

func add_crop() -> void:
	if distance < 20.0:
		if ToolManager.selected_tool == DataTypes.Tools.PlantWheat:
			var wheat_instance = wheat_crop.instantiate() as Node2D
			wheat_instance.global_position = local_cell_position
			get_parent().find_child("CropField").add_child(wheat_instance)
		elif ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
			var tomato_instance = tomato_crop.instantiate() as Node2D
			tomato_instance.global_position = local_cell_position
			get_parent().find_child("CropField").add_child(tomato_instance)
