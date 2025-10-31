extends Label

func _ready():
	text ="Vos résultats de partiels sont arrivés !!!\n\n Vous avez obtenu la note de "+str(Global.Statistiques["Note"])+"\n\n Mais à quel prix ?\n Santé : "+str(Global.Statistiques["Santé"])+"\n Argent : "+str(Global.Statistiques["Argent"])+"\n Social : "+str(Global.Statistiques["Social"])
	
