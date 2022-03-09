extends RigidBody2D

export var lance_type : int

var lance_textures = {
	Global.LanceType.PURPLE : preload("res://lance_purple_sketch.png"),
	Global.LanceType.ORANGE : preload("res://lance_orange_sketch.png")
}

var lance_control_codes = {
	Global.LanceType.PURPLE : "P",
	Global.LanceType.ORANGE : "O"
}

var control_code = ""

export var rotational_speed = 350.0
export var reverse_max_speed = 250.0 setget set_reverse_max_speed
export var forward_max_speed = 500.0 setget set_forward_max_speed
export var coef_of_friction = 5.0 setget set_coef_of_friction

var reverse_thrust : float
var forward_thrust : float

signal lanced

# recalculates reverse thrust as well
func set_reverse_max_speed(new_value):
	reverse_max_speed = new_value
	reverse_thrust = (reverse_max_speed * coef_of_friction) / mass

# recalculates forward thrust as well
func set_forward_max_speed(new_value):
	forward_max_speed = new_value
	forward_thrust = (forward_max_speed * coef_of_friction) / mass

# calls other setters to recalculate reverse & forward thrust as well
func set_coef_of_friction(new_value):
	coef_of_friction = new_value
	set_reverse_max_speed(reverse_max_speed)
	set_forward_max_speed(forward_max_speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0
	set_reverse_max_speed(reverse_max_speed)
	set_forward_max_speed(forward_max_speed)

# set up position and color of lance
func setup(new_lance_type,start_pos):
	position = start_pos
	lance_type = new_lance_type
	$Sprite.texture = lance_textures[lance_type]
	control_code = lance_control_codes[lance_type]

# rotate when rotation keys are pressed
func rotate(delta):
	if Input.is_action_pressed("lance"+control_code+"_rot_CCW"):
		angular_velocity = rotational_speed * -1 * delta
	if Input.is_action_pressed("lance"+control_code+"_rot_CW"):
		angular_velocity = rotational_speed * delta

	#if both or neither are pressed, set angular velocity to 0
	if Input.is_action_pressed("lance"+control_code+"_rot_CW") == Input.is_action_pressed("lance"+control_code+"_rot_CCW"):
		angular_velocity = 0

# thrust when forward/back are pressed
func thrust(delta):
	if Input.is_action_pressed("lance"+control_code+"_reverse"):
			apply_central_impulse(Vector2(0,1).rotated(rotation) * reverse_thrust * delta)
	elif Input.is_action_pressed("lance"+control_code+"_forward"):
			apply_central_impulse(Vector2(0,1).rotated(rotation) * -1 * forward_thrust * delta)

# decelerate according to current velocity
func apply_friction(delta):
	apply_central_impulse(linear_velocity * -1 * coef_of_friction * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotate(delta)
	thrust(delta)
	apply_friction(delta)

func _on_Core_body_entered(body):
	#if the body that enters the core is a lance of a different type, emit "lanced" signal
	if body is get_script() and body.lance_type != lance_type:
		$Sprite.modulate = $Sprite.modulate * 0.6
		emit_signal("lanced")
