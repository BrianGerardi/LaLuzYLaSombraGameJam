extends Node2D

@export var raycast_luces : RayCast2D

var player_en_area_1: bool = false
var player_en_area_2: bool = false
var player_en_area_3: bool = false
var player_en_area_4: bool = false

var cajas_en_area_1: bool = false
var cajas_en_area_2: bool = false
var cajas_en_area_3: bool = false
var cajas_en_area_4: bool = false

@export var daño_area1 : int = 5
@export var daño_area2 : int = 5
@export var daño_area3 : int = 5
@export var daño_area4 : int = 5

@export var rango_area_de_luz : float = 3.0
var caja_dentro_de_area : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PointLight2D.texture_scale = rango_area_de_luz


func _physics_process(delta: float) -> void:
	if Global.get_posicion_global_player() != null:
		var direccion = Global.get_posicion_global_player() - global_position
		raycast_luces.target_position = direccion
		var colisionando_con_body = raycast_luces.get_collider()
		if colisionando_con_body is not CharacterBody2D or caja_dentro_de_area==true: 
			#si el raycast colisiona primero con cualquier cosa que no sea el player desactiva el area
			desactivar_areas2d_de_luz() #para no hacer daño a player
		else :
			activar_areas2d_de_luz()

#AREA DE DAÑO 1 ----------------
func _on_area_de_daño_1_body_entered(body:Node2D) -> void:

	if body.is_in_group("Cajas"):
		cajas_en_area_1 = true
		caja_dentro_de_area = true
		
	if body.name == "Player" && cajas_en_area_1 == false:
		player_en_area_1 = true
		Global.jugador_entro_en_area_de_luz_signal.emit(1,daño_area1)


func _on_area_de_daño_1_body_exited (body:Node2D) -> void:
	if body.is_in_group("Cajas"):
		cajas_en_area_1 = false
		
		
	elif body.name == "Player":
		player_en_area_1 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(1)


#___________________________________________________


#AREA DE DAÑO 2 ----------------
func _on_area_de_daño_2_body_entered(body:Node2D) -> void:

	if body.is_in_group("Cajas"):
		cajas_en_area_2 = true

	if body.name == "Player" && cajas_en_area_2 == false:
		player_en_area_2 = true
		Global.jugador_entro_en_area_de_luz_signal.emit(2,daño_area2)


func _on_area_de_daño_2_body_exited (body:Node2D) -> void	:
	if body.is_in_group("Cajas"):
		cajas_en_area_2 = false

	if body.name == "Player":
		print ("salio de area 2")
		player_en_area_2 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(2)


#___________________________________________________


#AREA DE DAÑO 3 ----------------
func _on_area_de_daño_3_body_entered(body:Node2D) -> void:

	if body.is_in_group("Cajas"):
		cajas_en_area_3 = true

	if body.name == "Player" && cajas_en_area_2 == false:
		player_en_area_3 = true
		Global.jugador_entro_en_area_de_luz_signal.emit(3,daño_area3)


func _on_area_de_daño_3_body_exited (body:Node2D) -> void	:
	if body.is_in_group("Cajas"):
		cajas_en_area_3 = false

	if body.name == "Player":
		player_en_area_3 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(3)

#___________________________________________________

#AREA DE DAÑO 4 ----------------
func _on_area_de_daño_4_body_entered(body:Node2D) -> void:

	if body.is_in_group("Cajas"):
		cajas_en_area_4 = true

	if body.name == "Player" && cajas_en_area_4 == false:
		player_en_area_4 = true
		Global.jugador_entro_en_area_de_luz_signal.emit(4, daño_area4)


func _on_area_de_daño_4_body_exited (body:Node2D) -> void	:
	if body.is_in_group("Cajas"):
		cajas_en_area_4 = false

	if body.name == "Player":
		player_en_area_4 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(4)

#___________________________________________________

func desactivar_areas2d_de_luz():
	$"AreaDeDaño1".monitoring = false
	$"AreaDeDaño2".monitoring = false
	$"AreaDeDaño3".monitoring = false
	$"AreaDeDaño4".monitoring = false
	$prueba.hide()

func activar_areas2d_de_luz():
	$"AreaDeDaño1".monitoring = true
	$"AreaDeDaño2".monitoring = true
	$"AreaDeDaño3".monitoring = true
	$"AreaDeDaño4".monitoring = true
	$prueba.show()
