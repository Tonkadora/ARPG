extends CanvasLayer


var is_paused: bool = false

@onready var button_save: Button = $VBoxContainer/ButtonSave
@onready var button_load: Button = $VBoxContainer/ButtonLoad


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
	button_save.grab_focus()
	
	
func hide_paused_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	
