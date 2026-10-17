extends Node2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool
var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

func on_give_crop_seeds() -> void:
	ToolManager.enable_tool_button(DataTypes.Tools.TillGround)
	ToolManager.enable_tool_button(DataTypes.Tools.WaterCrop)
	ToolManager.enable_tool_button(DataTypes.Tools.PlantCorn)
	ToolManager.enable_tool_button(DataTypes.Tools.PlantTomato)

func _ready() -> void:
	interactable_component.interactableActivated.connect(on_interactable_activated)
	interactable_component.interactableDeactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	GameDialogueManager.give_crop_seeds.connect(on_give_crop_seeds)

func on_interactable_activated() -> void:
	in_range = true
	interactable_label_component.show()

func on_interactable_deactivated() -> void:
	in_range = false
	interactable_label_component.hide()

func _unhandled_input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("show_dialogue"):
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/conversations/guide.dialogue"), "start")
