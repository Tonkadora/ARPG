extends Node2D
class_name BarredDoor


@onready var animation_player = $AnimationPlayer


func _ready():
	pass
	

func open_door() -> void:
	animation_player.play("open_door")
	
	
func close_door() -> void:
	animation_player.play("close_door")


func _on_pressure_plate_activated():
	open_door()


func _on_pressure_plate_deactivated():
	close_door()
