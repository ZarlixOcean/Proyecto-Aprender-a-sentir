extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Personaje"):
		if body.velocity.y > 0 and body.global_position.y < get_parent().global_position.y:
			body.velocity.y = -380
			get_parent().queue_free()
		else:
			GameManager.reset_items()
			get_tree().reload_current_scene()
