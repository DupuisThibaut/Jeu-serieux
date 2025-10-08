extends Button
	
@onready var center_container = $"/root/ComputerMenu/Computer/Onglets/CenterContainer"
var creneaux = {
	"Créneau du matin": Global.Actions,
	"Créneau de l'après-midi": Global.Actions,
	"Créneau du soir": Global.Actions
}
func _pressed():
	for child in center_container.get_children():
			child.queue_free()	
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation",10)
	center_container.add_child(vbox)
	var resume_label = Label.new()
	resume_label.text = "Choisissez le déroulé de votre journée :"
	resume_label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(resume_label)

	for creneau_text in creneaux.keys():
		var btn = MenuButton.new()
		btn.text = creneau_text
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
		
	
func _on_action_selected(index: int, creneau_text: String, popup: PopupMenu):
	var action = popup.get_item_text(index)
	print("Créneau :", creneau_text, "| Action choisie :", action)
