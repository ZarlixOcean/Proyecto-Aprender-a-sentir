extends CanvasLayer

func _ready():
	GameManager.show_alegria_message.connect(_mostrar)

func _mostrar(id: int):
	print("Mostrando mensaje de alegría %d" % id)
	var texture = load("res://Sprites/Mensajes/Mensaje_de_alegria_%d.png" % id)
	if not texture:
		print("ERROR: No se pudo cargar la textura de mensaje %d" % id)
		return

	var msg := Sprite2D.new()
	msg.texture = texture
	msg.scale = Vector2(0.8, 0.8)

	var tam := texture.get_size() * 0.8
	var ventana := DisplayServer.window_get_size()
	print("Ventana: ", ventana, " | Textura: ", tam)
	msg.position = Vector2(ventana.x + tam.x, tam.y * 0.5 + 20)
	add_child(msg)

	var x_final := ventana.x - tam.x * 0.5 - 20
	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(msg, "position:x", x_final, 0.4)
	tween.tween_interval(2.5)
	tween.tween_property(msg, "modulate:a", 0.0, 0.5)
	tween.tween_callback(msg.queue_free)
