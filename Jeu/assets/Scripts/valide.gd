extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	if(Global.ChoixES != {} and Global.choixMatin != -1 and Global.choixAprem != -1 and Global.choixSoir !=-1) :
		Global.animValide.stop()
		_newDay()
		await get_tree().create_timer(0.8).timeout
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Global.viseur.visible=true
		Global.mangeAjd=false
		Global.doucheAjd=false
		get_tree().get_root().get_node("/root/Scene/HUD/HBoxContainer/Label_Day").change()
		get_tree().get_root().get_node("/root/Scene/HUD/HBoxContainer/Label_Money").change()
		get_tree().get_root().get_node("/root/Scene/HUD/Social/ProgressBar_Social").change()
		get_tree().get_root().get_node("/root/Scene/HUD/Santé/ProgressBar_Santé").change()
		Global.Statistiques["Santé"] = min(100,Global.Statistiques["Santé"])
		Global.Statistiques["Social"] = min(100,Global.Statistiques["Social"])
		Global.Statistiques["Note"] = min(20, Global.Statistiques["Note"])
		if Global.numDay >= 15 :
			SceneTransition.change_scene("res://assets/Scenes/End.tscn",1)
		else :
			SceneTransition.change_scene("res://assets/Scenes/MainScene.tscn",2)
		Global.ChoixES = {"Créneau": [],"Conséquences":{}}

func assign_event_type(type:int):
	var candidats = []	
	for i in range(Global.ES.size()):
		if Global.ES[i]["type"] == type:
			candidats.append(i)	
	if candidats.size() > 0:
		randomize()
		var id = candidats[randi() % candidats.size()]
		Global.ESinWeek[Global.numDayWeek] = id
		print("→ Semaine ", Global.numDayWeek, " : événement choisi = ", Global.ES[id]["name"])
	else:
		print("Aucun événement de type 1 trouvé !")

func _newDay():
	var tab = ["Note","Social","Santé"]
	var Sante_multiplier = (2.0 - Global.Statistiques["Social"]/100.0)
	var Note_multiplier = Global.Statistiques["Santé"]/100.0
	var tab2 = [0.1*Note_multiplier,5,5.0]
	#Global.Statistiques["Santé"] -= 10 * Sante_multiplier
	print("La santé : " + str(-10.0*Sante_multiplier))
	Global.changerStat("Santé",-10.0*Sante_multiplier)
	if(Global.choixMatin not in [4,5]) :
		Global.Statistiques[tab[Global.choixMatin]] +=tab2[Global.choixMatin]
	if(Global.choixAprem not in [4,5]) :
		Global.Statistiques[tab[Global.choixAprem]] +=tab2[Global.choixAprem]
	if(Global.choixSoir not in [4,5]) :
		Global.Statistiques[tab[Global.choixSoir]] +=tab2[Global.choixSoir]
	Global.numDay = Global.numDay + 1
	Global.choixMatin = -1
	Global.choixAprem = -1
	Global.choixSoir = -1
	if Global.ChoixES != {}:
		print(Global.ChoixES)
		if(Global.ChoixES.has("name")):
			if(Global.ChoixES.get("name")=="Courses"):
				Global.patate=true
				Global.salade=true
				Global.steak=true
				Global.viande=true
				Global.tomate=true
		if(Global.ChoixES["Conséquences"].has("Santé")):
			#Global.Statistiques["Santé"] += Global.ChoixES["Conséquences"]["Santé"]
			Global.changerStat("Santé",Global.ChoixES["Conséquences"]["Santé"])
		if(Global.ChoixES["Conséquences"].has("Social")):
			#Global.Statistiques["Social"] += Global.ChoixES["Conséquences"]["Social"]
			Global.changerStat("Social",Global.ChoixES["Conséquences"]["Social"])
		if(Global.ChoixES["Conséquences"].has("Note")):
			#Global.Statistiques["Note"] += Global.ChoixES["Conséquences"]["Note"]
			Global.changerStat("Note",Global.ChoixES["Conséquences"]["Note"]*Note_multiplier)
		if(Global.ChoixES["Conséquences"].has("Argent")) :
			Global.Statistiques["Argent"] += Global.ChoixES["Conséquences"]["Argent"]
	Global.numDayWeek = (Global.numDayWeek + 1)%5
	if(Global.numDayWeek == 0):
		Global.generate_ES_week()
	if(Global.patate==false and Global.viande == false and Global.steak==false and Global.tomate==false and Global.salade==false):
		assign_event_type(2)
	elif(Global.Statistiques["Argent"]<20):
		assign_event_type(3)

		
	
