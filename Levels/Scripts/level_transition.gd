@tool
extends Area2D
class_name LevelTransition

@export_file("*.tscn") var level
@export var target_transition_area: String = "LevelTransition"
@export var center:bool = false

@export_category("Collision Area Settings")
@export_range(1,12, 1,"or_greater") var size: int = 2:
	set(value):
		size = value
		update_area()
		
@export var side: SIDE = SIDE.LEFT:
	set(value):
		side = value
		update_area()
		
		
@export var snap_to_grid: bool = false:
	set(value):
		snap_transition()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

enum SIDE{ LEFT, RIGHT, TOP, BOTTOM}



func _ready():
	update_area()
	
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	place_player()
	
	await LevelManager.level_loaded
	monitoring = true
	body_entered.connect(_on_body_entered)

func update_area() -> void:
	var new_rect: Vector2 = Vector2(32, 32)
	var new_position: Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_position.y -= 16
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_position.y += 16
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_position.x -= 16
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_position.x += 16

	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position


func snap_transition() -> void:
	position.x = round(position.x / 16) * 16
	position.y = round(position.y / 16) * 16
	

func place_player() -> void:
	if name != LevelManager.target_transition:
		return
	PlayerManager.set_player_position(global_position + LevelManager.position_offset)
	
	
func get_offset() -> Vector2:
	var offset: Vector2 = Vector2.ZERO
	var player_position = PlayerManager.player.global_position
	if side == SIDE.LEFT || side == SIDE.RIGHT:
		if center:
			offset.y = 0
		else:
			offset.y = player_position.y - global_position.y 
		offset.x = 16
		if side == SIDE.LEFT:
			offset.x *= -1
	else:
		if center:
			offset.x = 0
		else:
			offset.x = player_position.x - global_position.x 
		offset.y = 16
		if side == SIDE.TOP:
			offset.y *= -1
	return offset


func _on_body_entered(_body):
	LevelManager.load_new_level(level, target_transition_area, get_offset())
