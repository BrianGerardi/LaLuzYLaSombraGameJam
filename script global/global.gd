extends Node

#este script global.gd es el primer archivo que se carga al abrir godot y es accesible en todo momento
#desde cualquier nodo, ideal para definir las señales, guardar y cargar datos con config file
@onready var audio = AudioStreamPlayer.new()
var posicion_global_player = null
var posicion_global_sombra = null
var nivel_actual_global : int = 0
signal usar_palanca_id(identificador : int)

signal jugador_entro_en_area_de_luz_signal (numero : int, daño : int) 
#---------------------------------------------------
signal jugador_salio_de_area_de_luz_signal (numero : int) #el numero es el nivel de daño
signal restar_vida(cantidad_a_restar : int) #la usamos cuando el player reciba daño, el hud esta conectada para poder actualizar la barra de vida
signal game_over
signal ganar_nivel #se emite cuando entras al area2d de ganar nivel


const musica_de_niveles = {
	1: preload("res://Audio/Musica/Music_Level1v2.ogg"),
	2: preload("res://Audio/Musica/Music_Level2.ogg"),
	3: preload("res://Audio/Musica/Music_Level5.ogg"),
	4: preload("res://Audio/Musica/Music_Level3.ogg"),
	5: preload("res://Audio/Musica/Music_Level4.ogg"),
	6: preload("res://Audio/Musica/Music_Level6.ogg"),
	0: preload("res://Audio/Musica/Music_Menu.ogg"),
}


func set_nivel_actual (numero :int):
	nivel_actual_global = numero
	audio.stream = musica_de_niveles [nivel_actual_global]
	audio.volume_db = -5
	audio.play()

func _ready() -> void:
	
	add_child(audio)
	audio.stream = musica_de_niveles [nivel_actual_global]
	audio.volume_db = -5
	audio.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_posicion_global_player():
	return posicion_global_player

func set_posicion_global_player(posicion):
	posicion_global_player = posicion

func get_posicion_global_sombra():
	return posicion_global_sombra

func set_posicion_global_sombra(posicion):
	posicion_global_sombra = posicion
