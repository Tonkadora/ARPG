extends Button
class_name InventorySlotUI

var slot_data: SlotData: set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label:Label = $Label


func _ready():
	texture_rect.texture = null
	label.text = ""
	
	
func set_slot_data(value: SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
		
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)


func _on_focus_entered():
	if slot_data == null:
		return
	if slot_data.item_data == null: 
		return
	PauseMenu.update_item_description(slot_data.item_data.disctription)


func _on_focus_exited():
	PauseMenu.update_item_description("")
