extends CharacterBody2D

@export var velocidad: float = 220.0
@export var offset_y: float = -110.0
@export var offset_x: float = -35.0
@export var amplitud_bobbing: float = 6.0
@export var frecuencia_bobbing: float = 2.5
@export var duracion_giro: float = 0.25

@onready var sprite: Node2D = $Sprite2D

var jugador: CharacterBody2D
var _tiempo: float = 0.0

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

	if sprite:
		if abs(jugador.velocity.x) > 0.01:
			var debe_voltear: bool = jugador.velocity.x < 0
			if debe_voltear != (sprite.scale.x < 0):
				_animar_giro(sprite, debe_voltear)
		else:
			sprite.scale.x = abs(sprite.scale.x)

func _animar_giro(sprite: Node2D, voltear_izquierda: bool) -> void:
	var tween: Tween = create_tween()
	var escala_inicio: float = sprite.scale.x
	var escala_destino: float = -0.8 if voltear_izquierda else 0.8
	tween.tween_method(
		func(valor: float) -> void: sprite.scale.x = valor,
		escala_inicio,
		escala_destino,
		duracion_giro
	)
