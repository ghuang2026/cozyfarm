extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_hoe: Button = $MarginContainer/HBoxContainer/ToolHoe
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var seed_corn: Button = $MarginContainer/HBoxContainer/SeedCorn
@onready var seed_tomato: Button = $MarginContainer/HBoxContainer/SeedTomato

func on_enable_tool_button(tool: DataTypes.Tools) -> void:
	if tool == DataTypes.Tools.TillGround:
		tool_hoe.disabled = false
		tool_hoe.focus_mode = Control.FOCUS_ALL
	
	if tool == DataTypes.Tools.WaterCrop:
		tool_watering_can.disabled = false
		tool_watering_can.focus_mode = Control.FOCUS_ALL
	
	if tool == DataTypes.Tools.PlantCorn:
		seed_corn.disabled = false
		seed_corn.focus_mode = Control.FOCUS_ALL
	
	if tool == DataTypes.Tools.PlantTomato:
		seed_tomato.disabled = false
		seed_tomato.focus_mode = Control.FOCUS_ALL

func _ready() -> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)
	
	tool_hoe.disabled = true
	tool_hoe.focus_mode = Control.FOCUS_NONE
	
	tool_watering_can.disabled = true
	tool_watering_can.focus_mode = Control.FOCUS_NONE
	
	seed_corn.disabled = true
	seed_corn.focus_mode = Control.FOCUS_NONE
	
	seed_tomato.disabled = true
	seed_tomato.focus_mode = Control.FOCUS_NONE

func _on_tool_axe_pressed() -> void:
	if ToolManager.selected_tool == DataTypes.Tools.ChopWood:
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_axe.release_focus()
	else:
		ToolManager.select_tool(DataTypes.Tools.ChopWood)
		tool_axe.grab_focus()

func _on_tool_hoe_pressed() -> void:
	if ToolManager.selected_tool == DataTypes.Tools.TillGround:
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_hoe.release_focus()
	else:
		ToolManager.select_tool(DataTypes.Tools.TillGround)
		tool_hoe.grab_focus()

func _on_tool_watering_can_pressed() -> void:
	if ToolManager.selected_tool == DataTypes.Tools.WaterCrop:
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_watering_can.release_focus()
	else:
		ToolManager.select_tool(DataTypes.Tools.WaterCrop)
		tool_watering_can.grab_focus()

func _on_seed_corn_pressed() -> void:
	if ToolManager.selected_tool == DataTypes.Tools.PlantCorn:
		ToolManager.select_tool(DataTypes.Tools.None)
		seed_corn.release_focus()
	else:
		ToolManager.select_tool(DataTypes.Tools.PlantCorn)
		seed_corn.grab_focus()

func _on_seed_tomato_pressed() -> void:
	if ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
		ToolManager.select_tool(DataTypes.Tools.None)
		seed_tomato.release_focus()
	else:
		ToolManager.select_tool(DataTypes.Tools.PlantTomato)
		seed_tomato.grab_focus()
