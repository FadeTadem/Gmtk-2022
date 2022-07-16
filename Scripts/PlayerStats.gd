class_name PlayerStats

# The horizontal speed with wich the player will accelerate when moving
var m_moveSpeed :float; 
# The maximum speed the player is allowed to move at
var m_maxSpeed :float;
# The jump hight ( in pixels ) of the player
var m_jumpHeight :float;
# The weapon currently in hand
var m_handledWeapon: PackedScene = null; # null = no weapon



func _init(p_timeToMaxSpeed:float, p_maxSpeed:float, p_jumpHeight:float, p_handledWeapon: PackedScene):
	self.m_moveSpeed = p_maxSpeed / p_timeToMaxSpeed;
	self.m_maxSpeed = p_maxSpeed;
	self.m_jumpHeight = p_jumpHeight;
	self.m_handledWeapon = p_handledWeapon;
