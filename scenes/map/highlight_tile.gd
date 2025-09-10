class_name HighlightTile
extends Node2D

func _process(_delta: float) -> void:
	follow_mouse_pos()

func follow_mouse_pos() -> void:
	var mouse_position : Vector2i = get_global_mouse_position()/64
	
	position = mouse_position*64
	
