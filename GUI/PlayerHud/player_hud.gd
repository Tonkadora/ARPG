extends CanvasLayer

var hearts: Array[HeartGUI] = []
@onready var h_flow_container = $Control/HFlowContainer

func _ready():
	for c in h_flow_container.get_children():
		if c is HeartGUI:
			hearts.append(c)
			c.visible = false
	

func update_hp(hp: int, max_hp) -> void:
	update_max_hp(max_hp)
	for i in max_hp:
		update_heart(i, hp)
	

func update_heart(index: int, hp) -> void:
	var value: int =  clampi(hp - index * 2, 0, 2)
	hearts[index].value = value
	

func update_max_hp(max_hp: int) -> void:
	var heart_count: int = roundi(max_hp * 0.5)
	for i in hearts.size():
		if i < heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
