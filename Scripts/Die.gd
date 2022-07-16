class_name Die


# Note(AlAndrew) It annoys me to no end that I can't statically type the thing inside the array
# it should be an array of PlayerStats objects
var _m_rollTable : Array;

func _init(p_rollTable):
	self._m_rollTable = p_rollTable;

func roll() -> PlayerStats:
	var rng := RandomNumberGenerator.new();
	rng.randomize();
	var nr := rng.randi_range(0, _m_rollTable.size() - 1);
	return self._m_rollTable[nr];
