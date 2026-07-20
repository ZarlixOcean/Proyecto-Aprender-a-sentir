extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Personaje"):
		var parent = get_parent()
		if parent.get_script() != null and body.velocity.y > 0:
			body.velocity.y = -380
			parent.queue_free()
		else:
			GameManager.reset_items()
			get_tree().reload_current_scene()
