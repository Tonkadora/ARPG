extends Node2D
class_name Boomerang

enum STATE{INACTIVE, THROW, RETURN}

var player: Player
var direction: Vector2
var speed: float = 0.0
var state


@export var acceleration: float = 500.0
@export var max_speed: float = 400.0

@onready var animation_player = $AnimationPlayer



func _ready():
	visible = false
	state = STATE.INACTIVE
	player = PlayerManager.player
	
	
func _physics_process(delta):
	if state == STATE.THROW:
		speed -= acceleration * delta
		position += direction * speed * delta
		if speed <= 0:
			state = STATE.RETURN
	elif state == STATE.RETURN:
		direction = global_position.direction_to(player.global_position)
		speed += acceleration * delta
		position += direction * speed * delta
		if global_position.distance_to(player.global_position) <= 10:
			queue_free()


func throw(throw_direction: Vector2) -> void:
	direction = throw_direction
	speed = max_speed
	state = STATE.THROW
	animation_player.play("boomerang")
	visible = true
