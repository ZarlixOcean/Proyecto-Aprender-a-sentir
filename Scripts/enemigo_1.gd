extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Personaje"):
		get_tree().reload_current_scene()

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Personaje"):
		get_tree().reload_current_scene()
