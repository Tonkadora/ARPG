extends EnemyState
class_name EnemyStateDestroyed

const ITEM_PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")

@export var anim_name: String = "destroy"
@export var knock_back_speed: float = 200.0
@export var decelerate_speed:float = 10.0

@export_category("AI")
@export_category("Item Drops")
@export var drops: Array[DropData]

var damage_position: Vector2
var direction: Vector2


func init() -> void:
	enemy.enemy_destroyed.connect(on_enemy_destroyed)
	

func enter() -> void:
	enemy.invulneralble = true
	
	direction = enemy.global_position.direction_to(damage_position)
	
	enemy.set_direction(direction)
	enemy.velocity = direction * -knock_back_speed
	
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(on_animation_finished)
	disable_hurtbox()
	drop_items()


func exit() -> void:
	pass
	
	
func process(_delta) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	

func physics_process(_delta) -> EnemyState:
	return null
	
	
func disable_hurtbox() -> void:
	var hurtbox: Hurtbox = enemy.get_node_or_null("Hurtbox")
	if hurtbox:
		hurtbox.monitoring = false
		
		
func drop_items() -> void:
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null || drops[i].item == null:
			continue
		var drop_count = drops[i].get_drop_count()
		
		for drop in drop_count:
			var new_item: ItemPickup = ITEM_PICKUP.instantiate() as ItemPickup
			new_item.item_data = drops[i].item
			enemy.get_parent().call_deferred("add_child", new_item)
			new_item.global_position = enemy.global_position 
			new_item.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
			
	
func on_enemy_destroyed(hurtbox: Hurtbox) -> void:
	damage_position = hurtbox.global_position
	state_machine.change_state(self)


func on_animation_finished(_a: String) -> void:
	enemy.queue_free()
