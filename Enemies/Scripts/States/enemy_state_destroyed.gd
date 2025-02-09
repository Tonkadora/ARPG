extends EnemyState
class_name EnemyStateDestroyed

@export var anim_name: String = "destroy"
@export var knock_back_speed: float = 200.0
@export var decelerate_speed:float = 10.0

@export_category("AI")


var direction: Vector2


func init() -> void:
	enemy.enemy_destroyed.connect(on_enemy_destroyed)
	

func enter() -> void:
	enemy.invulneralble = true
	
	direction = enemy.global_position.direction_to(enemy.player.global_position)
	
	enemy.set_direction(direction)
	enemy.velocity = direction * -knock_back_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(on_animation_finished)


func exit() -> void:
	pass
	
	
func process(_delta) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	

func physics_process(_delta) -> EnemyState:
	return null
	
	
func on_enemy_destroyed() -> void:
	state_machine.change_state(self)


func on_animation_finished(_a: String) -> void:
	enemy.queue_free()
