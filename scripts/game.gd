extends Control

var dice = [0, 0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	reroll()

func reroll():
	randomize()
	for i in 5:
		dice[i] = randi()%6+1
		get_node("Dices/HBoxContainer/Dice" + str(i+1)).change_number(dice[i])

func _on_pause_button_pressed():
	$PausePanel.show()
	$PausePanel/PauseSound.play()

func _on_continue_button_pressed():
	$PausePanel.hide()
	$PausePanel/UnpauseSound.play()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	get_tree().quit()
