extends TabBar
@export var contenu_page: Node
var creneaux = {
	"Créneau du matin": Global.Actions,
	"Créneau de l'après-midi": Global.Actions,
	"Créneau du soir": Global.Actions
}
func _ready():
	connect("tab_changed", Callable(self, "_on_tab_changed"))

func _on_tab_changed(tab_index):
	match tab_index:
		0:
			afficher_resume()
			print("hello")
		1:
			afficher_evenements()
		2:
			afficher_planning()

func afficher_resume():
	if contenu_page :
		for child in contenu_page.get_children() :
			child.queue_free()
		var resume_label = Label.new()
		resume_label.text = "Bonjour !!\n La journée d'hier fut longue, votre état a beaucoup changé !! \n Voici un résumé de vos statistiques : \n Santé : "+ str(Global.Statistiques["Santé"])+"\n\n Argent : "+ str(Global.Statistiques["Argent"])+"\n\n Vous ne semblez pas très en forme et votre frigo est vide..."
		resume_label.add_theme_color_override("font_color", Color.BLACK)
		contenu_page.add_child(resume_label)
	else:
		print("ContenuPage non assigné")


func afficher_evenements():
	if contenu_page :
		var es = Global.ES[Global.ESinWeek[Global.numDayWeek]]
		print(es)
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
		btnOui.text = es["Oui"]["Description"]
		btnOui.add_theme_color_override("font_color", Color.BLACK)
		btnOui.pressed.connect(func():
			Global.ChoixES = es["Oui"]
			if("Créneau du matin" in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]):
				Global.choixMatin = 4
			if("Créneau de l'après-midi" in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]):
				Global.choixAprem = 4
			if("Créneau du soir" in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]):
				Global.choixSoir = 4		
		)
		hbox.add_child(btnOui)
		var btnNon = Button.new()
		btnNon.text = es["Non"]["Description"]
		btnNon.add_theme_color_override("font_color", Color.BLACK)
		btnNon.pressed.connect(func():
			Global.ChoixES = es["Non"]
			if("Créneau du matin" in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]):
				Global.choixMatin = 5
			if("Créneau de l'après-midi" in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]):
				Global.choixAprem = 5
			if("Créneau du soir" in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]):
				Global.choixSoir = 5	
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
			if(creneau_text not in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]) :
				print(creneau_text, " ", Global.choixMatin, " ", Global.choixAprem, " ", Global.choixSoir)
				var btn = MenuButton.new()
				btn.add_theme_color_override("font_color", Color.BLACK)
				if(i ==0):
					if(Global.choixMatin == -1):
						btn.text = creneau_text
					else :
						btn.text = creneau_text + " : " + Global.Actions[Global.choixMatin]
				elif(i ==1):
					if(Global.choixAprem == -1):
						btn.text = creneau_text
					else :
						btn.text = creneau_text + " : " + Global.Actions[Global.choixAprem]
				elif(i ==2):
					if(Global.choixSoir == -1):
						btn.text = creneau_text
					else :
						btn.text = creneau_text + " : " + Global.Actions[Global.choixSoir]
				var popup = btn.get_popup()
				for option in creneaux[creneau_text]:
					popup.add_item(option)
				popup.id_pressed.connect(func(index):
					var action = popup.get_item_text(index)
					print("Créneau :", creneau_text, "| Action choisie :", action, "| id : ", index)
					btn.text = creneau_text + " : " + action
					if creneau_text == "Créneau du matin" :
						Global.choixMatin = index
					elif creneau_text == "Créneau de l'après-midi" :
						Global.choixAprem = index
					else :
						Global.choixSoir = index
				)
				vbox.add_child(btn)
			else :
				var txt = Label.new()
				txt.add_theme_color_override("font_color", Color.BLACK)
				txt.horizontal_alignment =HORIZONTAL_ALIGNMENT_CENTER
				if(Global.ChoixES != {}):
					txt.text = Global.ChoixES["Description"]
				else :
					txt.text = creneau_text
				vbox.add_child(txt)
			i = i+1
	else :
		print("ContenuPage non assigné")
	
func _on_action_selected(index: int, creneau_text: String, popup: PopupMenu):
	var action = popup.get_item_text(index)
	print("Créneau :", creneau_text, "| Action choisie :", action)
