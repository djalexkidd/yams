extends Control

var dice = [0, 0, 0, 0, 0]
var score = 0
var score_total = 0
const score_objective = 175

# Called when the node enters the scene tree for the first time.
func _ready():
	$TaskBar/HighScoreContainer/HighScoreValueLabel.text = str(Global.high_score)
	randomize()
	for i in 5:
		if get_node("Dices/HBoxContainer/Dice" + str(i+1)):
			dice[i] = randi()%6+1
			get_node("Dices/HBoxContainer/Dice" + str(i+1)).change_number(dice[i])
	check_options()

func reroll():
	randomize()
	for i in 5:
		if get_node("Dices/HBoxContainer/Dice" + str(i+1)).button_pressed:
			dice[i] = randi()%6+1
			get_node("Dices/HBoxContainer/Dice" + str(i+1)).change_number(dice[i])
			get_node("Dices/HBoxContainer/Dice" + str(i+1)).button_pressed = false
	check_options()

# Vérifier si le joueur peut jouer
func check_options():
	if !$ScoreButtons/AllDifferent.disabled:
		if areAllNumbersDifferent(dice):
			$ScoreButtons/AllDifferent.modulate = Color(0,1,0)
		else:
			$ScoreButtons/AllDifferent.modulate = Color(1,1,1)
	
	if !$ScoreButtons/One.disabled:
		if hasAtLeastThreeOnes(dice):
			$ScoreButtons/One.modulate = Color(0,1,0)
		else:
			$ScoreButtons/One.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Two.disabled:
		if hasAtLeastThreeTwos(dice):
			$ScoreButtons/Two.modulate = Color(0,1,0)
		else:
			$ScoreButtons/Two.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Three.disabled:
		if hasAtLeastThreeThrees(dice):
			$ScoreButtons/Three.modulate = Color(0,1,0)
		else:
			$ScoreButtons/Three.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Four.disabled:
		if hasAtLeastThreeFours(dice):
			$ScoreButtons/Four.modulate = Color(0,1,0)
		else:
			$ScoreButtons/Four.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Five.disabled:
		if hasAtLeastThreeFives(dice):
			$ScoreButtons/Five.modulate = Color(0,1,0)
		else:
			$ScoreButtons/Five.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Six.disabled:
		if hasAtLeastThreeSix(dice):
			$ScoreButtons/Six.modulate = Color(0,1,0)
		else:
			$ScoreButtons/Six.modulate = Color(1,1,1)
	
	if !$ScoreButtons/FourSame.disabled:
		if hasAnyNumberAtLeastFourTimes(dice):
			$ScoreButtons/FourSame.modulate = Color(0,1,0)
		else:
			$ScoreButtons/FourSame.modulate = Color(1,1,1)
	
	if !$ScoreButtons/FiveSame.disabled:
		if hasAnyNumberAtLeastFiveTimes(dice):
			$ScoreButtons/FiveSame.modulate = Color(0,1,0)
		else:
			$ScoreButtons/FiveSame.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Pairs.disabled:
		if hasAnyPair(dice):
			$ScoreButtons/Pairs.modulate = Color(0,1,0)
		else:
			$ScoreButtons/Pairs.modulate = Color(1,1,1)
	
	if !$ScoreButtons/FullHouse.disabled:
		if hasFullHouse(dice):
			$ScoreButtons/FullHouse.modulate = Color(0,1,0)
		else:
			$ScoreButtons/FullHouse.modulate = Color(1,1,1)
	
	if !$ScoreButtons/Chance.disabled:
		$ScoreButtons/Chance.modulate = Color(0,1,0)
	
	var allScoreButtonsActive = true
	var allScoreButtonsInactive = true
	
	for button in $ScoreButtons.get_children():
		if button is TextureButton:
			if button.modulate == Color(0,1,0):
				allScoreButtonsActive = false
				break
	
	for button in $ScoreButtons.get_children():
		if button is TextureButton:
			if !button.disabled:
				allScoreButtonsInactive = false
				break
	
	# Game Over
	if $DealButtons/DealButton1.disabled and $DealButtons/DealButton2.disabled and allScoreButtonsActive:
		$OutOfMovePanel.show()
		$OutOfMovePanel/OutOfMoveSound.play()
	
	# Level passed
	if allScoreButtonsInactive:
		score_total += score
		next_level()

func _on_out_of_move_sound_finished():
	score_total += score
	if score >= score_objective:
		$OutOfMovePanel.hide()
		next_level()
	else:
		game_over()

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

func _on_deal_buttons_deal():
	reroll()

# FONCTIONS POUR VÉRIFIER SI LE JOUEUR PEUT JOUER

# Si tous les nombres sont différents ⚀⚁⚂⚃⚄
func areAllNumbersDifferent(dice):
	var uniqueNumbers = {}

	# Parcourez le tableau et vérifiez si chaque nombre est unique
	for number in dice:
		if number in uniqueNumbers:
			return false  # Si un nombre est en double, renvoyez faux
		else:
			uniqueNumbers[number] = true  # Marquez le nombre comme vu
	
	return true  # Si tous les nombres sont uniques, renvoyez vrai

# Si au moins trois fois Un ⚀⚀⚀
func hasAtLeastThreeOnes(dice):
	var oneCount = 0

	# Parcourez le tableau et comptez combien de fois le nombre 1 apparaît
	for number in dice:
		if number == 1:
			oneCount += 1

	return oneCount >= 3  # Renvoie vrai si le nombre 1 apparaît au moins trois fois

# Si au moins trois fois Deux ⚁⚁⚁
func hasAtLeastThreeTwos(dice):
	var oneCount = 0

	# Parcourez le tableau et comptez combien de fois le nombre 1 apparaît
	for number in dice:
		if number == 2:
			oneCount += 1

	return oneCount >= 3  # Renvoie vrai si le nombre 1 apparaît au moins trois fois

# Si au moins trois fois Trois ⚂⚂⚂
func hasAtLeastThreeThrees(dice):
	var oneCount = 0

	# Parcourez le tableau et comptez combien de fois le nombre 1 apparaît
	for number in dice:
		if number == 3:
			oneCount += 1

	return oneCount >= 3  # Renvoie vrai si le nombre 1 apparaît au moins trois fois

# Si au moins trois fois Quatre ⚃⚃⚃
func hasAtLeastThreeFours(dice):
	var oneCount = 0

	# Parcourez le tableau et comptez combien de fois le nombre 1 apparaît
	for number in dice:
		if number == 4:
			oneCount += 1

	return oneCount >= 3  # Renvoie vrai si le nombre 1 apparaît au moins trois fois

# Si au moins trois fois Cinq ⚄⚄⚄
func hasAtLeastThreeFives(dice):
	var oneCount = 0

	# Parcourez le tableau et comptez combien de fois le nombre 1 apparaît
	for number in dice:
		if number == 5:
			oneCount += 1

	return oneCount >= 3  # Renvoie vrai si le nombre 1 apparaît au moins trois fois

# Si au moins trois fois Six ⚅⚅⚅
func hasAtLeastThreeSix(dice):
	var oneCount = 0

	# Parcourez le tableau et comptez combien de fois le nombre 1 apparaît
	for number in dice:
		if number == 6:
			oneCount += 1

	return oneCount >= 3  # Renvoie vrai si le nombre 1 apparaît au moins trois fois

# Si au moins quatre fois le même nombre ⚃⚃⚃⚃
func hasAnyNumberAtLeastFourTimes(dice):
	var count = {}
	
	# Compter le nombre d'occurrences de chaque nombre dans le tableau
	for number in dice:
		if number not in count:
			count[number] = 1
		else:
			count[number] += 1
	
	# Vérifier s'il y a un nombre au moins quatre fois
	for key in count:
		if count[key] >= 4:
			return true
	
	return false

# Si au moins cinq fois le même nombre ⚄⚄⚄⚄⚄
func hasAnyNumberAtLeastFiveTimes(dice):
	var count = {}
	
	# Compter le nombre d'occurrences de chaque nombre dans le tableau
	for number in dice:
		if number not in count:
			count[number] = 1
		else:
			count[number] += 1
	
	# Vérifier s'il y a un nombre au moins quatre fois
	for key in count:
		if count[key] >= 5:
			return true
	
	return false

# Si au moins une paire ⚁⚁
func hasAnyPair(dice):
	var count = {}
	
	# Compter le nombre d'occurrences de chaque nombre dans le tableau
	for number in dice:
		if number not in count:
			count[number] = 1
		else:
			count[number] += 1
	
	# Vérifier s'il y a un nombre au moins quatre fois
	for key in count:
		if count[key] >= 2:
			return true
	
	return false

# Si 2 + 3 pareills ⚁⚁⚂⚂⚂
func hasFullHouse(dice):
	var count = {}
	
	# Compter le nombre de chaque valeur de dé dans le tableau
	for die_value in dice:
		if die_value not in count:
			count[die_value] = 1
		else:
			count[die_value] += 1
	
	var has_three_of_a_kind = false
	var has_two_of_a_kind = false
	
	for key in count:
		if count[key] == 3:
			has_three_of_a_kind = true
		
		if count[key] == 2:
			has_two_of_a_kind = true
	
	# Retourner vrai si nous avons à la fois trois dés identiques et deux dés identiques
	return has_three_of_a_kind and has_two_of_a_kind

# Additionner tous les nombres
func allOptions(dice):
	return dice[0] + dice[1] + dice[2] + dice[3] + dice[4]

func _on_score_buttons_next_turn(score_add):
	if hasAnyNumberAtLeastFiveTimes(dice):
		score += 50
	elif hasAnyNumberAtLeastFourTimes(dice):
		score += 30
	else:
		match score_add:
			0: # Toutes options
				score += allOptions(dice)
			1: # 1
				score += 3
			2: # 2
				score += 6
			3: # 3
				score += 9
			4: # 4
				score += 12
			5: # 5
				score += 15
			6: # 6
				score += 18
			7: # 4 pareills
				score += 30
			8: # 2+3 pareills et tous différents
				score += 25
	$TaskBar/ScoreContainer/ScoreValueLabel.text = str(score + score_total)
	
	$DealButtons/DealButton1.disabled = false
	$DealButtons/DealButton2.disabled = false
	_ready()

func next_level():
	score = 0
	for button in $ScoreButtons.get_children():
		if button is TextureButton:
			button.modulate = Color(1,1,1)
			button.disabled = false
	
	$DealButtons/DealButton1.disabled = false
	$DealButtons/DealButton2.disabled = false
	_ready()

func game_over():
	Global.last_score = score_total
	if score_total > Global.high_score:
		print("saucisse")
		Global.high_score = score_total
		Global.save_highscore()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
