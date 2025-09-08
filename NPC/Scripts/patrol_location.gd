@tool
extends Node2D
class_name PatrolLocation

signal transform_changed

@export var wait_time: float = 0.0:
	set(value):
		wait_time = value
		update_wait_label()

var target_position: Vector2 = Vector2.ZERO


func _ready():
	target_position = global_position
	
	if Engine.is_editor_hint():
		return
		
	$Sprite2D.queue_free()
	
	
func _enter_tree():
	set_notify_transform(true)
	

func _notification(what: int):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		transform_changed.emit()
		
	
func update_label(s : String) -> void:
	$Sprite2D/Label.text = s
	

func update_line(new_pos : Vector2) -> void:
	var line: Line2D = $Sprite2D/Line2D
	line.points[1] = new_pos - position
	
	
func update_wait_label() -> void:
	if Engine.is_editor_hint():
		$Sprite2D/Label2.text = "Wait: " + str(snappedf(wait_time, .1)) + "s"
		
 
