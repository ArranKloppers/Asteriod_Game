#game quit button
extends TextureButton

func _on_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/game/game_menu.tscn")
