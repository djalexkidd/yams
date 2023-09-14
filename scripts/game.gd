extends Control

var dice = [0, 0, 0, 0, 0]
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
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

func _on_score_buttons_next_turn(score_add):
	score += score_add
	print(score)
	$DealButtons/DealButton1.show()
	$DealButtons/DealButton1.disabled = false
	$DealButtons/DealButton2.show()
	$DealButtons/DealButton2.disabled = false
	_ready()
