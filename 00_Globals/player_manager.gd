extends Node

const PLAYER = preload("res://Player/player.tscn")
const PLAYER_INVENTORY_DATA: InventoryData = preload("res://GUI/PauseMenu/Inventory/player_inventory_data.tres")

signal interact_pressed

var player: Player
var player_spawned: bool = false


func _ready():
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)


func set_health(hp: int, max_hp: int) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp(0)
	
	
func set_player_position(new_position: Vector2) -> void:
	player.global_position = new_position 


func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
	
func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)
