extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.nivel_actual_global != 2:
		Global.set_nivel_actual (2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
