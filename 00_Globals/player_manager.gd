extends Node

const PLAYER = preload("res://Player/player.tscn")

var player: Player
var player_spawned: bool = false

func _ready():
	add_player_instance()


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)


func set_player_position(new_position: Vector2) -> void:
	player.global_position = new_position 


func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
	
func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)
