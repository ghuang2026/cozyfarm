class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent
@export var currentTool: DataTypes.Tools = DataTypes.Tools.None

var playerDirection: Vector2

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)

func on_tool_selected(tool: DataTypes.Tools) -> void:
	currentTool = tool
	hit_component.currentTool = tool
	print("current tool id is ", tool)
