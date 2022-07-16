extends KinematicBody2D
class_name Player

var gravity :float = 10;
var coyoteJump = true;
var rememberJump = true;

var dice: Array = [
	Die.new([ # The blue die
		PlayerStats.new(100, 300, 400, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null)]
	), 
	Die.new([ # The red die
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null)]
	)
];

var stats = dice[0].rollTable[0];

var vel:Vector2 = Vector2.ZERO;

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		_switchDie();
	
	var dir: Vector2 = _getInputDirection();
	print(dir.y)
	vel = _getVelocity(vel, dir);
	
	
	vel = move_and_slide_with_snap(vel, Vector2.ONE, Vector2.UP);


func _getInputDirection() -> Vector2:
	var dir: Vector2 = Vector2.ZERO
	
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	
	if is_on_floor():
		coyoteJump = true
		pass
		
	if Input.is_action_just_pressed("jump"):
		if coyoteJump == true:
			dir.y = 1
			coyoteJump = false
			
			
	if !is_on_floor():
		_coyoteTimer()
		
		
	return dir;

func _getVelocity(oldVel:Vector2, dir:Vector2) -> Vector2:
	var newVel := oldVel;
	if dir.x == 0:
		newVel.x = 0;
	newVel.x += dir.x * stats.moveSpeed; 
	newVel.x = clamp(newVel.x, -stats.maxSpeed, stats.maxSpeed);
	if dir.y == 1: 
		newVel.y -= stats.jumpHeight;
	else:
		newVel.y += gravity; 
	
	return newVel;


func _switchDie() -> void :
	
	pass
	
func _coyoteTimer():
	
	yield(get_tree().create_timer(1), "timeout")
	coyoteJump = false
	
	pass
