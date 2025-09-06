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
	

func _process(delta):
	if Engine.is_editor_hint():
		return
		
	if abs(global_position.distance_to(original_positon)) > wander_range * 32:
		npc.velocity *= -1
		npc.direction *= -1
		npc.update_direction(global_position + npc.direction)
		npc.update_animation()
		
func start() -> void:
	#IDLE 
	if npc.do_behavior == false:
		return
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	await get_tree().create_timer(randf() * idle_duration + idle_duration * 0.5).timeout
	#WALK
	npc.state = "walk"
	var dir = DIRECTIONS[randi_range(0,3)]
	npc.direction = dir
	npc.velocity = wander_speed * dir
	npc.update_direction(global_position + dir)
	npc.update_animation()
	await get_tree().create_timer(randf() * wander_duration + wander_duration * 0.5).timeout
	#REPEAT
	if npc.do_behavior == false:
		return
	start()
	
	
func set_wander_range(v: int) -> void:
	wander_range = v
	collision_shape_2d.shape.radius = v * 32
