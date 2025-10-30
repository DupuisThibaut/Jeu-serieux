extends Button
@export var contenu_page: Node


func _ready():
	set_process_input(true)
	
func _pressed():
	if contenu_page :
		for child in contenu_page.get_children() :
			child.queue_free()
		var resume_label = Label.new()
		resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+" (-3€) \n\n Vous ne semblez pas très en forme et votre frigo est vide..."
		contenu_page.add_child(resume_label)
	else:
		print("ContenuPage non assigné")
