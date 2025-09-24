#turret selection menu
extends TextureRect

signal TurretSelected(type: int)

#normal turret
func _on_turret_1_pressed() -> void:
	TurretSelected.emit(1)

#piercing turret
func _on_turret_2_pressed() -> void:
	TurretSelected.emit(2)
