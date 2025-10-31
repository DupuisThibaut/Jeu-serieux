extends ProgressBar

func _ready():
	value = Global.Statistiques["Social"]
	
func change():
	value = Global.Statistiques["Social"]
