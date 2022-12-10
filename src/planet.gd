extends StaticBody2D

class_name Planet

var gra_constant := 150 # G in da formula
export var mass := 700 # default val?

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
