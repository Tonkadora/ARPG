extends Node2D
class_name Level

func _ready():
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	LevelManager.level_load_started.connect(free_level)


func free_level() -> void:
	PlayerManager.unparent_player(self)
	queue_free()
