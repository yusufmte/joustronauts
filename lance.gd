extends Area2D

export var acceleration = 400
export var max_speed = 1000
export var reverse_speed = 150
export var deceleration = 800
export var rot_speed = 120

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("lanceP_forward") and velocity.y < max_speed:
		velocity.y += acceleration * delta
	if Input.is_action_pressed("lanceP_reverse"):
		velocity.y -= acceleration * delta
		
	
	if velocity != Vector2.ZERO:
		position.y -= velocity.y * delta
		position.x += velocity.x * delta
