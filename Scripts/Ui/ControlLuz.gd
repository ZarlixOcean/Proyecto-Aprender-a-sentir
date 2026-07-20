extends CanvasLayer

var color_rect: ColorRect
var material: ShaderMaterial

func _ready():
	layer = 1

	color_rect = ColorRect.new()
	color_rect.anchors_preset = Control.PRESET_FULL_RECT
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	color_rect.color = Color.BLACK

	material = ShaderMaterial.new()
	material.shader = preload("res://Shaders/oscuridad.gdshader")
	color_rect.material = material

	add_child(color_rect)

	GameManager.items_updated.connect(_on_items_updated)
	_actualizar_luz(0, GameManager.items_needed.get(GameManager.current_level, 5))

func _process(_delta):
	var player = get_tree().get_first_node_in_group("Personaje")
	if not player or not material:
		return

	var viewport = get_viewport()
	var canvas_transform = viewport.get_canvas_transform()
	var player_screen = canvas_transform * player.global_position
	var screen_size = viewport.size
	material.set_shader_parameter("player_uv", player_screen / screen_size)

func _on_items_updated(recolectadas: int, total: int):
	_actualizar_luz(recolectadas, total)

func _actualizar_luz(recolectadas: int, total: int):
	var progreso = float(recolectadas) / total if total > 0 else 0.0
	if material:
		material.set_shader_parameter("radio", lerp(0.12, 0.65, progreso))
		material.set_shader_parameter("progreso", progreso)
