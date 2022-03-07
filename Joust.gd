extends Node2D

var lance = preload("res://lance.tscn")
var orange_lance = lance.instance()
var purple_lance = lance.instance()
var orange_lance_start_pos = Vector2(200,200)
var purple_lance_start_pos = Vector2(800,500)

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	add_child(orange_lance)
	orange_lance.setup("orange",orange_lance_start_pos)
	orange_lance.connect("lanced",self,"_on_Lanced",["orange"])
	
	add_child(purple_lance)
	purple_lance.setup("purple",purple_lance_start_pos)
	purple_lance.connect("lanced",self,"_on_Lanced",["purple"])
	
func _on_Lanced(lanced_lance):
	print("oh no, "+lanced_lance+" has been lanced!")
