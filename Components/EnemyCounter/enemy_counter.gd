extends Node2D
class_name EnemyCounter

signal enemies_defeated


func _ready():
	child_exiting_tree.connect(on_enemy_destroyed)
	

func enemy_count() -> int:
	var _count:int = 0
	for c in get_children():
		if c is Enemy:
			_count += 1
	return _count
	
	
func on_enemy_destroyed(e: Node2D):
	if e is Enemy:
		if enemy_count() <= 1:
			enemies_defeated.emit()
			
