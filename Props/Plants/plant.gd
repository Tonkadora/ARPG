extends Node2D
class_name Plant



func _on_hitbox_damaged(_damage) -> void:
	queue_free()
