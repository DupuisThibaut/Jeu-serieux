extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	print(Global.ChoixES, Global.choixMatin, Global.choixAprem, Global.choixSoir)
	if(Global.ChoixES != {} and Global.choixMatin != -1 and Global.choixAprem != -1 and Global.choixSoir !=-1) :
		_newDay()
		await get_tree().create_timer(0.8).timeout
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Global.viseur.visible=true
		get_tree().get_root().get_node("/root/Scene/HBoxContainer/Label_Day").change()
		get_tree().get_root().get_node("/root/Scene/HBoxContainer/Label_Money").change()
		Global.Statistiques["Santé"] = min(100,Global.Statistiques["Santé"])
		SceneTransition.change_scene("res://assets/Scenes/MainScene.tscn",1)


func _newDay():
	var tab = ["Note","Social","Santé"]
	if(Global.choixMatin not in [4,5]) :
		Global.Statistiques[tab[Global.choixMatin]] +=1
	if(Global.choixAprem not in [4,5]) :
		Global.Statistiques[tab[Global.choixAprem]] +=1
	if(Global.choixSoir not in [4,5]) :
		Global.Statistiques[tab[Global.choixSoir]] +=1
	Global.numDay = Global.numDay + 1
	Global.choixMatin = -1
	Global.choixAprem = -1
	Global.choixSoir = -1
	if Global.ChoixES != {}:
		if(Global.ChoixES["Conséquences"].has("Santé")):
			Global.Statistiques["Santé"] += Global.ChoixES["Conséquences"]["Santé"]
		if(Global.ChoixES["Conséquences"].has("Social")):
			Global.Statistiques["Social"] += Global.ChoixES["Conséquences"]["Social"]
		if(Global.ChoixES["Conséquences"].has("Note")):
			Global.Statistiques["Note"] += Global.ChoixES["Conséquences"]["Note"]
		if(Global.ChoixES["Conséquences"].has("Argent")) :
			Global.Statistiques["Argent"] += Global.ChoixES["Conséquences"]["Argent"]
	Global.numDayWeek = (Global.numDayWeek + 1)%5
	if(Global.numDayWeek == 0):
		randomize()	
		Global.ESinWeek.shuffle()
	
