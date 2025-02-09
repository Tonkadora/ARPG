extends EnemyState
class_name EnemyStateStun

@export var anim_name: String = "stun"
@export var knock_back_speed: float = 200.0
@export var decelerate_speed:float = 10.0

@export_category("AI")
@export var next_state: EnemyState

var direction: Vector2
var animation_finished: bool = false


func init() -> void:
	enemy.enemy_damaged.connect(on_enemy_damaged)
	

func enter() -> void:
	enemy.invulneralble = true
	animation_finished = false
	direction = enemy.global_position.direction_to(enemy.player.global_position)
	
	enemy.set_direction(direction)
	enemy.velocity = direction * -knock_back_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(on_animation_finished)


func exit() -> void:
	enemy.invulneralble = false
	enemy.animation_player.animation_finished.disconnect(on_animation_finished)
	
	
func process(_delta) -> EnemyState:
	if animation_finished:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	

func physics_process(_delta) -> EnemyState:
	return null
	
	
func on_enemy_damaged() -> void:
	state_machine.change_state(self)


func on_animation_finished(_a: String) -> void:
	animation_finished = true
