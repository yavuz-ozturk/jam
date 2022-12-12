extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var layer : CanvasLayer = $PauseLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Pause.custom_viewport = $Space_ship/Camera
	$Pause/Pause_Scene.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://src/world.tscn")
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			$Pause/Pause_Scene.show()
		else:
			$Pause/Pause_Scene.hide()
	pass




