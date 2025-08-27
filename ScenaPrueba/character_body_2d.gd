extends CharacterBody2D
#variables
var direccion = Vector2 (0,0)
var velocidad = 250.0

#movimientos
func _process(delta):
	direccion = Vector2 (0,0)

	if Input.is_action_pressed("mover_izquierda"):
		direccion = Vector2 (-1,0) + direccion
	if Input.is_action_pressed("mover_derecha"):
		direccion = Vector2 (1,0) + direccion
	if Input.is_action_pressed("mover_arriba"):
		direccion = Vector2 (0,-1) + direccion
	if Input.is_action_pressed("mover_abajo"):
		direccion = Vector2 (0,1) + direccion

	velocity = direccion * velocidad
	move_and_slide()
	
