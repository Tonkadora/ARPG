@tool
@icon("res://GUI/DialogSystem/Icons/chat_bubble.svg")
extends Node
class_name DialogItem

@export var npc_info: NPCResource

var editor_selection: EditorSelection
var example_dialog: DialogSystemNode

func _ready():
	if  Engine.is_editor_hint():
		editor_selection = EditorInterface.get_selection()
		editor_selection.selection_changed.connect(on_selection_changed)
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
			
func on_selection_changed() -> void:
	if editor_selection == null:
		return
		
	var selected_item = editor_selection.get_selected_nodes()
	
	if example_dialog != null: 
		example_dialog.queue_free()
		
	if not selected_item.is_empty():
		if self == selected_item[0]:
			example_dialog = load("res://GUI/DialogSystem/dialog_system.tscn").instantiate() as DialogSystemNode
			if example_dialog == null:
				return
				
			self.add_child(example_dialog)
			example_dialog.offset = get_parent_global_pos() + Vector2(32, -200)
			check_npc_data()
			set_editor_display()
			

func set_editor_display():
	pass

func get_parent_global_pos() -> Vector2:
	var p = self
	var checking = true
	while checking:
		p = p.get_parent()
		if p:
			if p is Node2D:
				return p.global_position
		else:
			checking = false
			
	return Vector2.ZERO
