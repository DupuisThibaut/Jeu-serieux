extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

var rot_x = 0
var rot_y = 0
var mouse_sensitivity = 0.002

var testBureau=false
var testPorteSDB=false
var porteSDB=true
var result

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		var space_state = get_world_3d().direct_space_state
		var cam = $Camera3D
		var mousepos = get_viewport().get_mouse_position()
		var origin = cam.project_ray_origin(mousepos)
		var end = origin + cam.project_ray_normal(mousepos) * 0.5
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		result = space_state.intersect_ray(query)
		testBureau=false
		testPorteSDB=false
		if result:
			if(result["collider"].get_children()[0].name=="BureauHaut"):
				testBureau=true
			elif(result["collider"].get_children()[0].name=="NodePorteSDB"):
				print(result["collider"].get_children())
				testPorteSDB=true
			else:
				print("i")
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if testBureau:
				get_tree().change_scene_to_file("res://assets/Scenes/ComputerMenu.tscn")
			if testPorteSDB:
				if porteSDB:
					result["collider"].get_children()[0].rotation[1]=PI/2
					result["collider"].get_children()[1].position=Vector3(0.646,0.4,0.22)
					result["collider"].get_children()[1].rotation[1]=90
					porteSDB=false
					testPorteSDB=false
				else:
					result["collider"].get_children()[0].rotation[1]=0
					result["collider"].get_children()[1].position=Vector3(0.805,0.4,0.38)
					result["collider"].get_children()[1].rotation[1]=0
					porteSDB=true
					testPorteSDB=false
					
				

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
