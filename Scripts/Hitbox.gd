extends Area2D
class_name Hitbox


var bodyList : Array = [];

func _on_Hitbox_body_entered(body):
	bodyList.append(body)

func _on_Hitbox_body_exited(body):
	var idx :int = bodyList.find(body);
	bodyList.remove(idx);
