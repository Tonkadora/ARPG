@tool
extends CharacterBody2D
class_name ItemPickup

signal picked_up

@export var item_data: ItemData: set = set_item_data

@onready var sprite: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D= $AudioStreamPlayer2D


func _ready():
	update_texture()
	if Engine.is_editor_hint():
		return


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		
	velocity -= velocity * delta * 4
	
	
func set_item_data(value: ItemData) -> void:
	item_data = value
	update_texture()
	
	
func item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_area_2d_body_entered)
	audio_stream_player_2d.play()
	visible = false
	picked_up.emit()
	await  audio_stream_player_2d.finished
	queue_free()
	
	
func update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture
	
	
func _on_area_2d_body_entered(body):
	if body is Player:
		if item_data:
			if PlayerManager.PLAYER_INVENTORY_DATA.add_item(item_data):
				item_picked_up()
