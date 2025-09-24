#game manager
extends Node2D

#linked variables
@onready var asteroid_timer: Timer = $Timers/AsteroidTimer
@onready var round_timer: Timer = $Timers/RoundTimer
@onready var buildup_timer: Timer = $Timers/BuildupTimer
@onready var boss_label: Label = $BossLabel
var regular_asteroid = preload("res://scenes/asteroids/regular_asteroid.tscn")
var brute_asteroid = preload("res://scenes/asteroids/brute_asteroid.tscn")
var normal_turret = preload("res://scenes/turrets/normal_turret.tscn")
var earth_asteroid = preload("res://scenes/bosses/basic_earth_asteroid.tscn")

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	#add initial turret
	if (get_tree().current_scene != self):
		get_tree().current_scene = self
	add_turret()
	
	#start timers
	asteroid_timer.start()
	round_timer.start()

#add initial turret
func add_turret():
	var new_turret = normal_turret.instantiate()
	new_turret.position = Vector2(950, 699)
	get_tree().current_scene.add_child(new_turret)

func _on_asteroid_timer_timeout() -> void:
	#asteroid variables
	var new_asteroid
	var random_type = randi_range(1, 100)
	var random_x = randf_range(24, 1876)
	
	#select asteroid type and create asteroid
	if random_type < 60:
		new_asteroid = regular_asteroid.instantiate()
	else:
		new_asteroid = brute_asteroid.instantiate()
	
	#set asteroid properties
	new_asteroid.position = Vector2(random_x, 32)
	new_asteroid.add_to_group("Asteroids")
	get_tree().current_scene.add_child(new_asteroid)

#game over
func _on_earth_end_game() -> void:
	SceneSwitcher.switch_scene("res://scenes/game/game_menu.tscn")

#boss spawn
func _on_round_timer_timeout() -> void:
	round_timer.stop()
	asteroid_timer.stop()
	buildup_timer.start()
	boss_label.visible = true
	
	#remove asteroids
	var asteroids = get_tree().get_nodes_in_group("Asteroids")
	for asteroid in asteroids:
		asteroid.queue_free()

func _on_buildup_timer_timeout() -> void:
	buildup_timer.stop()
	boss_label.visible = false
	
	#create boss
	var new_boss = earth_asteroid.instantiate()
	new_boss.position = Vector2(950, -50)
	new_boss.add_to_group("Asteroids")
	get_tree().current_scene.add_child(new_boss)
	
	new_boss.connect("tree_exited", Callable(self, "_on_boss_removed"))

func _on_boss_removed():
	asteroid_timer.start()
	round_timer.start()
