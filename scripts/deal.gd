extends VBoxContainer

signal deal

func _on_deal_button_1_pressed():
	$DealButton1.disabled = true
	deal.emit()
	$DealButton1.hide()

func _on_deal_button_2_pressed():
	$DealButton2.disabled = true
	deal.emit()
	$DealButton2.hide()
