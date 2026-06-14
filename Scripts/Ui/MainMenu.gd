extends Control

func _ready():
    pass

func _on_start_pressed():
    GameManager.change_level(1)

func _on_quit_pressed():
    get_tree().quit()