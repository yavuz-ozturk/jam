extends Planet


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_winArea_body_entered(body):
	if body is SpaceShip:
		get_tree().change_scene("res://src/EndGame.tscn")
