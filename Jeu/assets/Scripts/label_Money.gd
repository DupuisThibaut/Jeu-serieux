extends Label


func _ready():
	text = "Argent : " +str(Global.Statistiques["Argent"]) + "€"

func change():
	text = "Argent : " +str(Global.Statistiques["Argent"]) + "€"
