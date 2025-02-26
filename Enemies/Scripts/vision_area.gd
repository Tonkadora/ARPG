extends Area2D
class_name VisionArea

signal player_entered
signal player_exited


func _ready():
	var parent = get_parent()
	if parent is Enemy:
		parent.direction_changed.connect(on_direction_changed)

func _on_body_entered(body):
	if body is Player:
		player_entered.emit()


func _on_body_exited(body):
	if body is Player:
		player_exited.emit()



func on_direction_changed(new_direction: Vector2) -> void:
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		_:
			rotation_degrees = 0
