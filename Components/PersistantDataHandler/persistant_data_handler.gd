extends Node
class_name  PersistantDataHandler

signal data_loaded

var value: bool = false


func _ready():
	get_value()
	

func set_value() -> void:
	SaveManager.add_persitant_value(get_item_state())
	
	
func get_value() -> void:
	value = SaveManager.check_persitant_value(get_item_state())
	data_loaded.emit()


func get_item_state() -> String:
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name
  
