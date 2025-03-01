extends Area2D
class_name PushArea



func _on_body_entered(body):
	if body is PushableStatue:
		body.push_direction = PlayerManager.player.direction


func _on_body_exited(body):
	if body is PushableStatue:
		body.push_direction = Vector2.ZERO
