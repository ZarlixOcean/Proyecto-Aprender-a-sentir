extends Node

signal items_updated(collected: int, total: int)
signal all_items_collected
signal final_item_collected

var current_level: int = 1
var items_collected: int = 0
var items_needed: Dictionary = {
	1: 5, 2: 5, 3: 6, 4: 6, 5: 7
}
var final_item_active: bool = false

func _ready():
	reset_items()

func reset_items():
	items_collected = 0
	final_item_active = false
	items_updated.emit(0, items_needed.get(current_level, 5))

func collect_item():
	items_collected += 1
	var total = items_needed.get(current_level, 5)
	items_updated.emit(items_collected, total)
	print("Items: ", items_collected, "/", total)
	if items_collected >= total and not final_item_active:
		final_item_active = true
		all_items_collected.emit()

func collect_final_item():
	final_item_collected.emit()
	print("¡Corazón recolectado! Nivel completado.")
