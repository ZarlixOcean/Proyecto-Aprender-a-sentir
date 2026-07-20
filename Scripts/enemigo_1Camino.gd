extends Node2D

const speed = 40

var direccion = 1

@onready var ray_cast_derecha: RayCast2D = $RayCastDerecha
@onready var ray_cast_izquierda: RayCast2D = $RayCastIzquierda

func _pisar(body):
	body.velocity.y = -380
	queue_free()

func _morir(body):
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Personaje"):
		if body.velocity.y > 0:
			_pisar(body)
		else:
			_morir(body)

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Personaje"):
		if body.velocity.y > 0:
			_pisar(body)
		else:
			_morir(body)

func _process(delta: float) -> void:
	if ray_cast_derecha.is_colliding():
		direccion = -1
	if ray_cast_izquierda.is_colliding():
		direccion = 1
	position.x += direccion * speed * delta
