extends StaticBody2D


@export var id_puerta : int
@export var sprite_puerta_abierta: Sprite2D
@onready var collision_puerta_abierta: CollisionShape2D = %CollisionPuertaAbierta
var puerta_abierta : bool = false

func _ready() -> void:
	Global.usar_palanca_id.connect(_on_usar_palanca)


func _process(delta: float) -> void:
	pass

func _on_usar_palanca(identificador : int):
	if identificador != id_puerta:
		return
	abrir_puerta()


func abrir_puerta():
	if puerta_abierta == false:
		%AnimatedSprite2D.play("abrir")
		collision_puerta_abierta.set_deferred("disabled", true)
		print("puerta abierta")
		puerta_abierta = true
	else:
		%AnimatedSprite2D.play("cerrar")
		collision_puerta_abierta.set_deferred("disabled", false)
		print("puerta cerrada")
		puerta_abierta = false
#	%AudioPuerta.play() #siempre verificar que agregamos el audio arrastrando el archivo al editor
