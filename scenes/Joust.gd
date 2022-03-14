extends Node2D

var lance_scene = preload("res://scenes/Lance.tscn")
var lances = []
var num_lances = 2
var nugget_summoner = preload("res://scenes/NuggetSummoner.tscn").instance()

var lance_start_positions = {
	Global.LanceType.ORANGE : Vector2(200,200),
	Global.LanceType.PURPLE : Vector2(800,500)
}

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	
	for _i in range(num_lances):
		lances.append(lance_scene.instance())
	
	for lance in lances:
		add_child(lance)
		var lance_type = Global.LanceType[Global.LanceType.keys()[lances.find(lance)]]
		lance.setup(lance_type,lance_start_positions[lance_type])
		lance.connect("lanced",self,"_on_Lanced",[Global.Lance_Name[lance_type]])

	add_child(nugget_summoner)
	nugget_summoner.spawn_range_topleft = Vector2(0,0)
	nugget_summoner.spawn_range_botright = screen_size
	nugget_summoner.start_summoning()
	
func _on_Lanced(lanced_lance):
	print("oh no, "+lanced_lance+" has been lanced!")
