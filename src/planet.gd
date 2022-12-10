extends StaticBody2D

const spaceship := preload("res://src/space_ship.tscn")

signal activate_gra

class_name Planet

var gra_constant := 75 # G in da formula
export var mass := 500 # default val?
var muck
var aa = false 

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
#onready var area : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Area2D_body_entered(mucky: Node) -> void:
	if mucky is SpaceShip:
		mucky.arrayOfNearbyPlanets.append(self)

func _on_Area2D_body_exited(body: Node) -> void:
	if body is SpaceShip:
		body.arrayOfNearbyPlanets.erase(self)
