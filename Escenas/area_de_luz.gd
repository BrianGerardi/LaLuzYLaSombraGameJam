extends Node2D

var player_en_area_1: bool = false
var player_en_area_2: bool = false
var player_en_area_3: bool = false
var player_en_area_4: bool = false

var cajas_en_area_1: bool = false
var cajas_en_area_2: bool = false
var cajas_en_area_3: bool = false
var cajas_en_area_4: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#AREA DE DAÑO 1 ----------------
func _on_area_de_daño_1_body_entered(body:Node2D) -> void:
	if body.is_in_group("Cajas"):
		cajas_en_area_1 = true
		
	if body.name == "Player" && cajas_en_area_1 == false:
		player_en_area_1 = true
		Global.jugador_entro_en_area_de_luz_signal.emit(1)


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
		Global.jugador_entro_en_area_de_luz_signal.emit(2)


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
		Global.jugador_entro_en_area_de_luz_signal.emit(3)


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
		Global.jugador_entro_en_area_de_luz_signal.emit(4)


func _on_area_de_daño_4_body_exited (body:Node2D) -> void	:
	if body.is_in_group("Cajas"):
		cajas_en_area_4 = false

	if body.name == "Player":
		player_en_area_4 = false
		Global.jugador_salio_de_area_de_luz_signal.emit(4)

#___________________________________________________
	
