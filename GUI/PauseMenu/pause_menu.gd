extends CanvasLayer

signal shown
signal hidden

var is_paused: bool = false

@onready var button_save: Button = $Control/HBoxContainer/ButtonSave
@onready var button_load: Button = $Control/HBoxContainer/ButtonLoad
@onready var desctiption_label = $Control/DesctiptionLabel


func _ready():
	hide_paused_menu()
	
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_paused_menu()
		else:
			hide_paused_menu()
			
		get_viewport().set_input_as_handled()
		
		
	
func show_paused_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	shown.emit()
	
	
func hide_paused_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	hidden.emit()
	

func _on_button_save_pressed():
	if is_paused == false:
		return
		
	SaveManager.save_game()
	hide_paused_menu()


func _on_button_load_pressed():
	if is_paused == false:
		return
		
	SaveManager.load_game()
	
	await LevelManager.level_load_started
	
	hide_paused_menu()


func update_item_description(new_text: String) -> void:
	desctiption_label.text = new_text
