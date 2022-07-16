extends KinematicBody2D
class_name Player

var gravity :float = 10;

var dice: Array = [
	Die.new([ # The blue die
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null),
		PlayerStats.new(100, 300, 100, null)]
	), 
	Die.new([ # The red die
		PlayerStats.new(100, 300, 100, preload("res://Scenes/MeleeWeapon_Spear.tscn")),
		PlayerStats.new(100, 300, 100, preload("res://Scenes/MeleeWeapon_Sword.tscn")),
		PlayerStats.new(100, 300, 100, preload("res://Scenes/MeleeWeapon_Dagger.tscn")),
		PlayerStats.new(100, 300, 100, preload("res://Scenes/MeleeWeapon_Dagger.tscn")),
		PlayerStats.new(100, 300, 100, preload("res://Scenes/MeleeWeapon_Sword.tscn")),
		PlayerStats.new(100, 300, 100, preload("res://Scenes/MeleeWeapon_Spear.tscn"))]
	)
];

export(int, 0, 1) var currentDie: int = 0;
var stats :PlayerStats = dice[0].rollTable[0];

var vel:Vector2 = Vector2.ZERO;

func _physics_process(delta):
	if Input.is_action_just_pressed("switch_die"):
		_switchDie();
	
	var dir: Vector2 = _getInputDirection();
	vel = _getVelocity(vel, dir);
	
	vel = move_and_slide_with_snap(vel, Vector2.ONE, Vector2.UP);


func _getInputDirection() -> Vector2:
	var dir: Vector2 = Vector2.ZERO
	
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	dir.y = 1 if is_on_floor() && Input.is_action_just_pressed("jump") else 0;
	return dir;


func _getVelocity(oldVel:Vector2, dir:Vector2) -> Vector2:
	var newVel := oldVel;
	
	newVel.x += dir.x * stats.moveSpeed; 
	newVel.x = clamp(newVel.x, -stats.maxSpeed, stats.maxSpeed);
	
	if dir.y == 1: 
		newVel.y -= stats.jumpHeight;
	else:
		newVel.y += gravity;
	
	return newVel;


func _swtichFace() -> void:
	if(currentDie == 0):
		self.modulate = Color.darkturquoise;
	else:
		self.modulate = Color.crimson;

func _switchWeapon() -> void:
	for child in $WeaponAttach.get_children() :
		child.queue_free();
	
	var weaponScene := self.stats.handledWeapon;
	
	if weaponScene == null:
		return;
	
	var weapon := weaponScene.instance();
	$WeaponAttach.add_child(weapon);

func _switchDie() -> void :
	currentDie = !currentDie;
	self.stats = dice[currentDie].roll();
	
	_swtichFace();
	_switchWeapon();
