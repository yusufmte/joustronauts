extends RigidBody2D

export var acceleration = 2000
export var max_speed = 4000
export var reverse_acceleration = 150
export var reverse_max_speed = -225
export var coef_of_friction = 5
export var rotational_speed = 50
export var max_rotational_speed = 7

export var lance_type = ""
var control_code = ""
var orange_sketch = preload("res://lance_orange_sketch.png")
var purple_sketch = preload("res://lance_purple_sketch.png")

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
	gravity_scale = 0
	set_lance_type("orange")

# thrust when forward/back are pressed and below max speeds
func thrust(delta):
	var directional_speed = (linear_velocity.x*cos(rotation-PI/2)) + (linear_velocity.y*sin(rotation-PI/2)) #speed in the direction of the rotation of the lance
	if Input.is_action_pressed("lance"+control_code+"_reverse") and directional_speed > reverse_max_speed:
			apply_central_impulse(Vector2(0,1).rotated(rotation) * acceleration * delta)
	elif Input.is_action_pressed("lance"+control_code+"_forward") and directional_speed < max_speed:
			apply_central_impulse(Vector2(0,1).rotated(rotation) * -1 * acceleration * delta)

# decelerate according to current velocity
func apply_friction(delta):
	apply_central_impulse(linear_velocity * -1 * coef_of_friction * delta)

# rotate when rotation keys are pressed
func rotate(delta):
	if Input.is_action_pressed("lance"+control_code+"_rot_CCW") and angular_velocity > max_rotational_speed * -1:
		angular_velocity -= rotational_speed * delta
	if Input.is_action_pressed("lance"+control_code+"_rot_CW") and angular_velocity < max_rotational_speed:
		angular_velocity += rotational_speed * delta
	if not Input.is_action_pressed("lance"+control_code+"_rot_CW") and not Input.is_action_pressed("lance"+control_code+"_rot_CCW"):
		angular_velocity = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	thrust(delta)
	apply_friction(delta)
	rotate(delta)
