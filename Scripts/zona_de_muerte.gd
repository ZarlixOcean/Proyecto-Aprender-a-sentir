extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Personaje"):
		GameManager.reset_items()
		get_tree().reload_current_scene()
