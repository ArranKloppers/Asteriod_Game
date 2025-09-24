#normal turret
extends Node2D

#linked variables
@export var bullet_scene = preload("res://scenes/bullets/normal_bullet.tscn")
@onready var timer: Timer = $Timer
@onready var muzzle: Marker2D = $Muzzle

#turret properties
@export var fire_rate: float = 0.5
@export var fire_range: float = 800.0
@export var bullet_damage: int = 5

var target: Node2D = null

func _ready() -> void:
	look_at(Vector2(position.x, 0))
	timer.wait_time = fire_rate
	timer.start()

func _process(_delta: float) -> void:
	#targeting
	find_target()
	if target:
		look_at(target.global_position)

func find_target() -> void:
	#find closest asteroid
	var asteroids = get_tree().get_nodes_in_group("Asteroids")
	var nearest_dist = fire_range
	var nearest = null

	for asteroid in asteroids:
		var dist = global_position.distance_to(asteroid.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = asteroid

	target = nearest

func shoot() -> void:
	#create bullet
	var bullet = bullet_scene.instantiate()
	bullet.set_damage(bullet_damage)
	bullet.global_position = muzzle.global_position
	bullet.direction = (target.global_position - global_position).normalized()
	bullet.look_at(target.global_position)
	get_tree().current_scene.add_child(bullet)

func _on_timer_timeout() -> void:
	if target:
		shoot()
