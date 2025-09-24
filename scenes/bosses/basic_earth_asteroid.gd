#earth boss asteroid
extends Area2D

#linked variables
@onready var healthbar: Healthbar = $Healthbar
@onready var asteroid_timer: Timer = $AsteroidTimer
@export var regular_asteroid = preload("res://scenes/asteroids/regular_asteroid.tscn")

#asteroid properties
var movement_speed: int = 100
var max_health: int = 500
var health: int = 500

#random values
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	#set health
	healthbar.set_max_health(max_health)
	healthbar.set_health(health)
	asteroid_timer.start()

func _process(delta: float) -> void:
	#handle movement
	if position.y <=0:
		position.y += movement_speed*delta

func _on_area_entered(area: Area2D) -> void:
	#bullet collision
	if area.get_collision_layer_value(4):
		var new_health = healthbar.get_health() - area.get_damage()
		healthbar.set_health(new_health)

#boss defeated
func _on_healthbar_health_depleted() -> void:
	#remove asteroids
	var asteroids = get_tree().get_nodes_in_group("Asteroids")
	for spawned_asteroid in asteroids:
		spawned_asteroid.queue_free()
	
	#remove boss
	queue_free()

func _on_asteroid_timer_timeout() -> void:
	#create new asteroid
	var random_x = rng.randf_range(400, 1500)
	var new_asteroid = regular_asteroid.instantiate()
	new_asteroid.position = Vector2(random_x, 32)
	new_asteroid.add_to_group("Asteroids")
	get_tree().current_scene.add_child(new_asteroid)
