extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_hoe: Button = $MarginContainer/HBoxContainer/ToolHoe
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var seed_corn: Button = $MarginContainer/HBoxContainer/SeedCorn
@onready var seed_tomato: Button = $MarginContainer/HBoxContainer/SeedTomato


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
