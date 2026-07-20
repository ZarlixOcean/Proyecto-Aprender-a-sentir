extends Node

@export var luz_punto: PointLight2D
@export var modulador: CanvasModulate

var oscuridad_inicial := Color(0.03, 0.03, 0.08)
var escala_luz_inicial := 0.5
var escala_luz_final := 5.0

func _ready():
	GameManager.items_updated.connect(_on_items_updated)
	_actualizar_luz(0, GameManager.items_needed.get(GameManager.current_level, 5))

func _on_items_updated(recolectadas: int, total: int):
	_actualizar_luz(recolectadas, total)

func _actualizar_luz(recolectadas: int, total: int):
	var progreso = float(recolectadas) / total if total > 0 else 0.0
	if modulador:
		modulador.color = oscuridad_inicial.lerp(Color.WHITE, progreso)
	if luz_punto:
		luz_punto.texture_scale = lerp(escala_luz_inicial, escala_luz_final, progreso)
