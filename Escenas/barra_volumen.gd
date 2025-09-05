extends Control

signal salir_barra_volumen


func _ready() -> void:
	$".".hide()
	$LayerColor.hide()
	$LayerVolumen.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_salir_volumen_pressed() -> void:
	print("apreteeeeeeeeeeeeee")
	salir_barra_volumen.emit()
	esconder_todo()


func _on_main_menu_3d_esconder() -> void:
	esconder_todo()

func mostrar_todo():
	$".".show()
	$LayerColor.show()
	$LayerVolumen.show()

func esconder_todo():
	$".".hide()
	$LayerColor.hide()
	$LayerVolumen.hide()
