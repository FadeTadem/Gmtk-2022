extends KinematicBody2D

var _m_enemySpeed := 5.0;
var _m_enemyDamage := 10.0;
var _m_enemyHealthPoints := 100.0;
var _m_isAlive := true;
onready var _m_playerNode := get_tree().root.get_child(0).find_node("_m_playerNode");


var _m_velocity := Vector2.ZERO;

func _physics_process(_delta):
	if _m_playerNode.position.x > self.position.x:
		_m_velocity.x = _m_enemySpeed;
	else:
		_m_velocity.x = -_m_enemySpeed;

	if _m_playerNode.position.y > self.position.y:
		_m_velocity.y =  _m_enemySpeed;
	else:
		_m_velocity.y = -1.0 * _m_enemySpeed;
	
	_m_velocity = move_and_slide(Vector2(_m_velocity.x, _m_velocity.y));
	pass

func lowerHp(damage):
	if _m_isAlive == true:
		if _m_enemyHealthPoints <= damage:
			_m_isAlive = 0;
			_m_enemyHealthPoints = 0.0;
		else:
			_m_enemyHealthPoints -= damage;
	pass
