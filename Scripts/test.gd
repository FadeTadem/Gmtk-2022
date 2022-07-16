extends Panel


onready var _m_player = get_tree().root.get_child(0).find_node("Player");


func _process(_delta):
	var vel:Vector2 = _m_player.get("_m_velocity");
	$Label.text = "Current Speed :  (%.2f, %.2f)" % [vel.x, vel.y] 
