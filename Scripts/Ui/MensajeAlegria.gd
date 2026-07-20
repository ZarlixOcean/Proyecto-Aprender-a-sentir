extends CanvasLayer

func _ready():
	GameManager.show_alegria_message.connect(_mostrar)

func _mostrar(id: int):
	var texture = load("res://Sprites/Mensajes/Mensaje_de_alegria_%d.png" % id)
	if not texture:
		return

	var screen := get_viewport().get_visible_rect().size
	var escala := 0.8
	var tam := texture.get_size() * escala

	var msg := TextureRect.new()
	msg.texture = texture
	msg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	msg.size = tam
	msg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(msg)

	var x_final := screen.x - tam.x - 20
	msg.position = Vector2(screen.x + 20, 20)

	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(msg, "position:x", x_final, 0.4)
	tween.tween_interval(2.5)
	tween.tween_property(msg, "modulate:a", 0.0, 0.5)
	tween.tween_callback(msg.queue_free)
