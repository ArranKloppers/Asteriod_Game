#turret placement square
extends TextureButton

#turret variables
var normal_turret = preload("res://scenes/turrets/normal_turret.tscn")
var piercing_turret = preload("res://scenes/turrets/piercing_turret.tscn")

@onready var turret_menu: TextureRect = $TurretMenu

func _on_toggled(toggled_on: bool) -> void:
	#show and hide menu
	if (toggled_on == true):
		turret_menu.visible = true
	else:
		turret_menu.visible = false

func _on_turret_menu_turret_selected(type: int) -> void:
	#add normal turret
	if (type == 1):
		var new_turret = normal_turret.instantiate()
		new_turret.position = Vector2((position.x*2+size.x)/2, (position.y*2+size.y)/2)
		get_tree().current_scene.add_child(new_turret)
		turret_menu.visible = false
		self.queue_free()
	#add piercing turret
	elif (type == 2):
		var new_turret = piercing_turret.instantiate()
		new_turret.position = Vector2((position.x*2+size.x)/2, (position.y*2+size.y)/2)
		get_tree().current_scene.add_child(new_turret)
		turret_menu.visible = false
		self.queue_free()
