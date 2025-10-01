extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://assets/Scenes/MainScene.tscn")
