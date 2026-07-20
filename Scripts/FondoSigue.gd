extends Sprite2D

func _process(_delta):
	var player = get_tree().get_first_node_in_group("Personaje")
	if player:
		global_position.x = player.global_position.x
