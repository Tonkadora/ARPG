extends State
class_name StateIdle

@onready var walk: State = $"../Walk"

func enter() -> void:
	player.update_animation("idle")
	
	
func exit() -> void:
	pass
	

func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
		
	player.velocity = Vector2.ZERO
	
	return null
	
	
func physics_process(_delta: float) -> State:
	return null
	

func handle_input(event: InputEvent) -> State:
	return null
