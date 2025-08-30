extends StaticBody2D

@export var id_puerta : int
@export var sprite_puerta_abierta: Sprite2D
@onready var collision_puerta_abierta: CollisionShape2D = %CollisionPuertaAbierta
var puerta_abierta :bool = false

func _ready() -> void:
	Global.usar_palanca_id.connect(_on_usar_palanca)


func _process(delta: float) -> void:
	pass

func _on_usar_palanca(identificador : int):
	if identificador != id_puerta:
		return
	abrir_puerta()


func abrir_puerta():
	collision_puerta_abierta.set_deferred("disabled", true)
	if puerta_abierta == false:
		%AnimatedSprite2D.play("abrir")
	else:
		%AnimatedSprite2D.play("cerrar")
	%AudioPuerta.play() #asegurarse de haber agregado el sonido por medio del editor
	print("puerta abierta")
