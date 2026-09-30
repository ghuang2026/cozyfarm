class_name  FieldCursorComponent
extends Node

@export var grass: TileMapLayer
@export var tilled_dirt: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 3

@onready var player: Player = get_tree().get_first_node_in_group("player")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("useItem"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			toggle_tilled_soil_tile()

func get_cell_under_mouse() -> void:
	mouse_position = grass.get_local_mouse_position() + Vector2(15, -10)
	cell_position = grass.local_to_map(mouse_position)
	cell_source_id = grass.get_cell_source_id(cell_position)
	local_cell_position = grass.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	print("mouse pos: ", mouse_position, ", cell pos: ", cell_position, ", cell source id: ", cell_source_id, ", distance: ", distance)
	print(player.global_position)

func toggle_tilled_soil_tile() -> void:
	if distance < 20.0 && cell_source_id != -1:
		if tilled_dirt.get_cell_source_id(tilled_dirt.local_to_map(mouse_position)) == 6:
			tilled_dirt.set_cells_terrain_connect([cell_position], 0, -1, true)
		else:	
			tilled_dirt.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)
