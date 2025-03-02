extends Node

var wave_data = [
	# wave 1
	[		# i
		["enemy_base",2,0.5],	
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
