extends TextureRect

func _ready():
	set_process_input(true)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().change_scene_to_file("res://assets/Scenes/MainScene.tscn")
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			Global.viseur.visible=true
