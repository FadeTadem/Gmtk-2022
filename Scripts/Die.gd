class_name Die


# Note(AlAndrew) It annoys me to no end that I can't statically type the thing inside the array
# it should be an array of PlayerStats objects
var rollTable : Array;

func _init(rollTable):
	self.rollTable = rollTable;

func roll() -> PlayerStats:
	var rng := RandomNumberGenerator.new();
	rng.randomize();
	var nr := rng.randi_range(0, rollTable.size() - 1);
	print(nr);
	return self.rollTable[nr];
