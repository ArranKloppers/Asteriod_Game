#earth
extends Area2D

signal EndGame

#earth properties
@onready var healthbar: Healthbar = $Healthbar
var max_health: int = 100
var health: int = max_health

func _ready() -> void:
	#set health
	healthbar.set_max_health(max_health)
	healthbar.set_health(health)

func _on_area_entered(area: Area2D) -> void:
	#asteroid collision
	var new_health = healthbar.get_health() - area.get_damage()
	healthbar.set_health(new_health)

#earth destroyed
func _on_healthbar_health_depleted() -> void:
	EndGame.emit()
