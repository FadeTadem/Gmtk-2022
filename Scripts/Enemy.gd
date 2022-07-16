extends KinematicBody2D

var enemySpeed = 5.0;
var enemyDamage = 10.0;
var enemyHealthPoints = 100.0;
var isAlive = 1;
var Player;
func _ready():
	Player = get_tree().root.get_child(0).find_node("Player");
	pass
	
func _physics_process(delta):
	var moveOnX;
	if Player.position.x > self.position.x:
		moveOnX = enemySpeed;
	else:
		moveOnX = -enemySpeed;
	var moveOnY;
	if Player.position.y > self.position.y:
		moveOnY =  enemySpeed;
	else:
		moveOnY = -1.0 * enemySpeed;
	move_and_slide(Vector2(moveOnX, moveOnY));
	pass
func lowerHp(damage):
	if isAlive == 1:
		if enemyHealthPoints <= damage:
			isAlive = 0;
			enemyHealthPoints = 0.0;
		else:
			enemyHealthPoints -= damage;
	pass
