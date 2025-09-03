extends Node
class_name PlayerAbilities

const BOOMERANG = preload("res://Player/Abilities/Boomerang/boomerang.tscn")

enum ABILITIES{BOOMERANG, GRAPPLE}

var selected_ability = ABILITIES.BOOMERANG
var player: Player
var boomerange_instance: Boomerang = null


func _ready():
	player = PlayerManager.player
	

func _unhandled_input(event):
	if event.is_action_pressed("ability"):
		if selected_ability == ABILITIES.BOOMERANG:
			boomerang_ability()
	
func boomerang_ability():
	print(boomerange_instance)
	if boomerange_instance != null:
		return
		
	var _b = BOOMERANG.instantiate() as Boomerang
	player.add_sibling(_b)
	_b.global_position = player.global_position
	
	var throw_direction = player.direction
	
	if throw_direction == Vector2.ZERO:
		throw_direction = player.cardinal_direction
		
	_b.throw(throw_direction)
	boomerange_instance = _b
