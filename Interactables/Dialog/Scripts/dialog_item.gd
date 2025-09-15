@tool
@icon("res://GUI/DialogSystem/Icons/chat_bubble.svg")
extends Node
class_name DialogItem

@export var npc_info: NPCResource


func _ready():
	if  Engine.is_editor_hint():
		return
	
	check_npc_data()
	

func check_npc_data() -> void:
	if npc_info:
		return
	
	var p = self
	var checking:bool = true
	
	while checking:
		p = p.get_parent()
		if p:
			if p is NPC and p.npc_resource:
				npc_info = p.npc_resource
				checking = false
		else:
			checking = false
			
