extends Node2D

func _ready():
	$AnimatedSprite.play("spin", randi()%2==1) # 1/2 chance to be spinning backwards
