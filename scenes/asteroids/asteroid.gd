extends CharacterBody2D
#varaiablles you can play around with them
@export var min_speed: float = 30
@export var max_speed: float = 60
@export var min_rotation_speed: float = -1.0
@export var max_rotation_speed: float = 1.0


#var fast_speed: float = 0.0
var fall_speed: float = 0.0
var rotation_speed: float = 0.0

func _ready():
	#random falling speed, play around with this im not sure what to put
	fall_speed = randf_range(min_speed, max_speed)

	# random spinning rotation, not sure if we need this
	rotation_speed = randf_range(min_rotation_speed, max_rotation_speed)

func _physics_process(delta):
	
	position.y += fall_speed * delta
	rotation += rotation_speed * delta

	# If it goes off the bottom they respawn at top
	var screen_size = get_viewport_rect().size
	if position.y > screen_size.y + 50:
		position.y = -50
		position.x = randf_range(0, screen_size.x)
