@tool
extends Node2D
class_name TreasureChest

@export var item_data: ItemData : set = set_item_data
@export var quantity: int = 1: set = set_quantity

var is_open: bool = false

@onready var sprite_2d = $ItemSprite
@onready var area_2d = $Area2D
@onready var animation_player = $AnimationPlayer
@onready var label = $ItemSprite/Label
@onready var is_open_data: PersistantDataHandler = $IsOpen

func _ready():
	update_texture()
	update_label()
	if Engine.is_editor_hint():
		return
	is_open_data.data_loaded.connect(_on_is_open_data_loaded)
	_on_is_open_data_loaded()
	
func set_item_data(value: ItemData) -> void:
	item_data = value
	update_texture()
	

func set_quantity(value: int) -> void:
	quantity = value
	update_label()
	

func update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
		

func update_label() -> void:
	if label:
		if quantity <= 1:
			label.text = ""
		else: 
			label.text = "x" + str(quantity)
			
			
func _on_area_2d_area_entered(area):
	PlayerManager.interact_pressed.connect(on_player_interact)


func _on_area_2d_area_exited(area):
	PlayerManager.interact_pressed.disconnect(on_player_interact)


func on_player_interact() -> void:
	if is_open: 
		return
	
	is_open = true
	is_open_data.set_value()
	is_open_data.get_item_state()
	animation_player.play("open_chest")
	
	if item_data and quantity > 0:
		PlayerManager.PLAYER_INVENTORY_DATA.add_item(item_data, quantity)
	else:
		push_error("No items in chest! Chest Name: ", name)
		printerr("No items in chest!")


func _on_is_open_data_loaded():
	is_open = is_open_data.value
	if is_open:
		animation_player.play("opened")
	else:
		animation_player.play("closed")
