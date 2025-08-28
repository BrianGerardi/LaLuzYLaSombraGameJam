extends Node2D

@export_file("*.tscn") var siguiente_nivel : String

#intrucciones para usar: Agregar la escena GanarNivel al nivel en desarrollo
#click en el nodo y en el editor seleccionar la escena del nivel al que tiene que ir cuando ganas

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") : #+ otra area de sombra
		#+ la sombra... llegan al mismo tiempo 
		Global.ganar_nivel.emit()
		cargar_nivel_nuevo()


func cargar_nivel_nuevo():
	get_tree().change_scene_to_file(siguiente_nivel)


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
