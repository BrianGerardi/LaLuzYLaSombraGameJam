extends Control

@onready var button_audio: AudioStreamPlayer = $ButtonAudio

func _ready() -> void:
	Global.set_nivel_actual(0)

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	button_audio.play()
	await get_tree().create_timer(0.0).timeout
	get_tree().change_scene_to_file("res://Escenas/Niveles/NivelTutorial.tscn")
