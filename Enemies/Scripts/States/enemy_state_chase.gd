extends EnemyState
class_name EnemyStateChase

@export var anim_name: String = "chase"
@export var chase_speed: float = 40.0
@export var turn_rate: float = 0.25

@export_category("AI")
@export var state_aggro_durration: float = 0.5

@export var next_state: EnemyState

@export var vision_area: VisionArea
@export var attack_area: Hurtbox

var timer: float = 0.0
var direction: Vector2
var can_see_player: bool = false

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect(on_player_entered)
		vision_area.player_exited.connect(on_player_exited)
		
	

func enter() -> void:
	timer =  state_aggro_durration
	
	enemy.update_animation(anim_name)
	
	if attack_area:
		attack_area.monitoring = true


func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
	can_see_player = false
	

func process(_delta) -> EnemyState:
	var new_direction: Vector2 = enemy.global_position.direction_to(PlayerManager.player.global_position)
	direction = lerp(direction, new_direction, turn_rate)
	
	enemy.velocity = direction * chase_speed
	
	if enemy.set_direction(direction):
		enemy.update_animation(anim_name)
		
	if can_see_player == false:
		timer -= _delta
		if timer <= 0:
			return next_state
	else:
		timer = state_aggro_durration
	return null
	

func physics_process(_delta) -> EnemyState:
	return null


func on_player_entered() ->void:
	can_see_player = true
	if (state_machine.current_state is EnemyStateStun or state_machine.current_state is EnemyStateDestroyed):
		return
		
	state_machine.change_state(self)
	
	
func on_player_exited() ->void:
	can_see_player = false
