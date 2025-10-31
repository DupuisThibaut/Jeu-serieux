extends ProgressBar

func _ready():
	value = Global.Statistiques["Santé"]

func change():
	value = Global.Statistiques["Santé"]
