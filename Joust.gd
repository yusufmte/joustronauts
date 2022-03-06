extends Node2D

var lance = preload("res://lance.tscn")
var orange_lance = lance.instance()
var purple_lance = lance.instance()
var orange_lance_start_pos = Vector2(200,200)
var purple_lance_start_pos = Vector2(800,500)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(orange_lance)
	orange_lance.set_lance_type("orange")
	orange_lance.set_position(orange_lance_start_pos)
	orange_lance.name = "orange_lance"
	add_child(purple_lance)
	purple_lance.set_position(purple_lance_start_pos)
	purple_lance.set_lance_type("purple")
	purple_lance.name = "purple_lance"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
