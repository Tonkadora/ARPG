extends EnemyState
class_name EnemyStateIdle

@export var anim_name: String = "idle"
@export_category("AI")
@export var state_durration_min: float = 0.5
@export var state_durration_max: float = 1.5
@export var after_idle_state: EnemyState

var timer: float = 0.0


func init() -> void:
	pass
	

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	timer = randf_range(state_durration_min, state_durration_max)
	enemy.update_animation(anim_name)
	

func exit() -> void:
	pass
	

func process(_delta) -> EnemyState:
	timer -= _delta
	if timer <= 0:
		return after_idle_state
		
	return null
	

func physics_process(_delta) -> EnemyState:
	return null
