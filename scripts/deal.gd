extends VBoxContainer

signal deal

func _on_deal_button_1_pressed():
	var dices_selected = 0
	for dice in get_node("../Dices/HBoxContainer").get_children():
		if dice is TextureButton and dice.button_pressed:
			dices_selected += 1
	
	if dices_selected > 0:
		$DealButton1.disabled = true
		deal.emit()

func _on_deal_button_2_pressed():
	var dices_selected = 0
	for dice in get_node("../Dices/HBoxContainer").get_children():
		if dice is TextureButton and dice.button_pressed:
			dices_selected += 1
	
	if dices_selected > 0:
		$DealButton2.disabled = true
		deal.emit()
