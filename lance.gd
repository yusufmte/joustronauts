extends RigidBody2D

export var rotational_speed = 350
export var reverse_speed = 1000
export var forward_speed = 2000
export var coef_of_friction = 5

var control_code = ""

signal lanced

# set up position and color of lance
func setup(color,start_pos):
	position = start_pos
	name = color+"_lance"
	$Sprite.texture = load("res://lance_"+color+"_sketch.png")
	control_code = color[0].to_upper()

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0

# rotate when rotation keys are pressed
func rotate(delta):
	if Input.is_action_pressed("lance"+control_code+"_rot_CCW"):
		angular_velocity = rotational_speed * -1 * delta
	if Input.is_action_pressed("lance"+control_code+"_rot_CW"):
		angular_velocity = rotational_speed * delta

	#if both or neither are pressed, set velocity to 0
	if Input.is_action_pressed("lance"+control_code+"_rot_CW") == Input.is_action_pressed("lance"+control_code+"_rot_CCW"):
		angular_velocity = 0

# thrust when forward/back are pressed
func thrust(delta):
	if Input.is_action_pressed("lance"+control_code+"_reverse"):
			apply_central_impulse(Vector2(0,1).rotated(rotation) * reverse_speed * delta)
	elif Input.is_action_pressed("lance"+control_code+"_forward"):
			apply_central_impulse(Vector2(0,1).rotated(rotation) * -1 * forward_speed * delta)

# decelerate according to current velocity
func apply_friction(delta):
	apply_central_impulse(linear_velocity * -1 * coef_of_friction * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotate(delta)
	thrust(delta)
	apply_friction(delta)

func _on_Core_body_entered(body):
	#if the other lance enters the core, emit lanced signal
	if (name == "orange_lance" and body.name == "purple_lance") or (name == "purple_lance" and body.name == "orange_lance"):
		$Sprite.modulate = $Sprite.modulate * 0.6
		emit_signal("lanced")
