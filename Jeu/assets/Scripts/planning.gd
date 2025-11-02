extends Button
	
@export var contenu_page: Node
var creneaux = {
	"Créneau du matin": Global.Actions,
	"Créneau de l'après-midi": Global.Actions,
	"Créneau du soir": Global.Actions
}
func _pressed():
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
		vbox.add_child(resume_label)
		var i = 0
		for creneau_text in creneaux.keys():
			if(creneau_text not in Global.ES[Global.ESinWeek[Global.numDayWeek]]["Créneau"]) :
				print(creneau_text, " ", Global.choixMatin, " ", Global.choixAprem, " ", Global.choixSoir)
				var btn = MenuButton.new()
				btn.add_theme_color_override("font_color_hover",Color.WEB_PURPLE)
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
