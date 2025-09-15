@tool
@icon("res://NPC/Icons/npc.svg")
extends CharacterBody2D
class_name NPC

signal do_behavior_enabled

@export var npc_resource: NPCResource: set = set_npc_resource

var state: String = "idle"
var direction: Vector2 = Vector2.DOWN
var direction_name: String = "down"
var do_behavior: bool = true

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer


func _ready():
	set_up_npc()
	if Engine.is_editor_hint():
		return
		
	gather_interactables()
	do_behavior_enabled.emit()
	

func _physics_process(_delta):
	move_and_slide()
	update_animation()
	
	
func gather_interactables():
	for c in get_children():
		if c is DialogInteraction:
			c.player_interacted.connect(on_interacted)
			c.finished.connect(on_interaction_finished)
			
			
func set_up_npc() -> void:
	if npc_resource and sprite:
		sprite.texture = npc_resource.sprite


func set_npc_resource(value: NPCResource):
	npc_resource = value
	set_up_npc()


func update_animation() -> void:
	animation.play(state + "_" + direction_name)
	

func update_direction(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)
	update_direction_name()
	
	if direction_name == "side" and direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
func update_direction_name():	
	var threshold: float = 0.45
	if direction.y < -threshold:
		direction_name = "up"
	elif direction	.y > threshold:
		direction_name = "down"
	elif direction.x > threshold || direction.x < - threshold:
		direction_name = "side"


func on_interacted():
	print("interacted")
	update_direction(PlayerManager.player.global_position)
	state = "idle"
	velocity = Vector2.ZERO
	update_animation()
	do_behavior = false
	
	
func on_interaction_finished():
	state = "idle"
	update_animation()
	do_behavior = true
	do_behavior_enabled.emit()
