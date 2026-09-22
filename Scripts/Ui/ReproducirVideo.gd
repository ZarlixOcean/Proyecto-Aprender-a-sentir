extends VideoStreamPlayer

@export var siguiente_escena: String = "res://Escenas/Felicidad_1.tscn"

@onready var musica := AudioStreamPlayer.new()

func _ready():
	var stream := load("res://Musica y sonidos/Musica nivel alegria.mp3")
	if stream:
		musica.stream = stream
		musica.autoplay = true
		add_child(musica)
	finished.connect(_on_video_finished)

func _on_video_finished():
	get_tree().change_scene_to_file(siguiente_escena)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		_on_video_finished()
