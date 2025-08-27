extends Node


#este script global.gd es el primer archivo que se carga al abrir godot y es accesible en todo momento
#desde cualquier nodo, ideal para definir las señales, guardar y cargar datos con config file

#ejemplo de señal
signal primer_signal
signal usar_palanca_id(identificador : int)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
