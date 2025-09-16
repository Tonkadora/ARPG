@tool
@icon("res://GUI/DialogSystem/Icons/text_bubble.svg")
extends DialogItem
class_name DialogText


@export_multiline var text: String = "Placeholder Text": set = set_text


func set_text(value: String):
	text = value
	if Engine.is_editor_hint():
		if example_dialog:
			set_editor_display()
	return

func set_editor_display():
	example_dialog.set_dialog_text(self)
	example_dialog.content.visible_characters = -1
