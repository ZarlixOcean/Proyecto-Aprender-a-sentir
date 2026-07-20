extends CanvasLayer

func _ready():
	print("MensajeAlegria: _ready() llamado")
	follow_viewport_enabled = true
	layer = 128

	var debug := Label.new()
	debug.text = "DEBUG: MensajesAlegria activo"
	debug.position = Vector2(10, 10)
	debug.add_theme_color_override("font_color", Color.GREEN)
	add_child(debug)
	print("MensajeAlegria: Label debug agregado")

	GameManager.show_alegria_message.connect(_mostrar)
	print("MensajeAlegria: Conectado a signal show_alegria_message")

func _mostrar(id: int):
	print("MensajeAlegria: _mostrar(%d) llamado" % id)
	if id < 1 or id > 16:
		print("MensajeAlegria: id fuera de rango")
		return

	var texture = load("res://Sprites/Mensajes/Mensaje_de_alegria_%d.png" % id)
	print("MensajeAlegria: texture cargada = ", texture)
	if not texture:
		return

	var msg := TextureRect.new()
	msg.texture = texture
	msg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	msg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	msg.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var tam := texture.get_size() * 0.8
	msg.size = tam
	print("MensajeAlegria: tam = ", tam)

	var screen := get_viewport().get_visible_rect().size
	print("MensajeAlegria: screen = ", screen)
	msg.position = (screen - tam) / 2
	print("MensajeAlegria: position = ", msg.position)

	add_child(msg)
	print("MensajeAlegria: TextureRect agregado como hijo")

	msg.modulate.a = 0.0
	var tween := create_tween()
	print("MensajeAlegria: tween creado")
	tween.tween_property(msg, "modulate:a", 1.0, 0.3)
	tween.tween_interval(2.5)
	tween.tween_property(msg, "modulate:a", 0.0, 0.5)
	tween.tween_callback(msg.queue_free)
	print("MensajeAlegria: animacion configurada")
