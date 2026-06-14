extends CanvasLayer

@onready var items_label = $ItemsLabel
@onready var level_label = $LevelLabel

func _ready():
	GameManager.items_updated.connect(_update_items)
	_update_items(0, GameManager.items_needed.get(GameManager.current_level, 5))
	level_label.text = "Nivel %d" % GameManager.current_level

func _update_items(collected: int, total: int):
	items_label.text = "Estrellas: %d/%d" % [collected, total]