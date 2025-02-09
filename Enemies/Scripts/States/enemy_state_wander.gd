extends EnemyState
class_name EnemyStateWander

@export var anim_name: String = "walk"
@export var wander_speed: float = 20.0

@export_category("AI")
@export var state_durration: float = 0.5
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3

@export var next_state: EnemyState

var timer: float = 0.0
var direction: Vector2


func init() -> void:
	pass
	

func enter() -> void:
	timer =  randi_range(state_cycles_min, state_cycles_max) * state_durration
	var rand = randi_range(0,3)
	direction = enemy.DIR_4[rand]
	enemy.set_direction(direction)
	enemy.update_animation(anim_name)
	enemy.velocity = direction * wander_speed

func exit() -> void:
	pass
	

func process(_delta) -> EnemyState:
	timer -= _delta
	if timer <= 0:
		return next_state
	return null
	

func physics_process(_delta) -> EnemyState:
	return null
