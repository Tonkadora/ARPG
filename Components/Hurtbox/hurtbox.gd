extends Area2D
class_name Hurtbox


@export var damage: int = 1



func _on_area_entered(area):
	if area is Hitbox:
		area.take_damage(damage)
