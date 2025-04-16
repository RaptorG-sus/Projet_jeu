extends Node

var wave_data = [
	# wave 1
	[		# i
		["enemy_test",2,0.5],	
		["enemy_test", 4, 0.2]	
		],
	# wave 2
	[
		["enemy_base", 8, 0.7],
		["enemy_test", 10, 0.1]
	],
	# wave 3
	[
		["enemy_base", 20, 0.01]
	]
]


var enemy_data = {
	"enemy_test":{
		"life" : 100,
		"speed" : 2,
		"damage" : 2
		},
	
	"enemy_base":{
		"life" : 50,
		"speed" : 4,
		"damage" : 1
		}
}


var camera_data = {
	"map_test" : [0, 0.25, 0.5, 0.75]
}

var turret_data = {
	#nom de la tours
	"turret_test" : {
		# état initial dès qu'on la pose
		"base" : {
			#toute ces stats initial
			"range" = 5,
			"damage" = 10,
			"attack_speed" = 0.5,
			"bullet_speed" = 30,
			"pierce" = 1
		},
		#type d'amélioration
		"amelioration_magique" : {
			#tier de l'amélioration (1 - 5)
			"tier 1":{
				#stat rajouté à l'état initial
				"range" = 2,
				"damage" = 5,
			}
		}
	}
}

var card_data = ["archer_card","test_card"]