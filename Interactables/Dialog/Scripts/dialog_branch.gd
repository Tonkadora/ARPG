@tool
@icon("res://GUI/DialogSystem/Icons/answer_bubble.svg")
extends DialogItem
class_name DialogBranch

@export var text: String = "ok..."

var dialog_items: Array[DialogItem]


func _ready():
	if Engine.is_editor_hint():
		return
		
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
