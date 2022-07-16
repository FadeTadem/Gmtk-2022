extends Area2D
class_name Hitbox


var m_bodyList : Array = [];

func _on_Hitbox_body_entered(body):
	m_bodyList.append(body)

func _on_Hitbox_body_exited(body):
	var idx :int = m_bodyList.find(body);
	m_bodyList.remove(idx);
