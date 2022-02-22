extends KinematicBody2D

export var acceleration = 400
export var max_speed = 300
export var reverse_acceleration = 200
export var reverse_max_speed = -150
export var coef_of_friction = 100
export var rotational_speed = 6.28

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# thrust when forward/back are pressed and below max speeds
func thrust(delta):
	var directional_speed = (velocity.x*cos(rotation-PI/2)) + (velocity.y*sin(rotation-PI/2)) #speed in the direction of the rotation of the lance
	if Input.is_action_pressed("lanceP_reverse") and directional_speed > reverse_max_speed:
			velocity += Vector2(0,1).rotated(rotation) * acceleration * delta
	elif Input.is_action_pressed("lanceP_forward") and directional_speed < max_speed:
			velocity -= Vector2(0,1).rotated(rotation) * acceleration * delta


# decelerate gradually until stopped
func apply_friction(delta):
	if velocity.length() > (velocity.normalized() * coef_of_friction * delta).length():
		velocity -= velocity.normalized() * coef_of_friction * delta
	else:
		velocity = Vector2.ZERO

# rotate when rotation keys are pressed
func rotate(delta):
	if Input.is_action_pressed("lanceP_rot_CCW"):
		rotation -= rotational_speed * delta
	if Input.is_action_pressed("lanceP_rot_CW"):
		rotation += rotational_speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	thrust(delta)
	apply_friction(delta)
	rotate(delta)
	move_and_slide(velocity)
