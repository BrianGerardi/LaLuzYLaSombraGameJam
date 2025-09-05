extends PointLight2D

@export var intensidad_min: float = 0.8
@export var intensidad_max: float = 1.2
@export var velocidad: float = 8.0

var target_energy: float
var rng = RandomNumberGenerator.new()

func _ready():
	target_energy = energy

func _process(delta):
	if abs(energy - target_energy) < 0.05:
		target_energy = rng.randf_range(intensidad_min, intensidad_max)
	energy = lerp(energy, target_energy, delta * velocidad)
