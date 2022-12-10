extends KinematicBody2D

class_name SpaceShip

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var cam: Camera2D = $Camera
export (float) var rotation_speed = 2
var rotation_dir := 0

var acceleration_input: Vector2 = Vector2.ZERO
export var acceleration_gravity: Vector2 = Vector2.ZERO
var acceleration_impact: Vector2 = Vector2.ZERO
var total_acceleration: Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

var acceleration_coefficient := 350
var max_speed := 400
var stop_pump := 5 # ?
export var mass := 1
export var arrayOfNearbyPlanets = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam.make_current()

func _physics_process(delta: float) -> void:
	mommy_rotation()
	throttler()
	throttle_stop(delta)
	calculate_grav_accel()
	if (Input.is_action_just_pressed("debug")):
		print_debug(acceleration_gravity)
	
	rotation += rotation_speed * delta * rotation_dir
	
	total_acceleration = acceleration_input + acceleration_impact + acceleration_gravity
	#velocity += gravity_velocity * 
	velocity += total_acceleration * delta * acceleration_coefficient
	
	#acceleration_gravity = Vector2.ZERO
	
	if velocity.length() > max_speed:
		velocity = velocity * (max_speed / velocity.length())
		acceleration_input = Vector2.ZERO
		
	if (Input.is_action_pressed("stop") and velocity.length() < 10):
		velocity = Vector2.ZERO
	
	move_and_slide(velocity)

func calculate_grav_accel() -> void:
	acceleration_gravity = Vector2.ZERO
	for planet in arrayOfNearbyPlanets:
		var relative_position : Vector2 = Vector2(	planet.global_position.x - global_position.x,
													planet.global_position.y - global_position.y)
		var gra_force = planet.mass * planet.gra_constant / pow(relative_position.length(),1)
		var accel = relative_position * ((gra_force / mass) / relative_position.length())
		acceleration_gravity += accel

func mommy_rotation() -> void:
	if Input.is_action_pressed("left_rotate"):
		rotation_dir = -1
	elif Input.is_action_pressed("right_rotate"):
		rotation_dir = 1
	else:
		rotation_dir = 0

func throttler() -> void:
	if Input.is_action_pressed("accelerate") and arrayOfNearbyPlanets.size() == 0:
		acceleration_input = Vector2(0.0,-1.0).rotated(rotation)
	elif Input.is_action_pressed("accelerate"):
		acceleration_input = Vector2(0.0,-3.0).rotated(rotation)
	else:
		acceleration_input = Vector2.ZERO
		
func throttle_stop(delta: float) -> void:
	if Input.is_action_pressed("stop") and velocity.length() > 0:
		acceleration_input = -(velocity / (delta * acceleration_coefficient * stop_pump)) - acceleration_gravity - acceleration_impact
		acceleration_input = acceleration_input * (1.0 / acceleration_input.length())
		
		

