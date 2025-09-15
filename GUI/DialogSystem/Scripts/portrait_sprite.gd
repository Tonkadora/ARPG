extends Sprite2D
class_name DialogPortrait

var blink: bool = false: set = set_blink
var open_mouth:bool = false: set = set_open_mouth
var mouth_open_frames: int = 0

var audio_pitch_base: float = 1.0

@onready var audio_stream_player = $"../AudioStreamPlayer"



func _ready():
	DialogSystem.letter_added.connect(check_mouth_open)
	blinking()
	
	
func set_blink(value: bool):
	if blink != value:	
		blink = value
		update_portrait()
	
	
func set_open_mouth(value: bool):
	if open_mouth != value:
		update_portrait()
		open_mouth = value  
	
	
func check_mouth_open(l: String):
	if "aeiouy1234567890".contains(l):
		open_mouth = true
		mouth_open_frames += 3
		audio_stream_player.pitch_scale = randf_range(audio_pitch_base - 0.04, audio_pitch_base + 0.04)
		audio_stream_player.play()
	elif ".,!?:;".contains(l):
		audio_stream_player.pitch_scale = audio_pitch_base - 0.1
		audio_stream_player.play()
		mouth_open_frames = 0
	
	if mouth_open_frames > 0:
		mouth_open_frames -= 1
	
	if mouth_open_frames == 0:
		if open_mouth:
			open_mouth = false
			audio_stream_player.pitch_scale = randf_range(audio_pitch_base - 0.08, audio_pitch_base + 0.02)
			audio_stream_player.play()
	
func blinking():
	if blink == false:
		await  get_tree().create_timer(randf_range(.1, 3)).timeout
	else:
		await  get_tree().create_timer(.15).timeout
	
	blink = not blink
	blinking()
		
		
func update_portrait():
	if open_mouth:
		frame = 2
	else:
		frame = 0
	if blink:
		frame += 1
