extends VideoStreamPlayer

@export var siguiente_escena: String = "res://Escenas/Felicidad_1.tscn"

func _ready():
	finished.connect(_on_video_finished)

func _on_video_finished():
	get_tree().change_scene_to_file(siguiente_escena)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		_on_video_finished()