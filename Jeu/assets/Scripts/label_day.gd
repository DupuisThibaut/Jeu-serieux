extends Label

var days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"]

func _ready():
	text = days[(Global.numDay%5)-1] + " (Jour "+str(Global.numDay) + ")"
	print(days[(Global.numDay%5)-1], (Global.numDay%5)-1)
	
func change():
	text = days[(Global.numDay%5)-1] + " (Jour "+str(Global.numDay) + ")"
	print(days[(Global.numDay%5)-1], (Global.numDay%5)-1)
	
