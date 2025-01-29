extends CharacterBody2D
class_name Player

var move_speed: float = 100.0
var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var state: String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta):
	move_and_slide()
	
func _process(delta):
	direction.x = Input.get_action_strength("move_right")- Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = direction.normalized()
	velocity = direction * move_speed
	if set_state() || set_direction():
		update_animation()
		

func set_direction() -> bool:
	var new_direction: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true
	

func set_state() -> bool:
	var new_state:String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	

func update_animation() -> void:
	animation_player.play(state + "_" + anim_direction())
	
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
