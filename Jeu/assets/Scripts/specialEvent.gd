extends Button
	
@export var contenu_page: Node
var creneaux = {
	"Créneau du matin": Global.Actions,
	"Créneau de l'après-midi": Global.Actions,
	"Créneau du soir": Global.Actions
}

func _pressed():
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
		vbox.add_child(resume_label)
		var hbox = HBoxContainer.new()
		hbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_theme_constant_override("separation",10)
		var btnOui = Button.new()
		btnOui.add_theme_color_override("font_color", Color.WHITE)
		btnOui.add_theme_color_override("font_color_hover", Color.BLACK) 
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.2, 0.4, 1)
		style.border_radius_top_left = 10
		style.border_radius_top_right = 10
		style.border_radius_bottom_left = 10
		style.border_radius_bottom_right = 10
		style.border_width = 2
		style.border_color = Color(0,0,0)
		btnOui.add_theme_stylebox_override("normal", style)
		var style_hover = style.duplicate()
		style_hover.bg_color = Color(0.3, 0.5, 1)
		btnOui.add_theme_stylebox_override("hover", style_hover)
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
		btnNon.add_theme_color_override("font_color", Color.WHITE)
		btnNon.add_theme_color_override("font_color_hover", Color.BLACK) 
		btnNon.add_theme_stylebox_override("normal", style)
		btnNon.add_theme_stylebox_override("hover", style_hover)
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
	else :
		print("ContenuPage non assigné")
