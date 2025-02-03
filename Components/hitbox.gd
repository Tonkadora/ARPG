extends Area2D
class_name Hitbox

signal damaged(damage:int)


func take_damage(damage: int) -> void:
	print("take damage: " , damage)
	damaged.emit(damage)
