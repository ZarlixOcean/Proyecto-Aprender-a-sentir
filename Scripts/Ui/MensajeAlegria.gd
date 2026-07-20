extends CanvasLayer

func _ready():
	layer = 128
	GameManager.show_alegria_message.connect(_mostrar)

func _mostrar(id: int):
	if id < 1 or id > 16:
		return

	var texture = load("res://Sprites/Mensajes/Mensaje_de_alegria_%d.png" % id)
	if not texture:
		return

	var msg := TextureRect.new()
	msg.texture = texture
	msg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	msg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	msg.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var tam: Vector2 = Vector2(texture.get_size()) * 0.35
	msg.size = tam

	var screen := get_viewport().get_visible_rect().size
	msg.position = Vector2(screen.x - tam.x - 20, 20)

	add_child(msg)

	var tween := create_tween()
	msg.modulate.a = 0.0
	tween.tween_property(msg, "modulate:a", 1.0, 0.3)
	tween.tween_interval(2.5)
	tween.tween_property(msg, "modulate:a", 0.0, 0.5)
	tween.tween_callback(msg.queue_free)
