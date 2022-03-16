extends Node2D

var lance_scene = preload("res://scenes/Lance.tscn")
var lances = []
var num_lances = 2
var nugget_summoner = preload("res://scenes/NuggetSummoner.tscn").instance()

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	
	for _i in range(num_lances):
		lances.append(lance_scene.instance())
	
	for i in range(len(lances)):
		add_child(lances[i])
		var lance_type = Global.LanceType[Global.LanceType.keys()[i]]
		lances[i].setup(lance_type,Vector2(rand_range($lance_spawns.get_children()[i].get_node("topleft").position.x,$lance_spawns.get_children()[i].get_node("botright").position.x),rand_range($lance_spawns.get_children()[i].get_node("topleft").position.y,$lance_spawns.get_children()[i].get_node("botright").position.y)),rand_range(0,2*PI))
		lances[i].connect("lanced",self,"_on_lanced",[Global.Lance_Name[lance_type]])
		lances[i].connect("nug_get",self,"_on_nug_get",[lances[i], Global.Lance_Name[lance_type]])

	add_child(nugget_summoner)
	nugget_summoner.start_summoning()
	
func _on_lanced(lanced_lance):
	print("oh no, "+lanced_lance+" has been lanced!")

func _on_nug_get(lance, lance_name):
	print(lance_name+" nuggets: "+str(lance.nugs_owned))
