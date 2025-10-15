extends MarginContainer


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	randomize()	
	Global.ESinWeek.shuffle()
