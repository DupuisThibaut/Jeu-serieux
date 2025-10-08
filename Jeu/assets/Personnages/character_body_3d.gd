extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

var rot_x = 0
var rot_y = 0
var mouse_sensitivity = 0.002

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		$RayCast3D.rotate_x(event.relative.y * mouse_sensitivity)
		$RayCast3D.rotation.x = clampf($RayCast3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		var obj=$RayCast3D.get_collider()
		if obj:
			print(obj)
			#obj.get_node("Sol").mesh.material.albedo_color=Color(125.371, 39.3, 188.354, 1.0)
			#print(obj.get_node("Sol").mesh.material.albedo_color)

func _physics_process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	target_velocity.x = movement_dir.x * speed
	target_velocity.z = movement_dir.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
