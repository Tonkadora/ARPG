extends CharacterBody2D
class_name Enemy

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()
signal enemy_destroyed()

@export var hp: int = 3

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulneralble: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_state_machine:EnemyStateMachine = $EnemyStateMachine
@onready var hitbox: Hitbox = $Hitbox


func _ready():
	enemy_state_machine.initalize(self)
	player = PlayerManager.player
	hitbox.damaged.connect(on_hitbox_damaged)
	
	
func _physics_process(_delta):
	move_and_slide()
	
	
func set_direction(new_direction) -> bool:
	direction = new_direction
	print(direction)
	if direction == Vector2.ZERO:
		return false
	
	var direction_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	print(direction_id)
	var new_dir = DIR_4[direction_id]
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
	
func update_animation(state: String) -> void:
	animation_player.play(state + "_" + animation_direction())
	
	
func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
	

func on_hitbox_damaged(damage: int) -> void:
	if invulneralble:
		return
		
	hp -= damage
	if hp > 0:
		enemy_damaged.emit()
	else:
		enemy_destroyed.emit()
