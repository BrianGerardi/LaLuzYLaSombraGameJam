extends CharacterBody2D

@export var vida : int = 100
@export var velocidad_de_movimiento = 150.0
@export var velocidad_de_correr = 300.0
@export var fuerza_de_salto = -400.0
@export_range(0,1) var acceleration = 0.1
@export_range(0,1) var deceleracion = 0.1
@export_range(0,1) var deceleracion_al_saltar = 0.1
#var escena_principal
func _ready() -> void:
	#escena_principal = $".."
	Global.restar_vida.connect(_on_restar_vida_player)
	Global.jugador_entro_en_area_de_luz_lvl1_signal.connect(jugador_entro_en_area_de_luz_lvl1)
	Global.jugador_entro_en_area_de_luz_lvl2_signal.connect(jugador_entro_en_area_de_luz_lvl2)
	Global.jugador_entro_en_area_de_luz_lvl3_signal.connect(jugador_entro_en_area_de_luz_lvl3)
	Global.jugador_entro_en_area_de_luz_lvl4_signal.connect(jugador_entro_en_area_de_luz_lvl4)
	#esto si queres podemos hacerlo una sola señal que pase por parametro que area es
	#algo tipo signal jugador_entro_en_area_de_luz(numero : int)



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("saltar") and (is_on_floor() or is_on_wall()):
		velocity.y = fuerza_de_salto
	if Input.is_action_just_released("saltar") and velocity.y < 0:	
		velocity.y *= deceleracion_al_saltar
		
	var velocidad
	if Input.is_action_pressed("correr"):
		velocidad = velocidad_de_correr
	else:
		velocidad = velocidad_de_movimiento
		

	var direction := Input.get_axis("mover_izquierda", "mover_derecha")
	if direction:
		velocity.x = move_toward(velocity.x , direction * velocidad, velocidad * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad_de_movimiento * deceleracion)

	move_and_slide()



func jugador_entro_en_area_de_luz_lvl1(daño_recibido : int):
	print("El jugador entro en el area de luz 1")
	Global.restar_vida.emit(daño_recibido) #quito 5 de vida

func jugador_entro_en_area_de_luz_lvl2(daño_recibido : int):
	print("El jugador entro en el area de luz 2")
#	Global.restar_vida.emit(daño_recibido) #quito 5 de vida

func jugador_entro_en_area_de_luz_lvl3(daño_recibido : int):
	print("El jugador entro en el area de luz 3")
#	Global.restar_vida.emit(daño_recibido) #quito 5 de vida

func jugador_entro_en_area_de_luz_lvl4(daño_recibido : int):
	print("El jugador entro en el area de luz 4")
#	Global.restar_vida.emit(daño_recibido) #quito 5 de vida


func game_over_player():
	#cuando perdes se llama a esta funcion
	#aca esta ideal para poner sonidos, animacion de morir y demas
	pass


func _on_restar_vida_player(cantidad_a_restar: int):
	vida -= cantidad_a_restar
	print("la vida de player vale: ", vida)
	if vida<= 0:
		Global.game_over.emit() #le avisa al HUD que muestre el mensaje de game over y boton de reiniciar
		game_over_player()
