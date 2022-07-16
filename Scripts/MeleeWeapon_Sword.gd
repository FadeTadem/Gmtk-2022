extends Weapon
class_name MeleeWeapon_Sword



func _dealDamage():
	for body in $Hitbox.bodyList : 
		# TODO(AlAndrew): call hit() on all enemies in the list :D
		pass
