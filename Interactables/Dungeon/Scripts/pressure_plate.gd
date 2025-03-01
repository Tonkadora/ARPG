extends Node2D
class_name PressurePlate

signal activated
signal deactivated

var bodies: int = 0
var is_active: bool = false
var off_rect: Rect2

@onready var area_2d:Area2D = $Area2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_activate: AudioStream = preload("res://Interactables/Dungeon/lever-01.wav")
@onready var audio_deactivate: AudioStream = preload("res://Interactables/Dungeon/lever-02.wav")
@onready var sprite: Sprite2D = $Sprite2D


func _ready():
	off_rect = sprite.region_rect


func check_is_activated() -> void:
	if bodies > 0 and is_active == false:
		is_active = true
		sprite.region_rect.position.x = off_rect.position.x - 32
		play_audio(audio_activate)
		activated.emit()
	elif  bodies <= 0 and is_active:
		is_active = false
		sprite.region_rect.position.x = off_rect.position.x 
		play_audio(audio_deactivate)
		deactivated.emit()
		

func play_audio(stream: AudioStream) -> void:
	audio.stream = stream
	audio.play()
	
	
func _on_area_2d_body_entered(body):
	bodies += 1
	check_is_activated()

func _on_area_2d_body_exited(body):
	bodies -= 1
	check_is_activated()
