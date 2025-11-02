extends Label

func _ready():
	text ="Vos résultats de partiels sont arrivés !!!\n\n Vous avez obtenu la note de "+str(Global.Statistiques["Note"])+"/20\n\n Mais à quel prix ?\n Santé : "+str(Global.Statistiques["Santé"])+" %\n Argent : "+str(Global.Statistiques["Argent"])+" euros\n Social : "+str(Global.Statistiques["Social"])+" %"
	
