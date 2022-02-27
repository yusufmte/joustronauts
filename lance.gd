extends KinematicBody2D

export var acceleration = 400
export var max_speed = 300
export var reverse_acceleration = 200
export var reverse_max_speed = -150
export var coef_of_friction = 100
export var rotational_speed = 6.28

export var lance_type = ""
var control_code = ""
var orange_sketch = preload("res://lance_orange_sketch.png")
var purple_sketch = preload("res://lance_purple_sketch.png")

var velocity = Vector2.ZERO

func set_lance_type(new_type):
	lance_type = new_type
	if lance_type == "purple":
		$Sprite.texture = purple_sketch
		control_code = "P"
	elif lance_type == "orange":
		$Sprite.texture = orange_sketch
		control_code = "O"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lance_type("orange")

# thrust when forward/back are pressed and below max speeds
func thrust(delta):
	var directional_speed = (velocity.x*cos(rotation-PI/2)) + (velocity.y*sin(rotation-PI/2)) #speed in the direction of the rotation of the lance
	if Input.is_action_pressed("lance"+control_code+"_reverse") and directional_speed > reverse_max_speed:
			velocity += Vector2(0,1).rotated(rotation) * acceleration * delta
	elif Input.is_action_pressed("lance"+control_code+"_forward") and directional_speed < max_speed:
			velocity -= Vector2(0,1).rotated(rotation) * acceleration * delta


# decelerate gradually until stopped
func apply_friction(delta):
	if velocity.length() > (velocity.normalized() * coef_of_friction * delta).length():
		velocity -= velocity.normalized() * coef_of_friction * delta
	else:
		velocity = Vector2.ZERO

# rotate when rotation keys are pressed
func rotate(delta):
	if Input.is_action_pressed("lance"+control_code+"_rot_CCW"):
		rotation -= rotational_speed * delta
	if Input.is_action_pressed("lance"+control_code+"_rot_CW"):
		rotation += rotational_speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	thrust(delta)
	apply_friction(delta)
	rotate(delta)
	move_and_slide(velocity)
