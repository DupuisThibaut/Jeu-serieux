extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	randomize()	
	Global.ESinWeek.shuffle()
	Global.viseur.visible=false
	Global.interaction.visible=false
		
func _scene_changed():
	print("i")
