extends Node2D

var lance = preload("res://scenes/Lance.tscn")
var orange_lance = lance.instance()
var purple_lance = lance.instance()
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
	
	add_child(orange_lance)
	orange_lance.setup(Global.LanceType.ORANGE,lance_start_positions[Global.LanceType.ORANGE])
	orange_lance.connect("lanced",self,"_on_Lanced",["orange"])
	
	add_child(purple_lance)
	purple_lance.setup(Global.LanceType.PURPLE,lance_start_positions[Global.LanceType.PURPLE])
	purple_lance.connect("lanced",self,"_on_Lanced",["purple"])
	
	add_child(nugget_summoner)
	nugget_summoner.spawn_range_topleft = Vector2(0,0)
	nugget_summoner.spawn_range_botright = screen_size
	nugget_summoner.start_summoning()
	
func _on_Lanced(lanced_lance):
	print("oh no, "+lanced_lance+" has been lanced!")
