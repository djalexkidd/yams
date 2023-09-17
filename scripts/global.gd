extends Node

var high_score = 0
var last_score = 0
var player_name = "Saucisse"

# Called when the node enters the scene tree for the first time.
func _ready():
	load_highscore()

func save():
	var save_dict = {
		"high_score" : high_score,
		"name" : player_name,
	}
	return save_dict

func load_highscore():
	if not FileAccess.file_exists("user://highscore.sav"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open("user://highscore.sav", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		high_score = node_data.high_score

func save_highscore():
	var save_game = FileAccess.open("user://highscore.sav", FileAccess.WRITE)

	# Call the node's save function.
	var node_data = call("save")

	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(node_data)

	# Store the save dictionary as a new line in the save file.
	save_game.store_line(json_string)
