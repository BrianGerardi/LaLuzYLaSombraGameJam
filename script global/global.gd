extends Node


#este script global.gd es el primer archivo que se carga al abrir godot y es accesible en todo momento
#desde cualquier nodo, ideal para definir las señales, guardar y cargar datos con config file

#ejemplo de señal
signal primer_signal
signal antorcha_prendida(numero : int) #en proceso
signal game_over #la podemos dejar para usarla cuando tengamos el HUD

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
