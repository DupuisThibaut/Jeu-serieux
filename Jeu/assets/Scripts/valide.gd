extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	_newDay()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://assets/Scenes/MainScene.tscn")


func _newDay():
	var tab = ["Note","Social","Santé"]
	Global.Statistiques[tab[Global.choixMatin]] +=1
	Global.Statistiques[tab[Global.choixAprem]] +=1
	Global.Statistiques[tab[Global.choixSoir]] +=1
	Global.numDay = Global.numDay + 1
	Global.choixMatin = 0
	Global.choixAprem = 0
	Global.choixSoir = 0
	if Global.ChoixES :
		Global.Statistiques["Santé"] += 30
		Global.Statistiques["Argent"] -= 45
	else :
		Global.Statistiques["Santé"] -= 15
	
