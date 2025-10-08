extends ColorRect
func _ready():
	if Global.Statistiques["Santé"] <=0 or Global.Statistiques["Argent"] <=0 :
		visible = true
	else :
		visible = false
