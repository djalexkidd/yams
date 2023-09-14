extends GridContainer

signal next_turn

func _on_one_pressed():
	if $One.modulate == Color(0,1,0):
		$One.disabled = true
		$One.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()



func _on_four_pressed():
	if $Four.modulate == Color(0,1,0):
		$Four.disabled = true
		$Four.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()


func _on_two_pressed():
	if $Two.modulate == Color(0,1,0):
		$Two.disabled = true
		$Two.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()


func _on_five_pressed():
	if $Five.modulate == Color(0,1,0):
		$Five.disabled = true
		$Five.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()


func _on_six_pressed():
	if $Six.modulate == Color(0,1,0):
		$Six.disabled = true
		$Six.modulate = Color(0.30,0.30,0.30)
		$SixSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()


func _on_three_pressed():
	if $Three.modulate == Color(0,1,0):
		$Three.disabled = true
		$Three.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()

func _on_four_same_pressed():
	if $FourSame.modulate == Color(0,1,0):
		$FourSame.disabled = true
		$FourSame.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()

func _on_five_same_pressed():
	if $FiveSame.modulate == Color(0,1,0):
		$FiveSame.disabled = true
		$FiveSame.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()

func _on_all_different_pressed():
	if $AllDifferent.modulate == Color(0,1,0):
		$AllDifferent.disabled = true
		$AllDifferent.modulate = Color(0.30,0.30,0.30)
		$OneSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()


func _on_pairs_pressed():
	if $Pairs.modulate == Color(0,1,0):
		$Pairs.disabled = true
		$Pairs.modulate = Color(0.30,0.30,0.30)
		$ChanceSound.play()
		next_turn.emit(1)
	else:
		$ErrorSound.play()
