@tool
@icon("res://GUI/DialogSystem/Icons/star_bubble.svg")
extends CanvasLayer
class_name DialogSystemNode

signal letter_added(letter: String)
signal finished 

var is_active:bool = false
var text_in_progress: bool = false

var text_speed: float = 0.02
var text_length: int = 0
var plain_text: String

var dialog_items: Array[DialogItem] 
var dialog_items_index: int = 0

@onready var dialog_ui = $DialogUI
@onready var content = $DialogUI/PanelContainer/RichTextLabel
@onready var name_label = $DialogUI/Label
@onready var portrait_sprite: DialogPortrait = $DialogUI/PortraitSprite
@onready var dialog_progress_indicator = $DialogUI/DialogProgressIndicator
@onready var progress_label = $DialogUI/DialogProgressIndicator/Label
@onready var timer = $DialogUI/Timer
@onready var audio = $DialogUI/AudioStreamPlayer


func _ready():
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	
	hide_dialog()


func _unhandled_input(event):
	if is_active == false:
		return
	
	if event.is_action_pressed("interact") or event.is_action_pressed("attack") or event.is_action_pressed("ui_accept"):
		if text_in_progress:
			content.visible_characters = -1
			timer.stop()
			text_in_progress = false
			show_dialog_button_indicator(true)
			return
			
		dialog_items_index += 1
		if dialog_items_index < dialog_items.size():
			start_dialog()
		else:
			hide_dialog()
			
			
func show_dialog(items: Array[DialogItem]):
	is_active = true
	dialog_ui.visible = true
	dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	dialog_items = items
	dialog_items_index = 0
	get_tree().paused = true
	await get_tree().process_frame
	start_dialog()
	
	
func hide_dialog():
	is_active = false
	dialog_ui.visible = false
	dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	finished.emit()
	

func start_dialog():
	show_dialog_button_indicator(false)
	var d: DialogItem = dialog_items[dialog_items_index]
	set_dialog_data(d)
	
	content.visible_characters = 0
	text_length = content.get_total_character_count()
	plain_text = content.get_parsed_text()
	
	text_in_progress = true
	
	start_timer()
	

func show_dialog_button_indicator(_is_visible: bool):
	dialog_progress_indicator.visible = _is_visible
	if dialog_items_index + 1 < dialog_items.size():
		progress_label.text = "NEXT"
	else:
		progress_label.text = "END"


func set_dialog_data(d: DialogItem):
	if d is DialogText:
		content.text = d.text
	name_label.text = d.npc_info.npc_name
	portrait_sprite.texture = d.npc_info.portrait
	portrait_sprite.audio_pitch_base = d.npc_info.dialog_audio_pitch  
	

func start_timer():
	timer.wait_time = text_speed
	var char = plain_text[content.visible_characters - 1]
	if ".:;!?".contains(char):
		timer.wait_time *= 4
	elif ", ".contains(char):
		timer.wait_time *= 2
	timer.start()


func _on_timer_timeout():
	content.visible_characters += 1
	if content.visible_characters <= text_length:
		letter_added.emit(plain_text[content.visible_characters - 1])
		start_timer()
	else:
		show_dialog_button_indicator(true)
		text_in_progress = false
