extends Resource
class_name InventoryData

@export var slots: Array[SlotData]

func _init():
	connect_slots()
	

func add_item(item: ItemData, count: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += 1
				return true
			
	for i in slots.size():
		if slots[i] == null:
			var new_slot = SlotData.new()
			new_slot.item_data = item
			new_slot.quantity = count
			slots[i] = new_slot
			new_slot.changed.connect(slot_changed)
			return true
	
	print("inventory was full")
	return false


func use_item(item: ItemData, count: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item and s.quantity >= count:
				s.quantity -= count
			return true
	return false
	
	
func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)
			
			
func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
	

func get_save_data() -> Array:
	var items_save: Array = []
	for i in slots.size():
		items_save.append(item_to_save(slots[i]))
	return items_save
	
	
func item_to_save(slot: SlotData) -> Dictionary:
	var result = {item = "", quantity = 0}
	if slot:
		result.quantity = slot.quantity
		if slot.item_data:
			result.item = slot.item_data.resource_path
			
	return result


func parse_save_data(save_data: Array) -> void:
	var array_size = slots.size()
	slots.clear()
	slots.resize(array_size)
	for i in save_data.size():
		slots[i] = item_from_save(save_data[i])
	connect_slots() 
	
	
func item_from_save(save_object: Dictionary) -> SlotData:
	if save_object.item == "":
		return null
	
	var new_slot: SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	return new_slot
