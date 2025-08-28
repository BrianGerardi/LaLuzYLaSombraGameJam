extends Node2D

@export_file("*.tscn") var siguiente_nivel : String
var player_entro : bool = false
var sombra_entro : bool = false
#intrucciones para usar: Agregar la escena GanarNivel al nivel en desarrollo
#click en el nodo y en el editor seleccionar la escena del nivel al que tiene que ir cuando ganas

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") :
		print("entro el player")
		player_entro = true
		cargar_nivel_nuevo() #como no se exactamente quien entra primero triggereo cuando entran ambos


func cargar_nivel_nuevo():
	if player_entro and sombra_entro:
		Global.ganar_nivel.emit()
		call_deferred("cambiar_escena")
	else:
		print("falta uno de los personajes en el area ganar")

func cambiar_escena(): #esta esta porque sino no podia meter el call deferred y godot se quejaba
	get_tree().change_scene_to_file(siguiente_nivel)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entro = false


func _on_area_2d_sombra_body_entered(body: Node2D) -> void: #solo sombra
	if body.is_in_group("Player_sombra"):
		print("entro la sombra")
		sombra_entro = true
		cargar_nivel_nuevo()


func _on_area_2d_sombra_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player_sombra"):
		sombra_entro = false
