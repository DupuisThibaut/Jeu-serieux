extends Button
	
@onready var center_container = $"/root/Scene/Maison/Chambre/Ordinateur/SubViewport/Computer/Onglets/CenterContainer"
var creneaux = {
	"Créneau du matin": Global.Actions,
	"Créneau de l'après-midi": Global.Actions,
	"Créneau du soir": Global.Actions
}

func _pressed():
	var es = Global.ES[Global.ESinWeek[Global.numDayWeek]]
	print(es)
	for child in center_container.get_children():
			child.queue_free()	
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation",10)
	center_container.add_child(vbox)
	var resume_label = Label.new()
	resume_label.text = es["Description"]
	resume_label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(resume_label)
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.add_theme_constant_override("separation",10)
	var btnOui = Button.new()
	btnOui.text = es["Oui"]["Description"]
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
