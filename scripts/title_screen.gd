extends Control

func _ready():
	if OS.get_name() != "Android":
		$PressStart.text = "Cliquez pour jouer"

func _process(delta):
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
