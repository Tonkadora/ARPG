extends State
class_name StateStun

@onready var idle:State = $"../Idle"

@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulenerable_duration: float = 1.0

var hurtbox: Hurtbox
var direction: Vector2
var next_state: State = null


func init():
	player.player_damaged.connect(on_player_damaged)
	
	
func enter() -> void:
	player.animation_player.animation_finished.connect(on_animation_finished)
	direction = player.global_position.direction_to(hurtbox.global_position)
	player.velocity = direction * -knockback_speed
	player.set_direction()
	player.update_animation("stun")
	player.make_invulerable(invulenerable_duration)
	player.effect_animation_player.play("damaged")
	
func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(on_animation_finished)
	
	
func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
	
func physics_process(_delta: float) -> State:
	return null
	

func handle_input(event: InputEvent) -> State:
	return null


func on_player_damaged(_hurtbox:Hurtbox) -> void:
	hurtbox = _hurtbox
	state_machine.change_state(self)
	
	
func on_animation_finished(_a: String) -> void:
	next_state = idle
