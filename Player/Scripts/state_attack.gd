extends State
class_name StateAttack


@export var attack_sound: AudioStream 
@export_range(1, 20, 0.5) var decelerate_speed:float = 5

var attacking: bool = false

@onready var idle = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var attack_hurtbox: Hurtbox = %AttackHurtbox

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player = $"../../Sprite2D/AttackSprite/AnimationPlayer"
@onready var audio:AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"


func enter() -> void:
	player.update_animation("attack")
	attack_animation_player.play("attack_" + player.anim_direction())
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	animation_player.animation_finished.connect(end_attack)
	attacking = true
	await get_tree().create_timer(0.075).timeout
	if attacking:
		attack_hurtbox.monitoring = true
	
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	attack_hurtbox.monitoring = false
	

func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
			
	return null
	
	
func physics_process(_delta: float) -> State:
	return null
	

func handle_input(event: InputEvent) -> State:
	return null


func end_attack(animation_name: String) -> void:
	attacking = false
