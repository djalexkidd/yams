extends TextureButton

func _on_toggled(button_pressed):
	if button_pressed:
		$Select.play()
	else:
		$Deselect.play()
