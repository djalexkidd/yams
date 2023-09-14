extends TextureButton

func _on_toggled(button_pressed):
	if button_pressed:
		$Select.play()
	else:
		$Deselect.play()

func change_number(number):
	texture_normal = load("res://assets/dice/" + str(number) + ".png")
