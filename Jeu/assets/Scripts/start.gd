extends Button

func _ready():
	set_process_input(true)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			#get_tree().change_scene_to_file("res://assets/Scenes/MainScene.tscn")
			#print("i")
			#SceneTransition.change_scene("res://assets/Scenes/MainScene.tscn",1)
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			SceneTransition.new()
			await get_tree().create_timer(0.6).timeout
			Global.viseur.visible=true
			Global.cam()
			print("test")
			print(Global.cameraPerso)
			Global.cameraPerso.make_current()
			print(get_viewport().get_camera_3d())
			print("test")
			#CameraTransition.camera3D.current=false
			#Global.cameraPerso.make_current()
