class_name PlayerStats

# The horizontal speed with wich the player will accelerate when moving
var moveSpeed :float; 
# The maximum speed the player is allowed to move at
var maxSpeed :float;
# The jump hight ( in pixels ) of the player
var jumpHeight :float;
# The weapon currently in hand
var handledWeapon: PackedScene = null; # null = no weapon



func _init(timeToMaxSpeed:float, maxSpeed:float, jumpHeight:float, handledWeapon: PackedScene):
	self.moveSpeed = maxSpeed / timeToMaxSpeed;
	self.maxSpeed = maxSpeed;
	self.jumpHeight = jumpHeight;
	self.handledWeapon = handledWeapon;
