extends Node

var nugget = preload("res://scenes/Nugget.tscn")
export var nuggets = []
export var spawn_range_topleft = Vector2(100,100)
export var spawn_range_botright = Vector2(400,300)

export var nug_spawn_rate = 3.0 setget set_nug_spawn_rate
export var nug_spawn_rate_uncertainty = 2.0 setget set_nug_spawn_rate_uncertainty
var nug_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(nug_timer)
	nug_timer.connect("timeout",self,"_on_nug_timer_timeout")
	reset_nug_timer_wait_time()
	
func reset_nug_timer_wait_time():
	nug_timer.wait_time = rand_range(nug_spawn_rate - nug_spawn_rate_uncertainty, nug_spawn_rate + nug_spawn_rate_uncertainty)

func set_nug_spawn_rate(new_value):
	nug_spawn_rate = new_value
	reset_nug_timer_wait_time()

func set_nug_spawn_rate_uncertainty(new_value):
	nug_spawn_rate_uncertainty = new_value
	reset_nug_timer_wait_time()

func start_summoning():
	nug_timer.start()

func stop_summoning():
	nug_timer.stop()

func _on_nug_timer_timeout():
	summon_nugget()
	reset_nug_timer_wait_time()

func summon_nugget():
	nuggets.append(nugget.instance())
	add_child(nuggets[-1])
	nuggets[-1].position = Vector2(rand_range(spawn_range_topleft.x,spawn_range_botright.x),rand_range(spawn_range_topleft.y,spawn_range_botright.y))

