extends Control

const SPRITE_SIZE := Vector2(320, 180)
const MENU_TEXTURE := preload("res://Sprites/Menú.png")
const MUSICA_LOBBY := "res://Musica y sonidos/Musica-de-lobby.mp3"

const ZONA_NIVEL_1 := Rect2(60, 140, 90, 35)
const ZONA_NIVEL_2 := Rect2(200, 140, 90, 35)

var fondo: TextureRect
var boton_nivel_1: Button
var boton_nivel_2: Button
var musica: AudioStreamPlayer

func _ready():
	_crear_ui()
	_crear_musica()
	_redimensionar()
	get_viewport().size_changed.connect(_redimensionar)

func _crear_musica():
	var stream := AudioStreamMP3.load_from_file(MUSICA_LOBBY)
	stream.loop = true
	musica = AudioStreamPlayer.new()
	musica.stream = stream
	musica.autoplay = true
	add_child(musica)

func _crear_ui():
	fondo = TextureRect.new()
	fondo.texture = MENU_TEXTURE
	fondo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	fondo.stretch_mode = TextureRect.STRETCH_SCALE
	fondo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fondo)

	boton_nivel_1 = _crear_boton(ZONA_NIVEL_1, "Comenzar Nivel 1: Alegría")
	boton_nivel_1.pressed.connect(func(): GameManager.change_level(1))
	add_child(boton_nivel_1)

	boton_nivel_2 = _crear_boton(ZONA_NIVEL_2, "Comenzar Nivel 2: Tristeza")
	boton_nivel_2.pressed.connect(func(): GameManager.change_level(2))
	add_child(boton_nivel_2)

func _crear_boton(zona: Rect2, tooltip: String) -> Button:
	var boton := Button.new()
	boton.flat = true
	boton.text = ""
	boton.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	boton.focus_mode = Control.FOCUS_NONE
	boton.position = zona.position
	boton.size = zona.size
	boton.tooltip_text = tooltip
	return boton

func _redimensionar() -> void:
	var vp := get_viewport().get_visible_rect().size
	var escala := vp / SPRITE_SIZE
	if fondo:
		fondo.position = Vector2.ZERO
		fondo.size = vp
	if boton_nivel_1:
		boton_nivel_1.position = ZONA_NIVEL_1.position * escala
		boton_nivel_1.size = ZONA_NIVEL_1.size * escala
	if boton_nivel_2:
		boton_nivel_2.position = ZONA_NIVEL_2.position * escala
		boton_nivel_2.size = ZONA_NIVEL_2.size * escala