extends Node2D

@export var raycast_luces : RayCast2D

var player_en_area_4: bool = false

var cajas_en_area_4: bool = false

@export var daño_maximo : int = 25
@export var daño_minimo : int = 5
var distancia_hasta_player = 0
var daño_player = 1

@export var rango_area_de_luz : float = 3.5
var caja_dentro_de_area : bool = false
var tiempo_de_espera = 0
@export var intervalo_tiempo_quitar_vida : float = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PointLight2D.texture_scale = rango_area_de_luz
	tiempo_de_espera = 0 #inicializo


func _physics_process(delta: float) -> void:
	if Global.get_posicion_global_sombra() != null:
		var posicion_player = Global.get_posicion_global_sombra()
		var direccion = posicion_player - global_position
		raycast_luces.target_position = direccion
		var colisionando_con_body = raycast_luces.get_collider()
		distancia_hasta_player = (raycast_luces.global_position.distance_to(posicion_player)) / 10 #dividido 10 porque en pixeles son muchos
		print("distancia hasta player EN PHYSICS PROCESS vale: ", distancia_hasta_player)
		if colisionando_con_body is not CharacterBody2D or caja_dentro_de_area==true: 
			#si el raycast colisiona primero con cualquier cosa que no sea el player desactiva el area
			desactivar_areas2d_de_luz() #para no hacer daño a player
		else :
			
			activar_areas2d_de_luz()
		
		if player_en_area_4== true:
			calcular_daño_segun_distancia(distancia_hasta_player)
			tiempo_de_espera += delta
			if tiempo_de_espera>= intervalo_tiempo_quitar_vida: #esto lo podemos cambiar a mas o menos tiempo desde el editor
			#si te quedas dentro de la luz cada medio segundo te va quitando vida
				Global.jugador_entro_en_area_de_luz_signal.emit(4, daño_player)
				tiempo_de_espera = 0 #reinicio


#AREA DE DAÑO 4 ----------------
func _on_area_de_daño_4_body_entered(body:Node2D) -> void:
	if body.is_in_group("Cajas"):
		caja_dentro_de_area = true

	if body.name == "Player_sombra" && caja_dentro_de_area== false:
		player_en_area_4 = true
#		Global.jugador_entro_en_area_de_luz_signal.emit(4, daño_player)


func _on_area_de_daño_4_body_exited (body:Node2D) -> void	:
	if body.is_in_group("Cajas"):
		caja_dentro_de_area = false

	if body.name == "Player_sombra":
		player_en_area_4 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(4)

#___________________________________________________

func desactivar_areas2d_de_luz():
	if distancia_hasta_player>0 and distancia_hasta_player<0.5: #si esta muuuuy cerca es porque esta dentro del area
		#estando dentro del area el raycast no colisiona y se producia un bug
		#aca evito que si esta dentro se desactive
		return
	$"AreaDeDaño4".monitoring = false

func activar_areas2d_de_luz():
	$"AreaDeDaño4".monitoring = true

func calcular_daño_segun_distancia(distancia_hasta_player):
	if distancia_hasta_player == 0:
		return
	print("distancia hasta player vale: ", distancia_hasta_player)
	if distancia_hasta_player> rango_area_de_luz:
		daño_player = daño_minimo
	else:
		daño_player = daño_maximo
	print("la luz va a hacer un daño de: ", daño_player)


func _on_area_2d_central_body_entered(body: Node2D) -> void:
	if body.is_in_group("Cajas"):
		caja_dentro_de_area = true

	if body.name == "Player_sombra" && caja_dentro_de_area== false:
		player_en_area_4 = true
		Global.jugador_entro_en_area_de_luz_signal.emit(4, 100)


func _on_area_2d_central_body_exited(body: Node2D) -> void:
	if body.is_in_group("Cajas"):
		caja_dentro_de_area = false

	if body.name == "Player_sombra":
		player_en_area_4 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(4)
