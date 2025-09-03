@tool
extends Node2D
class_name ItemDropper


const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")

var has_dropped: bool = false

@export var item_data:ItemData: set = _set_item_data

@onready var sprite: Sprite2D = $Sprite2D
@onready var has_dropped_data: PersistantDataHandler = $PersistantDataHandler
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer



func _ready():
	if Engine.is_editor_hint():
		update_texture()
		return
	
	sprite.visible = false
	has_dropped_data.data_loaded.connect(on_data_loaded)
	on_data_loaded()
	
	
func _set_item_data(value: ItemData) -> void:
	item_data = value
	update_texture()
	

func update_texture() -> void:
	if Engine.is_editor_hint():
		if item_data and sprite:
			sprite.texture = item_data.texture


func drop_item() -> void:
	if has_dropped:
		return
	has_dropped = true
	var drop = PICKUP.instantiate() as ItemPickup
	drop.item_data = item_data
	add_child(drop)
	drop.picked_up.connect(on_drop_pickup)
	audio.play()
	
	
func on_data_loaded() -> void:
	has_dropped = has_dropped_data.value
	
	
func on_drop_pickup() -> void:
	has_dropped_data.set_value()
