@tool
@icon("res://GUI/DialogSystem/Icons/star_bubble.svg")
extends CanvasLayer
class_name DialogSystemNode

var is_active:bool = false

@onready var dialog_ui = $DialogUI


func _ready():
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	
	hide_dialog()

func _unhandled_input(event):
	#if is_active == false:
		#return
	if event.is_action_pressed("test"):
		print('test')
		if is_active == false:
			show_dialog()
		else:
			hide_dialog()
			
			
func show_dialog():
	is_active = true
	dialog_ui.visible = true
	dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	
func hide_dialog():
	is_active = false
	dialog_ui.visible = false
	dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	
