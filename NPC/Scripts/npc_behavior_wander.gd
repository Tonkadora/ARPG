@tool
extends NPCBehavior

@export var wander_range: int = 2: set = set_wander_range
@export var wander_speed : float = 32.0
@export var wander_duration: float = 1.0
@export var idle_duration: float = 1.0

const DIRECTIONS = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]

var original_positon: Vector2

@onready var collision_shape_2d = $CollisionShape2D


func _ready():
	if Engine.is_editor_hint():
		return
	super()
	collision_shape_2d.queue_free()
	original_positon = npc.global_position
	
	
func start() -> void:
	#IDLE 
	
	#WALK
	
	#REPEAT
	
	pass
	
	
func set_wander_range(v: int) -> void:
	wander_range = v
	collision_shape_2d.shape.range = v * 32
