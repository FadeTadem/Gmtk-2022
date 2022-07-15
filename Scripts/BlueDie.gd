class_name BlueDie

var rolls := {
	1 : {"acceleration": 0, "max_speed": 0, "jump_height": 0, "gravity": 0},	
	2 : {"acceleration": 0, "max_speed": 0, "jump_height": 0, "gravity": 0},	
	3 : {"acceleration": 0, "max_speed": 0, "jump_height": 0, "gravity": 0},	
	4 : {"acceleration": 0, "max_speed": 0, "jump_height": 0, "gravity": 0},	
	5 : {"acceleration": 0, "max_speed": 0, "jump_height": 0, "gravity": 0},
	6 : {"acceleration": 0, "max_speed": 0, "jump_height": 0, "gravity": 0},
};


func roll() -> Dictionary:
	var nr := RandomNumberGenerator.new().randi_range(1, 6);
	return rolls[nr];
