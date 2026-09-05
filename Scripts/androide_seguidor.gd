extends CharacterBody2D

@export var velocidad: float = 180.0
@export var distancia_minima: float = 40.0
@export var offset_y: float = -60.0
@export var offset_x: float = 30.0
@export var amplitud_bobbing: float = 8.0
@export var frecuencia_bobbing: float = 2.5

@onready var sprite: Node2D = $Sprite2D

var jugador: CharacterBody2D
var _tiempo: float = 0.0

func _ready() -> void:
	jugador = get_tree().get_first_node_in_group("Personaje")
	if jugador == null:
		push_warning("Sentix Androide: no se encontró nodo en grupo 'Personaje'.")
		return
	global_position = jugador.global_position + Vector2(offset_x, offset_y)

func _process(delta: float) -> void:
	_tiempo += delta
	if jugador == null or not is_instance_valid(jugador):
		return

	var dir_jugador: float = sign(jugador.velocity.x)
	if dir_jugador == 0.0:
		dir_jugador = 1.0

	var destino_x: float = jugador.global_position.x + offset_x * dir_jugador
	var destino_y: float = jugador.global_position.y + offset_y
	var destino := Vector2(destino_x, destino_y)

	var factor: float = 1.0 - exp(-velocidad * delta)
	var nueva_pos: Vector2 = global_position.lerp(destino, factor)

	var bob: float = sin(_tiempo * frecuencia_bobbing) * amplitud_bobbing
	global_position = Vector2(nueva_pos.x, nueva_pos.y + bob)

	if sprite and abs(jugador.velocity.x) > 0.01:
		sprite.flip_h = jugador.velocity.x < 0
