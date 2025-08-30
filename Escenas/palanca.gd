extends Node2D

#cada vez que agregamos una palanca al mapa le ponemos un ID
#solo hay que cuidar que en EL MISMO NIVEL no existan 2 palancas con el mismo id
#no hay problema que las id se repitan con otras palancas creadas en otros niveles

var palanca_usada : bool = false
var player_cerca : bool =false
@export var id_palanca : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if player_cerca:
		if Input.is_action_just_pressed("accion"):
			if palanca_usada==false: #para saber que animacion usar
				%AnimatedSprite2D.play("usar_palanca_uno")
				palanca_usada = true
			else:
				%AnimatedSprite2D.play("usar_palanca_dos")
				palanca_usada = false
			Global.usar_palanca_id.emit(id_palanca)


		#la señal va a ser escuchada por todas las puertas en el nivel pero solo la que tenga el mismo id
		#se va a abrir



func _on_area_2d_palanca_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:        #si entro el player
		player_cerca = true


func _on_area_2d_palanca_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:        #si salio el player
		player_cerca = false
