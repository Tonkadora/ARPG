extends CharacterBody2D
class_name Player

signal direction_changed(new_direction: Vector2)

const dir_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine


func _ready():
	PlayerManager.player = self
	state_machine.initalize(self)
	
	
func _process(delta):
	direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up","move_down")).normalized()



func _physics_process(delta):
	move_and_slide()
		
		

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false

	var direction_id: int = int( round((direction + cardinal_direction * 0.1).angle() / TAU * dir_4.size()))
	var new_direction = dir_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true
	

func update_animation(state: String) -> void:
	animation_player.play(state + "_" + anim_direction())
	
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
