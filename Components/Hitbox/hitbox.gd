extends Area2D
class_name Hitbox

signal damaged(damage:int)


func take_damage(hurtbox: Hurtbox) -> void:
	damaged.emit(hurtbox)
