extends Node

var nugget = preload("res://scenes/Nugget.tscn")
export var nuggets = []
export var spawn_range_topleft = Vector2(100,100)
export var spawn_range_botright = Vector2(400,300)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func summon_nugget():
	nuggets.append(nugget.instance())
	add_child(nuggets[-1])
	nuggets[-1].position = Vector2(rand_range(spawn_range_topleft.x,spawn_range_botright.x),rand_range(spawn_range_topleft.y,spawn_range_botright.y))
