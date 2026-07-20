extends CanvasLayer

var texturas: Array[Texture2D] = []

func _ready():
	follow_viewport_enabled = true
	layer = 128
	for i in range(1, 17):
		var tex = load("res://Sprites/Mensajes/Mensaje_de_alegria_%d.png" % i)
		if tex:
			texturas.append(tex)
		else:
			print("ERROR: No se pudo cargar textura %d" % i)
			texturas.append(null)
	GameManager.show_alegria_message.connect(_mostrar)

func _mostrar(id: int):
	if id < 1 or id > 16:
		return
	var texture = texturas[id - 1]
	if not texture:
		print("ERROR: Textura %d no disponible" % id)
		return

	var msg := TextureRect.new()
	msg.texture = texture
	msg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	msg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	msg.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var tam := texture.get_size() * 0.8
	msg.size = tam

	var screen := get_viewport().get_visible_rect().size
	msg.position = (screen - tam) / 2

	add_child(msg)

	var tween := create_tween()
	msg.modulate.a = 0.0
	tween.tween_property(msg, "modulate:a", 1.0, 0.3)
	tween.tween_interval(2.5)
	tween.tween_property(msg, "modulate:a", 0.0, 0.5)
	tween.tween_callback(msg.queue_free)
