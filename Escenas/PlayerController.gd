extends CharacterBody2D

@export var vida : int = 100
@export var velocidad_de_movimiento = 250.0
@export var velocidad_de_correr = 300.0
@export var fuerza_de_salto = -555.0
@export_range(0,1) var acceleration = 0.1
@export_range(0,1) var deceleracion = 0.1
@export_range(0,1) var deceleracion_al_saltar = 0.1

@export var PUSH_FORCE = 300.0
const MAX_VELOCITY = 150.0
@onready var coyote_timer = $CoyoteTimer #REVISAR COYOTE TIMER PORQUE LO TUVE QUE AGREGAR MANUALMENTE
@onready var audio_pasos: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_saltos: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_dolor: AudioStreamPlayer = $AudioStreamDolor
var sonido_dolor = preload("res://Audio/SFX/Dolor.wav")
@export var animaciones : AnimatedSprite2D 
const sonido_de_salto = {
	"saltos":[preload("res://Audio/SFX/Salto1.wav"),
	preload("res://Audio/SFX/Salto2.wav"),
	preload("res://Audio/SFX/Salto3.wav")
	]
}
const sonido_de_pasos = {
	"pasos": [preload("res://Audio/SFX/PasosPersonaje1.wav"),
	preload("res://Audio/SFX/PasosPersonaje2.wav")
	]
}

var puede_sonar_paso := true 


var estaba_en_el_piso := false
#var escena_principal
func _ready() -> void:
	#escena_principal = $".."

	Global.jugador_entro_en_area_de_luz_signal.connect(jugador_entro_en_area_de_luz)
	
	Global.jugador_salio_de_area_de_luz_signal.connect(jugador_salio_en_area_de_luz)
	
	Global.restar_vida.connect(_on_restar_vida_player)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	Global.set_posicion_global_player(global_position) #le paso la posicion global al raycast
	
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("saltar") and (is_on_floor() || !coyote_timer.is_stopped()):
		velocity.y = fuerza_de_salto
		animaciones.play("salto")
	if Input.is_action_just_released("saltar") and velocity.y < 0:	
		velocity.y *= deceleracion_al_saltar
		_reproducir_salto()
	
		
	var velocidad
	if Input.is_action_pressed("correr"):
		velocidad = velocidad_de_correr
	else:
		velocidad = velocidad_de_movimiento
		

	var direction := Input.get_axis("mover_izquierda", "mover_derecha")
	if direction:
		velocity.x = move_toward(velocity.x, direction * velocidad_de_movimiento, velocidad_de_movimiento * acceleration)
		animaciones.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad_de_movimiento * deceleracion)

	# --- Salto ---
	if Input.is_action_just_pressed("saltar") and (is_on_floor() or !coyote_timer.is_stopped()):
		velocity.y = fuerza_de_salto

	# --- Animaciones ---
	if not is_on_floor():
		# En el aire: diferenciamos subida y bajada
		if velocity.y < 0:
			animaciones.play("salto") # Subiendo
		else:
			animaciones.play("caer")  # Bajando
	else:
		# En el piso
		if direction != 0:
			animaciones.play("correr")
		else:
			animaciones.play("default")

	# --- Movimiento vertical ---
	if not is_on_floor():
		velocity += get_gravity() * delta

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
		#COYOTE TIME
	if estaba_en_el_piso and not is_on_floor():
		coyote_timer.start()
	estaba_en_el_piso = is_on_floor()
	
		# --- SONIDO DE PASOS ---
	if is_on_floor() and abs(velocity.x) > 10:
		if puede_sonar_paso and not audio_pasos.playing:
			_reproducir_paso()
	else:
		puede_sonar_paso = true   # reseteo para que pueda sonar el próximo paso

func _reproducir_salto():
	# elijo un sonido al azar
	var sonidos = sonido_de_salto["saltos"]
	var sonido_random = sonidos[randi() % sonidos.size()]
	audio_saltos.stream = sonido_random
	audio_saltos.play()
	
	
func _reproducir_paso():
	# elijo un sonido al azar
	var sonidos = sonido_de_pasos["pasos"]
	var sonido_random = sonidos[randi() % sonidos.size()]
	audio_pasos.stream = sonido_random
	audio_pasos.play()
	puede_sonar_paso = false
	# espero al final del sonido para permitir otro paso
	await audio_pasos.finished
	puede_sonar_paso = true
	
func _reproducir_sonido_dolor():
	audio_dolor.stream = sonido_dolor
	audio_dolor.play()
	
	
	
	
	
	
	#hola brian esto lo comento porque hacia que quitara salto estando encima de la caja
	#rarisimo el porque pasaba
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var colision_caja = collision.get_collider()
		#if colision_caja.is_in_group("Cajas"):
			#var direccion_empuje = velocity.normalized() #para donde se mueve el player
			#colision_caja.apply_central_force(direccion_empuje * PUSH_FORCE)
	#	if colision_caja.is_in_group("Cajas") and abs(colision_caja.get_linear_velocity().x) < MAX_VELOCITY:
	#		colision_caja.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)


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
	queue_free()
	#cuando perdes se llama a esta funcion
	#aca esta ideal para poner sonidos, animacion de morir y demas
	pass


func _on_restar_vida_player(cantidad_a_restar: int):
	vida -= cantidad_a_restar
	print("la vida de player vale: ", vida)
	
	if vida<= 0:
		Global.game_over.emit() #le avisa al HUD que muestre el mensaje de game over y boton de reiniciar
		game_over_player()
		
	if cantidad_a_restar != 0:
		return true
