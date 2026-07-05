extends Node2D
 
const speed = 40

var direccion = 1

@onready var ray_cast_2_derecha: RayCast2D = $RayCast2Derecha
@onready var ray_cast_2_izquierda: RayCast2D = $RayCast2Izquierda

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if ray_cast_2_derecha.is_colliding():
		var colision = ray_cast_2_derecha.get_collider()
		if colision and colision.is_in_group("Personaje"):
			GameManager.reset_items()
			get_tree().reload_current_scene()
			return
		direccion = -1
	if ray_cast_2_izquierda.is_colliding():
		var colision = ray_cast_2_izquierda.get_collider()
		if colision and colision.is_in_group("Personaje"):
			GameManager.reset_items()
			get_tree().reload_current_scene()
			return
		direccion = 1
	position.x += direccion * speed * delta