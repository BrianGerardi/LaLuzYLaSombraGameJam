extends CharacterBody2D
@onready var audio_aparicion: AudioStreamPlayer2D = $AudioAparicion
@export var velocidad = -60
var target
var mirando_derecha = false
@export var animaciones = AnimatableBody2D

func _ready() -> void:
	animaciones.play("default")
	if audio_aparicion and not audio_aparicion.playing:
		audio_aparicion.play()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if $RayCast2D_IZQ.is_colliding() && is_on_floor():
		flip()
	
	velocity.x = velocidad
	move_and_slide()
	
	
func flip ():
	mirando_derecha = !mirando_derecha
	
	scale.x = abs (scale.x) *-1
	if mirando_derecha:
		velocidad = abs(velocidad)
	else:
		velocidad = abs(velocidad) *-1


func _on_area_detectar_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		target = body
		var direccion = target.global_position - global_position
		if direccion.x > 0:
			velocidad = abs(velocidad) 
		else:
			velocidad = -abs(velocidad)


func _on_area_pinchos_body_entered(body: Node2D) -> void:
	if body.is_in_group("Pinchos"):
		die()
		
func die ():
	if audio_aparicion:
		audio_aparicion.stop()
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player_sombra":
		Global.restar_vida.emit(100)
	if body.name == "Player":
		Global.restar_vida.emit(100)
