extends Button
	
@onready var center_container = $"/root/ComputerMenu/Computer/Onglets/CenterContainer"

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
	var creneaux = {
		"Créneau du matin": ["Réviser", "Sortir", "Dormir"],
		"Créneau de l'après-midi": ["Réviser", "Sortir", "Dormir"],
		"Créneau du soir": ["Réviser", "Sortir", "Dormir"]
	}
	for creneau_text in creneaux.keys():
		var btn = MenuButton.new()
		btn.text = creneau_text
		var popup = btn.get_popup()
		for option in creneaux[creneau_text]:
			popup.add_item(option)
		vbox.add_child(btn)
