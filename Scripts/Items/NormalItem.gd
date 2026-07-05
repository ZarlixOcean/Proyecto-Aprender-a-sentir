extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Personaje"):
		GameManager.collect_item()
		call_deferred("queue_free")