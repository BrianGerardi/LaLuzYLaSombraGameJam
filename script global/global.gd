extends Node


#este script global.gd es el primer archivo que se carga al abrir godot y es accesible en todo momento
#desde cualquier nodo, ideal para definir las señales, guardar y cargar datos con config file


signal usar_palanca_id(identificador : int)

signal jugador_entro_en_area_de_luz_lvl1_signal
signal jugador_entro_en_area_de_luz_lvl2_signal
signal jugador_entro_en_area_de_luz_lvl3_signal
signal jugador_entro_en_area_de_luz_lvl4_signal


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
