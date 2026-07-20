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
		GameManager.current_level = siguiente_nivel
		GameManager.reset_items()
		if siguiente_nivel <= 5:
			get_tree().change_scene_to_file("res://Escenas/Niveles/Level%d.tscn" % siguiente_nivel)
		else:
			get_tree().change_scene_to_file("res://Escenas/Ui/Creditos.tscn")