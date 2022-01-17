extends Node
class_name Helper


# Create random float value within range.
static func randf_range(range_min: float = 0.00, range_max: float = 1.00)->float:
	var random = RandomNumberGenerator.new()
	random.randomize()
	return random.randf_range(range_min, range_max)
