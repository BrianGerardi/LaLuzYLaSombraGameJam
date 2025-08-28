extends CharacterBody2D

@export var velocidad = -60
var target
var mirando_derecha = false

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
