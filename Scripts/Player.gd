extends KinematicBody2D
class_name Player


var gravity :float = 981;
var coyoteTimeTimer :Timer;


var dice: Array = [
	Die.new([ # The blue die
		PlayerStats.new(5, 800, 32 * 4, null),
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

var vel: Vector2 = Vector2.ZERO;
var jump_count :int = 0;


func _ready():
	coyoteTimeTimer = Timer.new();
	coyoteTimeTimer.one_shot = true;
	coyoteTimeTimer.autostart = false;
	get_tree().root.get_children()[0].call_deferred("add_child", coyoteTimeTimer);

func _physics_process(delta):
	if Input.is_action_just_pressed("switch_die"):
		_switchDie();
	
	if Input.is_action_pressed("move_right"):
		vel.x = min(vel.x + stats.moveSpeed * delta, stats.maxSpeed)
	elif Input.is_action_pressed("move_left"):
		vel.x = max(vel.x - stats.moveSpeed * delta, -stats.maxSpeed)
	else:
		vel.x = 0;
	
	if is_on_floor() || !coyoteTimeTimer.is_stopped() || $BunnyHopRay.is_colliding():
		jump_count = 0;
		if Input.is_action_just_pressed("jump") && jump_count == 0 :
			jump_count += 1;
			vel.y = -sqrt(2 * gravity * stats.jumpHeight);
			coyoteTimeTimer.stop();

	var was_on_floor = is_on_floor();
	vel = move_and_slide(vel, Vector2.UP);
	if not is_on_floor() and was_on_floor and jump_count == 0:
		coyoteTimeTimer.start(0.2);
		vel.y = 0;
	
	vel.y += gravity * delta;


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
