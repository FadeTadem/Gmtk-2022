extends Panel


onready var player = get_tree().root.get_child(0).find_node("Player");


func _process(_delta):
	var vel:Vector2 = player.get("vel");
	$Label.text = "Current Speed :  (%.2f, %.2f)" % [vel.x, vel.y] 
