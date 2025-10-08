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
	resume_label.text = "Aujourd'hui est un jour spécial : \n\n Vous devez Manger !!! \n\n Allons-nous faire des courses aujourd'hui ?"
	resume_label.add_theme_font_size_override("font_size", 18)
	vbox.add_child(resume_label)
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.add_theme_constant_override("separation",10)
	var btnOui = Button.new()
	btnOui.text = "OUI"
	btnOui.pressed.connect(func():
		Global.ChoixES = true
	)
	hbox.add_child(btnOui)
	var btnNon = Button.new()
	btnNon.text = "NON"
	btnNon.pressed.connect(func():
		Global.ChoixES = false
	)
	hbox.add_child(btnNon)
	vbox.add_child(hbox)
