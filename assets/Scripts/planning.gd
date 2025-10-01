extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	for child in get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").get_children() :
			child.free()
	var planning_menuButton_matin = MenuButton.new()
	var planning_menuButton_apresmidi = MenuButton.new()
	var planning_menuButton_soir = MenuButton.new()
	var resume_label = Label.new()
	planning_menuButton_matin.get_popup().add_item("Réviser")
	planning_menuButton_matin.get_popup().add_item("Sortir")
	planning_menuButton_matin.get_popup().add_item("Dormir")
	planning_menuButton_matin.text = "Créneau du matin"
	planning_menuButton_apresmidi.get_popup().add_item("Réviser")
	planning_menuButton_apresmidi.get_popup().add_item("Sortir")
	planning_menuButton_apresmidi.get_popup().add_item("Dormir")	
	planning_menuButton_apresmidi.text = "Créneau de l'après midi"
	planning_menuButton_soir.get_popup().add_item("Réviser")
	planning_menuButton_soir.get_popup().add_item("Sortir")
	planning_menuButton_soir.get_popup().add_item("Dormir")	
	planning_menuButton_soir.text = "Créneau du soir"
	resume_label.text = "Choisissez le déroulé de votre journée : \n"
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(resume_label)
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(planning_menuButton_matin)
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(planning_menuButton_apresmidi)
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(planning_menuButton_soir)
