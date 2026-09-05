extends CharacterBody2D

@export var velocidad: float = 220.0
@export var offset_y: float = -40.0
@export var offset_x: float = -25.0
@export var amplitud_bobbing: float = 6.0
@export var frecuencia_bobbing: float = 2.5

@onready var sprite: Node2D = $Sprite2D

var jugador: CharacterBody2D
var _tiempo: float = 0.0
var _dir_visual: float = 1.0

func _ready() -> void:
	z_index = -1
	jugador = get_tree().get_first_node_in_group("Personaje")
	if jugador == null:
		push_warning("Sentix Androide: no se encontró nodo en grupo 'Personaje'.")
		return
	global_position = jugador.global_position + Vector2(offset_x, offset_y)

func _process(delta: float) -> void:
	_tiempo += delta
	if jugador == null or not is_instance_valid(jugador):
		return

	var destino_x: float = jugador.global_position.x + offset_x
	var destino_y: float = jugador.global_position.y + offset_y
	var destino := Vector2(destino_x, destino_y)

	var factor: float = 1.0 - exp(-velocidad * delta)
	var nueva_pos: Vector2 = global_position.lerp(destino, factor)

	var bob: float = sin(_tiempo * frecuencia_bobbing) * amplitud_bobbing
	global_position = Vector2(nueva_pos.x, nueva_pos.y + bob)

	if sprite and abs(jugador.velocity.x) > 0.01:
		var dir_objetivo: float = 1.0 if jugador.velocity.x < 0 else -1.0
		_dir_visual = move_toward(_dir_visual, dir_objetivo, delta * 6.0)
		sprite.scale.x = abs(sprite.scale.x) * _dir_visual

