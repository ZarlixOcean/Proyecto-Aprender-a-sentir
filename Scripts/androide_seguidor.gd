extends CharacterBody2D

@export var velocidad: float = 120.0
@export var distancia_minima: float = 100.0
@export var offset_y: float = -250.0
@export var amplitud_bobbing: float = 6.0
@export var frecuencia_bobbing: float = 2.0

@onready var sprite: Node2D = $Sprite2D

var jugador: Node2D
var _tiempo: float = 0.0

func _ready() -> void:
	jugador = get_tree().get_first_node_in_group("Personaje")
	if jugador == null:
		push_warning("Sentix Androide: no se encontró nodo en grupo 'Personaje'.")
		return
	global_position = jugador.global_position + Vector2(0, offset_y)

func _process(delta: float) -> void:
	_tiempo += delta
	if jugador == null or not is_instance_valid(jugador):
		return

	var destino_x: float = jugador.global_position.x
	var destino_y: float = jugador.global_position.y + offset_y

	var diferencia := global_position - Vector2(destino_x, destino_y)
	var distancia := diferencia.length()

	if distancia > distancia_minima:
		var direccion := diferencia.normalized()
		var paso := velocidad * delta
		if paso > distancia - distancia_minima:
			paso = distancia - distancia_minima
		var nuevo_x: float = global_position.x - direccion.x * paso
		var nuevo_y: float = global_position.y - direccion.y * paso
		var bob := sin(_tiempo * frecuencia_bobbing) * amplitud_bobbing
		global_position = Vector2(nuevo_x, nuevo_y + bob)
		if sprite and abs(direccion.x) > 0.01:
			sprite.flip_h = direccion.x > 0
	else:
		var bob := sin(_tiempo * frecuencia_bobbing) * amplitud_bobbing
		global_position = Vector2(destino_x, destino_y + bob)
