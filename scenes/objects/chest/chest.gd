extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

var wheat_harvest_scene = preload("res://scenes/objects/plants/wheat.tscn")
var tomato_harvest_scene = preload("res://scenes/objects/plants/tomato.tscn")

@export var dialogue_start_command: String
@export var food_drop_height: int = 40
@export var reward_drop_radius: int = 20
@export var output_reward_scene: Array[PackedScene] = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var feed_component: FeedComponent = $FeedComponent

var in_range: bool
var is_chest_open: bool

func _ready() -> void:
	in_range = false
	is_chest_open = false
	interactable_component.interactableActivated.connect(on_interactable_activated)
	interactable_component.interactableDeactivated.connect(on_interactable_deactivated)
	GameDialogueManager.feed_animals.connect(on_feed_animals)
	feed_component.food_received.connect(on_food_received)

func on_interactable_activated() -> void:
	in_range = true

func on_interactable_deactivated() -> void:
	in_range = false
	if is_chest_open:
		animated_sprite_2d.play("chest_close")
	is_chest_open = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("show_dialogue"):
		animated_sprite_2d.play("chest_open")
		is_chest_open = true
		
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/conversations/chest.dialogue"), dialogue_start_command)

func on_feed_animals() -> void:
	if in_range:
		trigger_feed_harvest("wheat", wheat_harvest_scene)

func trigger_feed_harvest(inventory_item:String, scene:Resource) -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if !inventory.has(inventory_item):
		return
	
	var inventory_item_count = inventory[inventory_item]
	
	for index in inventory_item_count:
		var harvest_scene = scene.instantiate() as Node2D
		harvest_scene.global_position = Vector2(global_position.x, global_position.y - food_drop_height)
		get_tree().root.add_child(harvest_scene)
		harvest_scene.add_to_group("no_collection")
		var target_position = global_position
		
		var time_delay = randf_range(.5, 2.0)
		await get_tree().create_timer(time_delay).timeout
		
		var tween = get_tree().create_tween()
		tween.tween_property(harvest_scene, "position", target_position, 1.0)
		tween.tween_property(harvest_scene, "scale", Vector2(.5, .5), 1.0)
		tween.tween_callback(harvest_scene.queue_free)
		
		InventoryManager.remove_collectable(inventory_item)

func on_food_received(area:Area2D) -> void:
	call_deferred("add_reward_scene")

func add_reward_scene() -> void:
	for scene in output_reward_scene:
		var reward_scene: Node2D = scene.instantiate()
		var reward_position: Vector2i = random_position_in_circle(global_position, reward_drop_radius)
		reward_scene.global_position = reward_position
		get_tree().root.add_child(reward_scene)
		

func random_position_in_circle(center:Vector2, radius:int) -> Vector2i:
	var angle = randf() * TAU
	
	var distance_from_center = sqrt(randf()) * radius
	
	var x: int = center.x + distance_from_center * cos(angle)
	var y: int = center.y + distance_from_center * sin(angle)
	
	return Vector2i(x, y)
