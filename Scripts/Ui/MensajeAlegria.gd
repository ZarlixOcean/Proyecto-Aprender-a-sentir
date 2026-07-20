extends CanvasLayer

@onready var start_pos := Vector2(
	get_viewport().get_visible_rect().size.x + 200,
	20
)

func _ready():
	GameManager.show_alegria_message.connect(_mostrar)

func _mostrar(id: int):
	var texture = load("res://Sprites/Mensajes/Mensaje_de_alegria_%d.png" % id)
	if not texture:
		return

	var msg := TextureRect.new()
	msg.texture = texture
	msg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	msg.size = texture.get_size() * 0.8
	msg.position = start_pos
	msg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(msg)

	var target_x = get_viewport().get_visible_rect().size.x - msg.size.x - 20
	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(msg, "position:x", target_x, 0.4)
	tween.tween_interval(2.5)
	tween.tween_property(msg, "modulate:a", 0.0, 0.5)
	tween.tween_callback(msg.queue_free)
