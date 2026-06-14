extends Node

signal items_updated(collected: int, total: int)
signal level_completed(level: int)

var current_level: int = 1
var items_collected: int = 0
var items_needed: Dictionary = {1: 5, 2: 5, 3: 6, 4: 6, 5: 7}

func collect_item():
	items_collected += 1
	var total = items_needed.get(current_level, 5)
	items_updated.emit(items_collected, total)
	if items_collected >= total:
		level_completed.emit(current_level)
