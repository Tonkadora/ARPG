@icon("res://NPC/Icons/npc_behavior.svg")
extends Node2D
class_name NPCBehavior


var npc: NPC


func _ready():
	var p = get_parent()
	if p is NPC:
		npc = p as NPC
		npc.do_behavior_enabled.connect(start)
		
		
func start() -> void:
	pass
