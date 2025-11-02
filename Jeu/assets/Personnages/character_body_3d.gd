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
var testDouche=false
var porteSDB=true
var result
var travail=false
var testManger=false

#signal changementScene(cell)

#Global.connect("changementScene",_on_changement_scene)

func _ready():
	Global.changementScene.connect(_scene_changed)
	Global.viseur=get_node("Viseur")
	Global.interaction=get_node("Interaction")
	Global.interaction.visible=false
	Global.quitter=get_node("Quitter")
	Global.quitter.visible=true
	Global.cameraPerso=$Camera3D
	print("oooooooooooooooo")
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#var viseur=get_node("Viseur")
	#viseur.visible=true
	#print(viseur)
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
		testDouche=false
		testManger=false
		Global.interaction.visible=false
		if result:
			if(result["collider"].get_children()[0].name=="BureauHaut" || result["collider"].get_parent().get_parent().name=="Ordinateur"):
				testBureau=true
				Global.interaction.visible=true
			if(result["collider"].get_children()[0].name=="NodePorteSDB"):
				testPorteSDB=true
				Global.interaction.visible=true
			if(!Global.mangeAjd):
				if(result["collider"].get_name()=="Salade" && result["collider"].visible):
					testManger=true
					Global.interaction.visible=true
				elif(result["collider"].get_name()=="Viande" && result["collider"].visible):
					testManger=true
					Global.interaction.visible=true
				elif(result["collider"].get_name()=="Steak" && result["collider"].visible):
					testManger=true
					Global.interaction.visible=true
				elif(result["collider"].get_name()=="Tomate" && result["collider"].visible):
					testManger=true
					Global.interaction.visible=true
				elif(result["collider"].get_name()=="Patate" && result["collider"].visible):
					testManger=true
					Global.interaction.visible=true
			if(!Global.doucheAjd):
				if result["collider"].get_parent().name=="Douche":
					testDouche=true
					Global.interaction.visible=true
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if testBureau:
				#changementScene.emit("res://assets/Scenes/ComputerMenu.tscn")
				#Global.emit_signal("changementScene")
				Global.viseur.visible=false
				Global.interaction.visible=false
				#get_tree().change_scene_to_file("res://assets/Scenes/ComputerMenu.tscn")
				#get_parent().get_node("CameraOrdi").make_current()
				SceneTransition.change_camera(get_parent().get_node("CameraOrdi"),1)
				#CameraTransition.transition_camera3D(get_tree().get_root().get_node("/root/Scene/CharacterBody3D/Camera3D"),get_parent().get_node("CameraOrdi"))
				await get_tree().create_timer(0.5).timeout
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				Global.viseur.visible=false
				Global.interaction.visible=false
				testBureau=false
				travail=true
				Global.quitter.visible=true
			if testPorteSDB:
				Global.interaction.visible=false
				if porteSDB:
					$Sons/PorteOuverte.play()
					result["collider"].get_children()[0].rotation[1]=PI/2
					result["collider"].get_children()[1].position=Vector3(0.646,0.4,0.22)
					result["collider"].get_children()[1].rotation[1]=90
					porteSDB=false
					testPorteSDB=false
				else:
					$Sons/PorteFerme.play()
					result["collider"].get_children()[0].rotation[1]=0
					result["collider"].get_children()[1].position=Vector3(0.805,0.4,0.38)
					result["collider"].get_children()[1].rotation[1]=0
					porteSDB=true
					testPorteSDB=false
			if testManger:
				if !Global.mangeAjd:
					$Sons/Manger.play()
					result["collider"].visible=false
					Global.mangeAjd=true
					Global.interaction.visible=false
					Global.changerStat("Santé",3)
					if result["collider"].name=="Patate":
						Global.patate=false
					if result["collider"].name=="Steak":
						Global.steak=false
					if result["collider"].name=="Viande":
						Global.viande=false
					if result["collider"].name=="Tomate":
						Global.tomate=false
					if result["collider"].name=="Salade":
						Global.salade=false
			if testDouche:
				if !Global.doucheAjd:
					SceneTransition.douche()
					Global.doucheAjd=true
					Global.interaction.visible=false
					Global.changerStat("Santé",2)
	if event is InputEventKey:
		if event.pressed and event.keycode==KEY_ESCAPE:
			if travail:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				Global.viseur.visible=true
				travail = false
				SceneTransition.change_camera(get_tree().get_root().get_node("/root/Scene/CharacterBody3D/Camera3D"),1)
			else :
				get_tree().quit()

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
	
func _scene_changed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var viseur=get_node("Viseur")
	viseur.visible=false
	#if(get_tree().currentScene=="res://assets/Scenes/ComputerMenu.tscn"):
		#print("i")


#func _on_changement_scene(cell: Variant) -> void:
	#print("i")
	#pass # Replace with function body.
