extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/LogInventory/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/StoneInventory/StoneLabel
@onready var wheat_label: Label = $MarginContainer/VBoxContainer/WheatInventory/WheatLabel
@onready var tomato_label: Label = $MarginContainer/VBoxContainer/TomatoInventory/TomatoLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/EggInventory/EggLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/MilkInventory/MilkLabel

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func int_to_string(int_quantity : int) -> String:
	var to_string : String = str(int_quantity)
	for i in range(3 - len(to_string)):
		to_string = "0" + to_string
	return to_string

func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if inventory.has("log"):
		log_label.text = int_to_string(inventory["log"])
	
	if inventory.has("stone"):
		stone_label.text = int_to_string(inventory["stone"])
	
	if inventory.has("wheat_spike"):
		wheat_label.text = int_to_string(inventory["wheat_spike"])
	
	if inventory.has("tomato_fruit"):
		tomato_label.text = int_to_string(inventory["tomato_fruit"])
	
	if inventory.has("chicken_egg"):
		egg_label.text = int_to_string(inventory["chicken_egg"])
	
	if inventory.has("milk_bottle"):
		milk_label.text = int_to_string(inventory["milk_bottle"])
