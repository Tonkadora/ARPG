@tool
@icon("res://GUI/DialogSystem/Icons/question_bubble.svg")
extends DialogItem
class_name DialogChoice

var dialog_branches: Array[DialogBranch]


func _ready():
	if Engine.is_editor_hint():
		return
	
	for c in get_children():
		if c is DialogBranch:
			dialog_branches.append(c)
			

func _get_configuration_warnings():
	if check_for_dialog_branches() == false:
		return ["Requires at least 2 dialog branches"]
	else:
		return[]
		
		
func check_for_dialog_branches() -> bool:
	var count: int = 0
	for c in get_children():
		count += 1
		if count > 1:
			return true
	return false
	
