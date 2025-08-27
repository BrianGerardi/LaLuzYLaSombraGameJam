extends Node


#este script global.gd es el primer archivo que se carga al abrir godot y es accesible en todo momento
#desde cualquier nodo, ideal para definir las señales, guardar y cargar datos con config file


signal usar_palanca_id(identificador : int)
signal restar_vida(cantidad_a_restar : int) #la usamos cuando el player reciba daño, el hud esta conectada para poder actualizar la barra de vida
signal jugador_entro_en_area_de_luz_lvl1_signal(restar_vida: int)
signal game_over
signal jugador_entro_en_area_de_luz_lvl2_signal(restar_vida: int)
signal jugador_entro_en_area_de_luz_lvl3_signal(restar_vida: int)
signal jugador_entro_en_area_de_luz_lvl4_signal(restar_vida: int)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
