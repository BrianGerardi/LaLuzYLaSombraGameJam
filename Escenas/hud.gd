extends Control

@export var barra_de_vida : ProgressBar
@export var layer_perder : CanvasLayer
#por ahora HUD maneja la vida, cuando perdes y como reiniciar el nivel
func _ready() -> void:
	Global.game_over.connect(_on_game_over)
	Global.restar_vida.connect(_on_actualizar_vida_player)
	layer_perder.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_actualizar_vida_player(restar_vida : int):
	barra_de_vida.value -= restar_vida


func _on_game_over():
	layer_perder.show()


func _on_button_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()
