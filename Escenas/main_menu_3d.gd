extends Node3D

var nivel_tutorial = "res://Escenas/Niveles/NivelTutorial.tscn"
var textura_pressed = preload("res://Assets/MenuDeInicio/PLAY_CLICK.png")
var textura_normal = preload("res://Assets/MenuDeInicio/PLAY_NO_CLICK.png")
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boton_play_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		print("aaaaaa")
		%ImgPlay.texture = textura_pressed
		%AudioClick.play()
		await get_tree().create_timer(0.1).timeout #para darle tiempo a que se vea la textura pressed
		get_tree().change_scene_to_file(nivel_tutorial)


func _on_boton_play_mouse_entered() -> void:
	%ImgPlay.texture = textura_pressed


func _on_boton_play_mouse_exited() -> void:
	%ImgPlay.texture = textura_normal
