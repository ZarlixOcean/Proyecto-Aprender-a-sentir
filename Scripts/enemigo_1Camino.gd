extends Node2D
 
const speed = 40

var direccion = 1

@onready var ray_cast_derecha: RayCast2D = $RayCastDerecha
@onready var ray_cast_izquierda: RayCast2D = $RayCastIzquierda

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("Personaje"):
		get_tree().reload_current_scene()

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Personaje"):
		get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if ray_cast_derecha.is_colliding():
		var colision = ray_cast_derecha.get_collider()
		if colision and colision.is_in_group("Personaje"):
			get_tree().reload_current_scene()
		direccion = -1
	if ray_cast_izquierda.is_colliding():
		var colision = ray_cast_izquierda.get_collider()
		if colision and colision.is_in_group("Personaje"):
			get_tree().reload_current_scene()
		direccion = 1
	position.x += direccion * speed * delta
