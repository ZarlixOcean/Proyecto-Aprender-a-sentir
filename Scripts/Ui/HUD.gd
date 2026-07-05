extends CanvasLayer

@onready var label = $Label

func _ready():
	GameManager.items_updated.connect(_actualizar)
	GameManager.all_items_collected.connect(_mostrar_mensaje_final)
	_actualizar(0, GameManager.items_needed.get(GameManager.current_level, 5))

func _actualizar(recolectadas: int, total: int):
	label.text = "Items: %d/%d" % [recolectadas, total]

func _mostrar_mensaje_final():
	label.text = "¡Busca el corazón!"
	label.modulate = Color.GOLD
