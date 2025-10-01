extends Button


func _ready():
	set_process_input(true)
	
func _pressed():
	for child in get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").get_children() :
			child.free()
	var resume_label = Label.new()
	resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Math : 5/20 (+1) \n Info : 6/20 (+0.5)\n\n Argent : 255€ (-3€) \n\n Vous ne semblez pas très en forme et votre frigo est vide..."
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(resume_label)
