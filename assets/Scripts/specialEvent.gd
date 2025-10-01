extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	for child in get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").get_children() :
			child.free()
	var SE_accept = Button.new()
	var SE_refuse = Button.new()
	var resume_label = Label.new()
	SE_accept.text = "OUI"
	SE_refuse.text = "NON"
	resume_label.text = "Choisissez le déroulé de votre journée : \n"
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(resume_label)
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(SE_accept)
	get_tree().get_root().get_node("/root/ComputerMenu/Computer/Onglets/CenterContainer").add_child(SE_refuse)
