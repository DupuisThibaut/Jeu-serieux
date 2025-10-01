extends Area3D

func _ready():
	self.input_event.connect(_on_input_event)

func _on_input_event(camera, event, click_position, click_normal, shape_idx):
	print("heelo")
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().change_scene_to_file("res://assets/Scenes/ComputerMenu.tscn")
