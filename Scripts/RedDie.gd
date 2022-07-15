class_name RedDie

var rolls := {
	1 : "",
	2 : "",
	3 : "",
	4 : "",
	5 : "",
	6 : "",
};

func roll() -> String:
	var nr := RandomNumberGenerator.new().randi_range(1, 6);
	return rolls[nr];
