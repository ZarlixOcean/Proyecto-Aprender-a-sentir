extends Control

var puede_continuar = false

func _ready():
	$Timer.start()
	$Timer.timeout.connect(_permitir_continuar)

func _permitir_continuar():
	puede_continuar = true

func _input(event):
	if puede_continuar and event is InputEventMouseButton and event.pressed:
		var siguiente_nivel = GameManager.current_level + 1
		if siguiente_nivel <= 2:
			GameManager.change_level(siguiente_nivel)
		else:
			get_tree().change_scene_to_file("res://Escenas/Felicidad_1.tscn")