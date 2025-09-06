extends Control

var menu_inicial = preload("res://Escenas/main_menu_3d.gd")

func _ready() -> void:
	if Global.nivel_actual_global != 0:
		Global.set_nivel_actual(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_video_stream_player_finished() -> void:
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(menu_inicial)
