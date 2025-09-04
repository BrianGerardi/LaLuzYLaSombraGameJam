extends Area2D
@onready var audio_pinchos: AudioStreamPlayer = AudioStreamPlayer.new()
const SONIDO_PINCHOS = preload("res://Audio/SFX/Pinchos.wav") # ajustá la ruta



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(audio_pinchos)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player_sombra":
		_reproducir_sonido_pinchos()
		Global.restar_vida.emit(100)
	if body.name == "Player":
		_reproducir_sonido_pinchos()
		Global.restar_vida.emit(100)
		
func _reproducir_sonido_pinchos():
	audio_pinchos.stream = SONIDO_PINCHOS
	audio_pinchos.volume_db = 0 # podés bajarlo/subirlo
	audio_pinchos.play()
