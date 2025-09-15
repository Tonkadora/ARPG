@tool
@icon("res://GUI/DialogSystem/Icons/chat_bubbles.svg")
extends Area2D
class_name DialogInteraction

signal player_interacted
signal finished

@export var enabled: bool = true

var dialog_items: Array[DialogItem]

@onready var animation_player = $AnimationPlayer


func _ready():
	if Engine.is_editor_hint():
		return
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
			

func _get_configuration_warnings() -> PackedStringArray:
	if check_for_dialog_items() == false:
		return ["requires at least 1 dialog item node"]
	else:
		return []
		
	
func check_for_dialog_items() -> bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false


func on_interact():
	player_interacted.emit()
	await get_tree().process_frame
	await get_tree().process_frame
	DialogSystem.show_dialog(dialog_items)
	DialogSystem.finished.connect(on_dialog_finished)
	
func _on_area_entered(_area):
	if enabled == false or dialog_items.size() == 0:
		return
		 
	animation_player.play("show_hint")
	PlayerManager.interact_pressed.connect(on_interact)
	

func _on_area_exited(_area):
	animation_player.play("hide_hint")
	PlayerManager.interact_pressed.disconnect(on_interact)


func on_dialog_finished():
	DialogSystem.finished.disconnect(on_dialog_finished)
	finished.emit()
	
