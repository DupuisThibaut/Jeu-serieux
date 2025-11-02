extends TabBar
@export var contenu_page: Node
var creneaux = {
	"Créneau du matin": Global.ActionsJournée,
	"Créneau de l'après-midi": Global.ActionsJournée,
	"Créneau du soir": Global.ActionsSoir
}
func _ready():
	connect("tab_changed", Callable(self, "_on_tab_changed"))
	_on_tab_changed(get_current_tab())

func _on_tab_changed(tab_index):
	match tab_index:
		0:
			afficher_resume()
		1:
			afficher_evenements()
		2:
			afficher_planning()

func afficher_resume():
	if contenu_page :
		for child in contenu_page.get_children() :
			child.queue_free()
		var resume_label = Label.new()
		resume_label.horizontal_alignment=1
		resume_label.vertical_alignment=1
		print("numday : "+str(Global.numDay))
		if(Global.numDay==1):
			resume_label.text = "Bienvenue !\n\nDans ce jeu, vous incarnerez un étudiant de la faculté des sciences de Montpellier.\nVotre but sera de réussir vos examens en suivant vos cours durant trois semaines !\nVous aurez à gérer en même temps votre santé et votre vie sociale tout en faisant attention à votre argent !\nEt c'est ici grâce à cet ordinateur que vous allez organiser vos journées, appuyer sur start quand vous aurez fini !\nBonne chance dans cette aventure !"
		elif(Global.Statistiques["Santé"]<50):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Vous ne semblez pas très en forme..."
		elif(Global.Statistiques["Social"]<30):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Cela fait longtemps que vous n'avez pas vu vos amis..."
		elif(Global.Statistiques["Argent"]<50):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Les fins de mois sont difficiles pour les étudiants..."
		elif(Global.Statistiques["Note"]<5):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Ce semestre est compliqué, il faut redoubler d'efforts"
		elif(Global.Statistiques["Note"]>10):
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Je me sens à l'aise ce semestre, j'ai du temps libre."
		else:
			resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])
		resume_label.add_theme_color_override("font_color", Color.BLACK)
		contenu_page.add_child(resume_label)
	else:
		print("ContenuPage non assigné")

func build_consequences_text(cons_dict: Dictionary) -> String:
	var text = " ("
	for key in cons_dict.keys():
		var value = cons_dict[key]
		if value > 0:
			text += " +" + str(value) + " " + key
		elif value < 0:
			text += " " + str(value) + " " + key
	text += ")"
	return text

func afficher_evenements():
	if contenu_page :
		print(Global.ESinWeek)
		var es = Global.ES[Global.ESinWeek[Global.numDayWeek]]
		print(es)
		print("yeepi")
		for child in contenu_page.get_children():
				child.queue_free()	
		var vbox = VBoxContainer.new()
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.add_theme_constant_override("separation",10)
		contenu_page.add_child(vbox)
		var resume_label = Label.new()
		resume_label.text = es["Description"]
		resume_label.add_theme_font_size_override("font_size", 18)
		resume_label.add_theme_color_override("font_color", Color.BLACK)
		vbox.add_child(resume_label)
		var hbox = HBoxContainer.new()
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_theme_constant_override("separation",10)
		var btnOui = Button.new()
		btnOui.add_theme_color_override("font_color", Color.WHITE)
		btnOui.add_theme_color_override("font_color_hover", Color.BLACK) 
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.2, 0.4, 1)
		style.corner_radius_top_left = 1
		style.corner_radius_top_right = 1
		style.corner_radius_bottom_left = 1
		style.corner_radius_bottom_right = 1
		style.border_color = Color(0,0,0)
		style.content_margin_left = 12
		style.content_margin_top = 6
		style.content_margin_right = 12
		style.content_margin_bottom = 6
		btnOui.add_theme_stylebox_override("normal", style)
		var style_hover = style.duplicate()
		style_hover.bg_color = Color(0.3, 0.5, 1)
		btnOui.add_theme_stylebox_override("hover", style_hover)
		btnOui.text = es["Oui"]["Description"]
		  #+ " " + build_consequences_text(es["Oui"]["Conséquences"])
		btnOui.pressed.connect(func():
			Global.ChoixES = es["Oui"]
			if("Créneau du matin" in Global.ChoixES["Créneau"]):
				Global.choixMatin = 4
			else : Global.choixMatin = -1
			if("Créneau de l'après-midi" in Global.ChoixES["Créneau"]):
				Global.choixAprem = 4
			else : Global.choixAprem = -1
			if("Créneau du soir" in Global.ChoixES["Créneau"]):
				Global.choixSoir = 4	
			else : Global.choixSoir = -1		
		)
		hbox.add_child(btnOui)
		var btnNon = Button.new()
		btnNon.text = es["Non"]["Description"]  
		#+ " " + build_consequences_text(es["Non"]["Conséquences"])
		btnNon.add_theme_color_override("font_color", Color.WHITE)
		btnNon.add_theme_color_override("font_color_hover", Color.BLACK) 
		btnNon.add_theme_stylebox_override("normal", style)
		btnNon.add_theme_stylebox_override("hover", style_hover)
		btnNon.pressed.connect(func():
			Global.ChoixES = es["Non"]
			if("Créneau du matin" in Global.ChoixES["Créneau"]):
				Global.choixMatin = 5
			else : Global.choixMatin = -1
			if("Créneau de l'après-midi" in Global.ChoixES["Créneau"]):
				Global.choixAprem = 5
			else : Global.choixAprem = -1
			if("Créneau du soir" in Global.ChoixES["Créneau"]):
				Global.choixSoir = 5
			else : Global.choixSoir = -1	
		)
		hbox.add_child(btnNon)
		vbox.add_child(hbox)
	else :
		print("ContenuPage non assigné")
	

func afficher_planning():
	if contenu_page :
		for child in contenu_page.get_children():
				child.queue_free()	
		var vbox = VBoxContainer.new()
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.add_theme_constant_override("separation",10)
		contenu_page.add_child(vbox)
		var resume_label = Label.new()
		resume_label.text = "Choisissez le déroulé de votre journée :"
		resume_label.add_theme_font_size_override("font_size", 18)
		resume_label.add_theme_color_override("font_color", Color.BLACK)
		vbox.add_child(resume_label)
		var i = 0
		for creneau_text in creneaux.keys():
			if(creneau_text not in Global.ChoixES["Créneau"]) :
				print(creneau_text, " ", Global.choixMatin, " ", Global.choixAprem, " ", Global.choixSoir)
				var btn = MenuButton.new()
				btn.add_theme_color_override("font_color", Color.BLACK)
				btn.add_theme_color_override("font_hover_color", Color.WEB_PURPLE)
				print(btn.get_theme_color("font_color_hover"))
				if(i ==0):
					if(Global.choixMatin == -1):
						btn.text = creneau_text
					else :
						btn.text = creneau_text + " : " + Global.ActionsJournée[Global.choixMatin]
				elif(i ==1):
					if(Global.choixAprem == -1):
						btn.text = creneau_text
					else :
						btn.text = creneau_text + " : " + Global.ActionsJournée[Global.choixAprem]
				elif(i ==2):
					if(Global.choixSoir == -1):
						btn.text = creneau_text
					else :
						btn.text = creneau_text + " : " + Global.ActionsSoir[Global.choixSoir]
				var popup = btn.get_popup()
				for option in creneaux[creneau_text]:
					popup.add_item(option)
				popup.id_pressed.connect(func(index):
					var action = popup.get_item_text(index)
					btn.text = creneau_text + " : " + action
					if creneau_text == "Créneau du matin" :
						Global.choixMatin = index
					elif creneau_text == "Créneau de l'après-midi" :
						Global.choixAprem = index
					else :
						Global.choixSoir = index
					if(Global.ChoixES != {} and Global.choixMatin != -1 and Global.choixAprem != -1 and Global.choixSoir !=-1) :
						Global.animValide=$AnimationPlayer
						$AnimationPlayer.play("anim_valide")
				)
				vbox.add_child(btn)
			else :
				var txt = Label.new()
				txt.add_theme_color_override("font_color", Color.DARK_RED)
				txt.horizontal_alignment =HORIZONTAL_ALIGNMENT_CENTER
				if(Global.ChoixES != {}):
					txt.text = Global.ChoixES["Description"]
					#+ " " + build_consequences_text(Global.ChoixES["Conséquences"])
				else :
					txt.text = creneau_text
				vbox.add_child(txt)
			i = i+1
	else :
		print("ContenuPage non assigné")
	
func _on_action_selected(index: int, creneau_text: String, popup: PopupMenu):
	var action = popup.get_item_text(index)
	print("Créneau :", creneau_text, "| Action choisie :", action)
