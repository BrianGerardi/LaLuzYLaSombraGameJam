extends Node2D

#var siguiente_nivel = "res://Escenas/creditos_finales.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.nivel_actual_global != 3:
		Global.set_nivel_actual (3)
#	await get_tree().create_timer(4).timeout
#	get_tree().change_scene_to_file(siguiente_nivel)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
