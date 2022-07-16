extends Node2D
class_name Weapon

"""
This node requires that it is a direct child of a WeaponAttach node


"""


onready var _m_attachPoint := $AttachPoint
onready var _m_parent := get_parent() as Node2D;

func _ready() -> void: 
	self.position = _m_parent.position;


func _physics_process(_delta) -> void:
	var mousePos := get_global_mouse_position();
	var direction :Vector2 = (mousePos - self.global_position).normalized();
	self.rotation = clamp(direction.angle(), -PI/2, +PI/5);
	

func _input(event):
	if event.is_action_pressed("attack", false):
		attack();

func attack() -> void:
	$AnimationPlayer.play("Attack");
