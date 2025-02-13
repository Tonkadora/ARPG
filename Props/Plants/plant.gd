extends Node2D
class_name Plant



func _on_hitbox_damaged(hurtbox) -> void:
	queue_free()
