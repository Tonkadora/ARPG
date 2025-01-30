extends State
class_name StateAttack

var attacking: bool = false

@onready var idle = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect(end_attack)
	attacking = true
	
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	pass
	

func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
			
	return null
	
	
func physics_process(_delta: float) -> State:
	return null
	

func handle_input(event: InputEvent) -> State:
	return null


func end_attack(animation_name: String) -> void:
	attacking = false
