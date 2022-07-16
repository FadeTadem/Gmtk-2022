extends KinematicBody2D
class_name _m_playerNode


var _m_gravity :float = 981;
var _m_coyoteTimeTimer :Timer;


var _m_dice: Array = [
	Die.new([ # The blue die
		PlayerStats.new(5, 800, 32 * 4, null),
		PlayerStats.new(1, 300, 100, null),
		PlayerStats.new(1, 300, 100, null),
		PlayerStats.new(1, 300, 100, null),
		PlayerStats.new(1, 300, 100, null),
		PlayerStats.new(1, 300, 100, null)]
	), 
	Die.new([ # The red die
		PlayerStats.new(1, 300, 100, preload("res://Scenes/MeleeWeapon_Spear.tscn")),
		PlayerStats.new(1, 300, 100, preload("res://Scenes/MeleeWeapon_Sword.tscn")),
		PlayerStats.new(1, 300, 100, preload("res://Scenes/MeleeWeapon_Dagger.tscn")),
		PlayerStats.new(1, 300, 100, preload("res://Scenes/MeleeWeapon_Dagger.tscn")),
		PlayerStats.new(1, 300, 100, preload("res://Scenes/MeleeWeapon_Sword.tscn")),
		PlayerStats.new(1, 300, 100, preload("res://Scenes/MeleeWeapon_Spear.tscn"))]
	)
];

export(int, 0, 1) var _m_currentDie: int = 0;
var _m_stats :PlayerStats = _m_dice[0]._m_rollTable[0];

var _m_velocity: Vector2 = Vector2.ZERO;
var _m_jumpCount :int = 0;


func _ready():
	_m_coyoteTimeTimer = Timer.new();
	_m_coyoteTimeTimer.one_shot = true;
	_m_coyoteTimeTimer.autostart = false;
	get_tree().root.get_children()[0].call_deferred("add_child", _m_coyoteTimeTimer);

func _physics_process(delta):
	if Input.is_action_just_pressed("switch_die"):
		_switchDie();
	
	if Input.is_action_pressed("move_right"):
		_m_velocity.x = min(_m_velocity.x + _m_stats.m_moveSpeed * delta, _m_stats.m_maxSpeed)
	elif Input.is_action_pressed("move_left"):
		_m_velocity.x = max(_m_velocity.x - _m_stats.m_moveSpeed * delta, -_m_stats.m_maxSpeed)
	else:
		_m_velocity.x = 0;
	
	if is_on_floor() || !_m_coyoteTimeTimer.is_stopped() || $BunnyHopRay.is_colliding():
		_m_jumpCount = 0;
		if Input.is_action_just_pressed("jump") && _m_jumpCount == 0 :
			_m_jumpCount += 1;
			_m_velocity.y = -sqrt(2 * _m_gravity * _m_stats.m_jumpHeight);
			_m_coyoteTimeTimer.stop();

	var was_on_floor = is_on_floor();
	_m_velocity = move_and_slide(_m_velocity, Vector2.UP);
	if not is_on_floor() and was_on_floor and _m_jumpCount == 0:
		_m_coyoteTimeTimer.start(0.2);
		_m_velocity.y = 0;
	
	_m_velocity.y += _m_gravity * delta;


func _swtichFace() -> void:
	if(_m_currentDie == 0):
		self.modulate = Color.darkturquoise;
	else:
		self.modulate = Color.crimson;

func _switchWeapon() -> void:
	for child in $WeaponAttach.get_children() :
		child.queue_free();
	
	var weaponScene := self._m_stats.m_handledWeapon;
	
	if weaponScene == null:
		return;
	
	var weapon := weaponScene.instance();
	$WeaponAttach.add_child(weapon);

func _switchDie() -> void :
	_m_currentDie = !_m_currentDie;
	self._m_stats = _m_dice[_m_currentDie].roll();
	
	_swtichFace();
	_switchWeapon();
