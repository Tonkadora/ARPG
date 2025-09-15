extends Node
class_name State

static var player: Player 
static var state_machine: PlayerStateMachine


func init():
	pass
	
	
func _ready():
	pass
	

func enter() -> void:
	pass
	
	
func exit() -> void:
	pass
	

func process(_delta: float) -> State:
	return null
	
	
func physics_process(_delta: float) -> State:
	return null
	

func handle_input(_event: InputEvent) -> State:
	return null
