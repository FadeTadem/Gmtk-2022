extends KinematicBody2D
class_name Player

export(float) var gravity: float = 0
export(float) var ms: float = 0
export(float) var max_speed: float = 0
export(float) var jh: float = 0 

enum DieColor {
	RED,
	BLUE
};

var vel:Vector2 = Vector2.ZERO;
var current_color = DieColor.RED;

func _physics_process(delta):
	
	if Input.is_action_just_pressed("switch_die"):
		_switchDie();
	
	var dir: Vector2 = _getInputDirection();
	vel = _getVelocity(vel, dir);
	
	vel = move_and_slide_with_snap(vel, Vector2.ONE, Vector2.UP);


func _getVelocity(oldVel:Vector2, dir:Vector2) -> Vector2:
	var newVel := oldVel;
	
	newVel.x += dir.x * ms; 
	newVel.x = clamp(newVel.x, -max_speed, max_speed);
	if dir.y == 1: 
		newVel.y -= jh;
	else:
		newVel.y += gravity; 
	
	return newVel;

func _getInputDirection() -> Vector2:
	var dir: Vector2 = Vector2.ZERO
	
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	dir.y = 1 if is_on_floor() && Input.is_action_just_pressed("jump") else 0;
	return dir;

func _switchDie() -> void :
	
	if current_color == DieColor.RED:
		current_color = DieColor.BLUE;
		self.modulate = Color.aqua;
	else:
		current_color = DieColor.RED;
		self.modulate = Color.crimson;	
	pass
