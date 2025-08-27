extends CharacterBody2D

@export var velocidad_de_movimiento = 150.0
@export var velocidad_de_correr = 300.0
@export var fuerza_de_salto = -400.0
@export_range(0,1) var acceleration = 0.1
@export_range(0,1) var deceleracion = 0.1
@export_range(0,1) var deceleracion_al_saltar = 0.1
const PUSH_FORCE = 100.0
const MAX_VELOCITY = 150.0
#var escena_principal
func _ready() -> void:
	#escena_principal = $".."
	Global.jugador_entro_en_area_de_luz_signal.connect(jugador_entro_en_area_de_luz)
	
	Global.jugador_salio_de_area_de_luz_signal.connect(jugador_salio_en_area_de_luz)
	
	
	
	

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

	

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var colision_caja = collision.get_collider()
		if colision_caja.is_in_group("Cajas") and abs(colision_caja.get_linear_velocity().x) < MAX_VELOCITY:
			colision_caja.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
			
	move_and_slide()




func jugador_entro_en_area_de_luz(numero : int):
	match numero : 
		1: 
			print("El jugador entro en el area de luz 1")
		2:
			print("El jugador entro en el area de luz 2")
		3:
			print("El jugador entro en el area de luz 3")
		4:
			print("El jugador entro en el area de luz 4")
	
	
func jugador_salio_en_area_de_luz(numero : int):		
	match numero : 
		1: 
			print("El jugador salio en el area de luz 1")
		2:
			print("El jugador salio en el area de luz 2")
		3:
			print("El jugador salio en el area de luz 3")
		4:
			print("El jugador salio en el area de luz 4")
