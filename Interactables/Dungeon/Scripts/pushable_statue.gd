extends RigidBody2D
class_name PushableStatue

@export var push_speed: float = 30.0

var push_direction: Vector2 = Vector2.ZERO : set = set_push
@onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D


func _physics_process(delta):
	linear_velocity = push_direction * push_speed


func set_push(value: Vector2) -> void:
	push_direction = value
	if push_direction == Vector2.ZERO:
		audio.stop()
	else:
		audio.play()
