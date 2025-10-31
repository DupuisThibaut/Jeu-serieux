extends Button
@export var contenu_page: Node


func _ready():
	set_process_input(true)
	
func _pressed():
	if contenu_page :
		for child in contenu_page.get_children() :
			child.queue_free()
		var resume_label = Label.new()
		if(Global.Statistiques["Santé"]<50):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Vous ne semblez pas très en forme..."
		if(Global.Statistiques["Social"]<30):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Cela fait longtemps que vous n'avez pas vu vos amis..."
		if(Global.Statistiques["Argent"]<50):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Les fins de mois sont difficiles pour les étudiants..."
		if(Global.Statistiques["Note"]<5):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Ce semestre est compliqué, il faut redoubler d'efforts"
		if(Global.Statistiques["Note"]>10):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Je me sens à l'aise ce semestre, j'ai du temps libre."
		else:
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])
		contenu_page.add_child(resume_label)
	else:
		print("ContenuPage non assigné")
