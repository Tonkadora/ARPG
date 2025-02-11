extends CharacterBody2D
class_name Player

signal direction_changed(new_direction: Vector2)
signal player_damaged(hurtbox: Hurtbox)

const dir_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulerable: bool = false
var hp: int = 6
var max_hp:int = 6


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hitbox: Hitbox = $Hitbox
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer


func _ready():
	PlayerManager.player = self
	state_machine.initalize(self)
	hitbox.damaged.connect(on_take_damage)
	
	update_hp(99)
	
func _process(delta):
	direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up","move_down")).normalized()



func _physics_process(delta):
	move_and_slide()
		
		

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false

	var direction_id: int = int( round((direction + cardinal_direction * 0.1).angle() / TAU * dir_4.size()))
	var new_direction = dir_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true
	

func update_animation(state: String) -> void:
	animation_player.play(state + "_" + anim_direction())
	
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"


func on_take_damage(hurtbox: Hurtbox) -> void:
	if invulerable:
		return
	update_hp(-hurtbox.damage)
	if hp > 0:
		player_damaged.emit(hurtbox)
	else:
		player_damaged.emit(hurtbox)
		update_hp(99)
		
		
func update_hp(delta:float) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	

func make_invulerable(durration:float = 1.0) -> void:
	invulerable = true
	hitbox.monitoring = false
	await get_tree().create_timer(durration).timeout
	invulerable = false
	hitbox.monitoring = true
