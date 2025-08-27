extends StaticBody2D


@export var id_puerta : int
@export var sprite_puerta_abierta: Sprite2D
@onready var collision_puerta_abierta: CollisionShape2D = %CollisionPuertaAbierta


func _ready() -> void:
	Global.usar_palanca_id.connect(_on_usar_palanca)


func _process(delta: float) -> void:
	pass

func _on_usar_palanca(identificador : int):
	if identificador != id_puerta:
		return
	abrir_puerta()


func abrir_puerta():
	sprite_puerta_abierta.hide()
	collision_puerta_abierta.set_deferred("disabled", true)
	print("puerta abierta")
	#si hubieran animaciones tambien hay que ejecutarlas aca
