extends Control
@onready var start_animation_daño_hud = $CanvasLayer/TextureRect/Animation_EntroLuz
@export var barra_de_vida : ProgressBar
@export var layer_perder : CanvasLayer
var  el_jugador_esta_en_luz : bool = false
#por ahora HUD maneja la vida, cuando perdes y como reiniciar el nivel
func _ready() -> void:
	Global.game_over.connect(_on_game_over)
	Global.restar_vida.connect(_on_actualizar_vida_player)
	Global.jugador_entro_en_area_de_luz_signal.connect (_on_player_entro_a_la_luz)
	Global.jugador_salio_de_area_de_luz_signal.connect(_on_player_salio_a_la_luz)
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

func _on_player_entro_a_la_luz (daño , numero):
		start_animation_daño_hud.play("DañadoPorLuz")
		
	
func _on_player_salio_a_la_luz (numero):
	pass
	#start_animation_daño_hud("DañadoPorLuz")
	


func _on_animation_entro_luz_animation_finished(anim_name: StringName) -> void:
	if anim_name == "DañadoPorLuz":
		print ("funcino")
	pass # Replace with function body.
