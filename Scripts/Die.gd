class_name Die


var faces: int;
# Note(AlAndrew) It annoys me to no end that I can't statically type the thing inside the array
# it should be an array of PlayerStats objects
var rollTable : Array;

func _init(rollTable, faces: int = 6):
	self.faces = faces;
	self.rollTable = rollTable;

func roll() -> PlayerStats:
	var nr := RandomNumberGenerator.new().randi_range(0, self.faces);
	return self.rollTable[nr];
