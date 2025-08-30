extends CharacterBody2D

@export var vida : int = 100
@export var velocidad_de_movimiento = 150.0
@export var velocidad_de_correr = 300.0
@export var fuerza_de_salto = -400.0
@export_range(0,1) var acceleration = 0.1
@export_range(0,1) var deceleracion = 0.1
@export_range(0,1) var deceleracion_al_saltar = 0.1
const PUSH_FORCE = 250.0
const MAX_VELOCITY = 150.0
#var escena_principal
func _ready() -> void:
	#escena_principal = $".."

	Global.jugador_entro_en_area_de_luz_signal.connect(jugador_entro_en_area_de_luz)
	
	Global.jugador_salio_de_area_de_luz_signal.connect(jugador_salio_en_area_de_luz)
	
	Global.restar_vida.connect(_on_restar_vida_player)


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


	var direction := Input.get_axis("mover_derecha", "mover_izquierda")
	if direction:
		velocity.x = move_toward(velocity.x , direction * velocidad, velocidad * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad_de_movimiento * deceleracion)

	


	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var colision_caja = collision.get_collider()
		#if colision_caja.is_in_group("Cajas") and abs(colision_caja.get_linear_velocity().x) < MAX_VELOCITY:
			#colision_caja.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
			
	move_and_slide()

	# esto soluciona lo de las cajas y evita que quite salto cuando estoy encima
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		var rb := c.get_collider()
		if rb is RigidBody2D:
			var n := c.get_normal()            # normal apunta desde la caja hacia afuera
			# ignorar suelo/techo: sólo empujar si la colisión es principalmente de costado
			if abs(n.y) < 0.5:
				# empujón lateral
				var push_dir := Vector2(-sign(n.x), 0.0)
				var speed_factor = clamp(abs(velocity.x) / 200.0, 0.3, 1.0)
				rb.apply_central_impulse(push_dir * PUSH_FORCE * speed_factor)
				#esto + cambiarle la colission a la caja por un circulo lo soluciona igual sigo buscando si puede mejorarse el comportamiento
				# a veces como que tiene tirones y empuja mucho pero ya no se traba


func jugador_entro_en_area_de_luz(numero : int, daño_recibido):
	match numero : 
		1: 
			print("El jugador entro en el area de luz 1")
			Global.restar_vida.emit(daño_recibido) #quito 5 de vida
		2:
			print("El jugador entro en el area de luz 2")
			Global.restar_vida.emit(daño_recibido) #quito 5 de vida
		3:
			print("El jugador entro en el area de luz 3")
			Global.restar_vida.emit(daño_recibido) #quito 5 de vida
		4:
			print("El jugador entro en el area de luz 4")
			Global.restar_vida.emit(daño_recibido) #quito 5 de vida
	
	
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
