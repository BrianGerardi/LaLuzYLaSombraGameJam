extends CharacterBody2D

@export var velocidad_de_movimiento = 150.0
@export var velocidad_de_correr = 300.0
@export var fuerza_de_salto = -400.0
@export_range(0,1) var acceleration = 0.1
@export_range(0,1) var deceleracion = 0.1
@export_range(0,1) var deceleracion_al_saltar = 0.1
#var escena_principal
func _ready() -> void:
	#escena_principal = $".."
	Global.jugador_entro_en_area_de_luz_lvl1_signal.connect(jugador_entro_en_area_de_luz_lvl1)
	Global.jugador_entro_en_area_de_luz_lvl2_signal.connect(jugador_entro_en_area_de_luz_lvl2)
	Global.jugador_entro_en_area_de_luz_lvl3_signal.connect(jugador_entro_en_area_de_luz_lvl3)
	Global.jugador_entro_en_area_de_luz_lvl4_signal.connect(jugador_entro_en_area_de_luz_lvl4)
	
	
	
	

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




func jugador_entro_en_area_de_luz_lvl1():
	print("El jugador entro en el area de luz 1")

func jugador_entro_en_area_de_luz_lvl2():
	print("El jugador entro en el area de luz 2")

func jugador_entro_en_area_de_luz_lvl3():
	print("El jugador entro en el area de luz 3")

func jugador_entro_en_area_de_luz_lvl4():
	print("El jugador entro en el area de luz 4")
