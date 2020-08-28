extends Node

var score = 0
var coins = 0
var rand = 0
var Dataname = 'user://apples-game-data.json'
var default = {'Sprites' : ['GoldApple',
							'PoisApple',
							'NormApple',
							'Bomb',
							'Increaser'],
			'Probablities' : [5,23,65,2,5]}

var data = {
	'High Score' : 0,
	'Coins' : 0,
	'music' : true,
	'Sprites' : ['GoldApple','PoisApple','NormApple', 'Bomb','Increaser'],
	'Probablities' : [5,23,65,2,5]
}

func save():
	var file = File.new()
	file.open(Dataname, File.WRITE)
	file.store_string(to_json(data))
	file.close()

func load():
	var file = File.new()
	if file.file_exists(Dataname):
		file.open(Dataname, File.READ)
		var tempdata = parse_json(file.get_as_text())
		file.close()
		data = tempdata
		coins = data['Coins']
	
