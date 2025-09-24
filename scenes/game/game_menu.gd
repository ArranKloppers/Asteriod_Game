extends Node2D

func _on_start_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/game/game.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
