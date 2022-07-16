extends Node2D
class_name Weapon

"""
This node requires that it is a direct child of a WeaponAttach node


"""


onready var attachPoint := $AttachPoint
onready var parent := get_parent() as Node2D;

func _ready() -> void: 
	self.position = parent.position;


func _physics_process(_delta) -> void:
	var mousePos := get_global_mouse_position();
	var direction :Vector2 = (mousePos - self.global_position).normalized();
	self.rotation = direction.angle();


func attack() -> void:
	assert(false, "This function should be overriden in derived classes");
	return;
