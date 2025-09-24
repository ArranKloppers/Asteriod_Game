#normal asteroid
extends Area2D

@onready var healthbar: Healthbar = $Healthbar

#asteroid properties
@export var damage: int = 5 : set = set_damage, get = get_damage
@export var movement_speed: int = 100 : set = set_movement_speed, get = get_movement_speed
var max_health: int = 10
var health: int = 10

#random values
var rng = RandomNumberGenerator.new()
var x_movement = rng.randf_range(-0.5, 0.5)
var rotation_value = rng.randf_range(-1.5, 1.5)

func _ready() -> void:
	#set health
	healthbar.set_max_health(max_health)
	healthbar.set_health(health)

func _process(delta: float) -> void:
	#handle movement
	position += Vector2(x_movement*movement_speed*delta, movement_speed*delta)
	rotation_degrees += rotation_value
	
	#remove when off screen
	if not get_viewport_rect().has_point(global_position):
		queue_free()

#change properties
func set_damage(value: int):
	damage = 1 if value <= 0 else value

func get_damage() -> int:
	return damage

func set_movement_speed(value: int):
	movement_speed = 1 if value <= 0 else value

func get_movement_speed() -> int:
	return movement_speed

#collision handler
func _on_area_entered(area: Area2D) -> void:
	#border collision
	if area.get_collision_layer_value(3):
		x_movement *= -1
	#bullet collision
	if area.get_collision_layer_value(4):
		var new_health = healthbar.get_health() - area.get_damage()
		healthbar.set_health(new_health)
	#earth collision
	if area.get_collision_layer_value(1):
		queue_free()

#asteroid destroyed
func _on_healthbar_health_depleted() -> void:
	queue_free()
