extends Area2D

func _ready():
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	body_entered.connect(_on_body_entered)
	GameManager.all_items_collected.connect(_show_final_item)

func _show_final_item():
	visible = true
	$CollisionShape2D.set_deferred("disabled", false)
	var tween = create_tween().set_loops()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.5)

func _on_body_entered(body):
	if body.is_in_group("Personaje") and visible:
		GameManager.collect_final_item()
		call_deferred("queue_free")