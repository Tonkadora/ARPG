extends Area2D
class_name ItemMagnet

@export var magnet_strength: float = 1.0
@export var play_audio: bool = false

var items: Array[ItemPickup] = []
var speeds: Array[float] =[]

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready():
	area_entered.connect(on_area_entered)


func _process(delta):
	for i in range(items.size() - 1, -1, -1,):
		var item = items[i]
		if item == null:
			items.remove_at(i)
			speeds.remove_at(i)
		elif item.global_position.distance_to(global_position) > speeds[i]:
			speeds[i] += magnet_strength * delta
			item.position += item.global_position.direction_to(global_position) * speeds[i]
		else:
			item.global_position = global_position
			

func on_area_entered(a: Area2D) -> void:
	if a.get_parent() is ItemPickup:
		var new_item = a.get_parent() as ItemPickup
		items.append(new_item)
		speeds.append(magnet_strength)
		new_item.set_physics_process(false)
		if play_audio:
			audio.play(0)
