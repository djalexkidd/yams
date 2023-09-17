extends Control

func _ready():
	$ScoreContainer/ScoreValueLabel.text = str(Global.last_score)

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
