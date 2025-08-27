extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_de_daño_1_body_entered(body:Node2D) -> void:
	if body.name != "Player":
		return
	Global.jugador_entro_en_area_de_luz_lvl1_signal.emit()

func _on_area_de_daño_2_body_entered(body:Node2D) -> void:
	if body.name != "Player":
		return
	Global.jugador_entro_en_area_de_luz_lvl2_signal.emit()

func _on_area_de_daño_3_body_entered(body:Node2D) -> void:
	if body.name != "Player":
		return
	Global.jugador_entro_en_area_de_luz_lvl3_signal.emit()

func _on_area_de_daño_4_body_entered(body:Node2D) -> void:
	if body.name != "Player":
		return
	Global.jugador_entro_en_area_de_luz_lvl4_signal.emit()
	
