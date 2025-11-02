extends Node

var Actions = ["Réviser", "Sortir", "Dormir"]
var ActionsJournée = ["Aller en cours", "Sortir", "Dormir"]
var ActionsSoir = ["Réviser", "Sortir", "Dormir"]

var choixMatin = -1

var choixAprem = -1

var choixSoir = -1

var Statistiques = {
	"Note" : 0,
	"Social" : 50,
	"Santé" : 100,
	"Argent" : 150
}

func changerStat(stat,nb):
	if stat=="Note":
		if Statistiques["Note"]+nb>20:
			Statistiques["Note"]=20
		else :
			Statistiques["Note"]+=nb
	if stat=="Social":
		if Statistiques["Social"]+nb>100:
			Statistiques["Social"]=100
		else :
			Statistiques["Social"]+=nb
	if stat=="Santé":
		if Statistiques["Santé"]+nb>100:
			Statistiques["Santé"]=100
		else :
			Statistiques["Santé"]+=nb

var ChoixES = {"Créneau": [],"Conséquences":{}}

var numDay = 1
var numDayWeek = 0

var viseur
var interaction
var quitter

var cameraPerso
func cam():
	cameraPerso.make_current()

var mangeAjd=false
var doucheAjd=false

var patate=true
var viande=true
var steak=true
var tomate=true
var salade=true

var animValide

var hud=false

signal changementScene()
func _on_changement_scene():
	print("i")

var ES = [
	{ "name" : "Faire des courses","Catégorie" : ["Argent"],"Description" : "Le frigo est vide, il faut que j'aille faire des courses aujourd'hui.",
	  "Oui" : {"Description" : "Aller faire les courses", "Conséquences": {"Argent" : -30}, "name": "Courses","Créneau" : ["Créneau du matin"]}, 
	  "Non" : {"Description" : "On verra plus tard", "Conséquences" : {"Santé" : -10},"Créneau" : []},
	  "type" : 2
	},
	
	{ "name" : "Blocus","Catégorie" : "Note","Description" : "La fac est bloqué. Compliqué d'y aller aujourd'hui.",
	  "Oui" : {"Description" : "Je vais réviser chez moi", "Conséquences": {"Note" : 0.6},"Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]}, 
	  "Non" : {"Description" : "Je vais me reposer", "Conséquences" : {},"Créneau" : []},
	  "type" : 1
	},
	
	{ "name" : "Evenement entre amis","Catégorie" : ["Social", "Argent"],"Description" : "Aujourd'hui, je dois rejoindre mes amis, j'aurais pas le temps de travailler...", 
	  "Oui" : {"Description" : "Je vais profiter de mes amis" , "Conséquences": {"Argent" : -20, "Social" : 10},"Créneau" : ["Créneau du soir"]}, 
	  "Non" : {"Description" : "Je préfère réviser", "Conséquences" : {"Note" : 0.5,"Social":-5},"Créneau" : ["Créneau du soir"]},
	  "type" : 0
	},
	
	{ "name" : "Malade", "Catégorie" : ["Santé"], "Description": "Je suis malade, j'aurais dû faire plus attention à ma santé...", 
	  "Oui": {"Description": "Je devrais rester chez moi et me reposer", "Conséquences":{"Santé" : 10},"Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]}, 
	  "Non" : {"Description" : "Il faut que j'aille travailler", "Conséquences" : {"Note" : 0.2, "Santé" : -20},"Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]},
	  "type" : 0
	},
	
	{ "name" : "Gagner de l'argent", "Catégorie" : ["Argent"], "Description" : "Je n'ai plus assez d'argent pour finir le mois, je devrais travailler un peu",
	  "Oui" : {"Description" : "Je vais faire du babysitting aujourd'hui", "Conséquences" : {"Argent" : 30},"Créneau": ["Créneau du soir"]}, 
	  "Non" : {"Description" : "Je vais diminuer mes dépenses", "Conséquences":{},"Créneau": []},
	  "type" : 3
	},
	
	{ "name": "Aller courir", "Catégorie": ["Santé"], "Description": "Une petite course ? Ça fait longtemps, c’est l’occasion pour rester en forme.", 
	  "Oui": {"Description": "Je pars courir", "Conséquences": {"Santé": 10},"Créneau": ["Créneau du soir"]}, 
	  "Non": {"Description": "Je reste chez moi", "Conséquences": {"Santé": -10},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Visite chez le médecin", "Catégorie": ["Santé", "Argent"], "Description": "J’ai une visite médicale de prévu, devrais-je y aller ?", 
	  "Oui": {"Description": "Je vais chez le médecin", "Conséquences": {"Santé": 10, "Argent": -20},"Créneau": ["Créneau de l'après-midi"]}, 
	  "Non": {"Description": "J’ignore le malaise", "Conséquences": {"Santé": -20},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Faire un site", "Catégorie": ["Argent"], "Description": "On m'a proposé de créer un site web contre rémunération, j'accepte ?", 
	  "Oui": {"Description": "Faire le site", "Conséquences": {"Argent": 10, "Social": -5},"Créneau": ["Créneau du matin"]}, 
	  "Non": {"Description": "Refuser l'offre", "Conséquences": {},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Aller au Restaurant", "Catégorie": ["Argent", "Santé"], "Description": "On m'a proposé d'aller au restaurant ce soir, j'y vais ou pas ?", 
	  "Oui": {"Description": "Je vais au restaurant", "Conséquences": {"Argent": -15, "Santé": 2, "Social": 5},"Créneau": ["Créneau du soir"]}, 
	  "Non": {"Description": "Je mange chez moi", "Conséquences": {},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Participer à un groupe de révision", "Catégorie": ["Note", "Social"], "Description": "Un groupe de révision est organisé aujourd’hui, devrais-je y aller ?", 
	  "Oui": {"Description": "Je participe au groupe", "Conséquences": {"Note": 0.6, "Social": 5},"Créneau": ["Créneau du matin", "Créneau de l'après-midi"]}, 
	  "Non": {"Description": "Je n’y vais pas", "Conséquences": {"Note": -0.1, "Social": -5},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Continuer un projet personnel", "Catégorie": ["Note"], "Description": "Pendant les vacances j'ai travaillé sur un projet perso je le continue, je pourrais améliorer mes compétences ?", 
	  "Oui": {"Description": "Je travaille sur mon projet", "Conséquences": {"Note": 0.4, "Social": -5},"Créneau": ["Créneau de l'après-midi","Créneau du soir"]}, 
	  "Non": {"Description": "Je ne fais rien", "Conséquences": {"Note": 0},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Sortie cinéma avec amis", "Catégorie": ["Social", "Argent"], "Description": "Mes amis vont au cinéma, devrais-je les rejoindre ?", 
	  "Oui": {"Description": "Je vais au cinéma", "Conséquences": {"Social": 15, "Argent": -10},"Créneau": ["Créneau du soir"]}, 
	  "Non": {"Description": "Je reste chez moi", "Conséquences": {"Social": -5},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Appeler ma famille", "Catégorie": ["Social"], "Description": "Je devrais appeler ma famille pour prendre des nouvelles.", 
	  "Oui": {"Description": "J’appelle ma famille", "Conséquences": {"Social": 10},"Créneau": ["Créneau du soir"]}, 
	  "Non": {"Description": "Je ne les appelle pas", "Conséquences": {"Social": -5},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Faire du sport avec des amis", "Catégorie": ["Santé", "Social"], "Description": "Mes amis proposent de faire du sport ensemble, devrais-je y aller ?", 
	  "Oui": {"Description": "Je vais faire du sport", "Conséquences": {"Santé": 10, "Social": 10},"Créneau": ["Créneau du matin", "Créneau du soir"]}, 
	  "Non": {"Description": "Je reste tranquille", "Conséquences": {"Santé": -5, "Social": -10},"Créneau": []},
	  "type" : 0
	},

	{ "name": "Rechercher mon stage", "Catégorie": ["Social"], "Description": "Je dois trouver un stage pour le prochain semestre, je m'y mets aujourd'hui ?", 
	  "Oui": {"Description": "Je cherche un stage", "Conséquences": {"Social": 5},"Créneau": ["Créneau du matin", "Créneau de l'après-midi"]}, 
	  "Non": {"Description": "Je chercherais plus tard", "Conséquences": {"Social": -5},"Créneau": []},
	  "type" : 1
	}
	]

func generate_ES_week():
	Global.ESinWeek = []
	randomize()
	if Global.numDay < 4:
		var tmp = []
		for i in range(Global.ES.size()):
			if Global.ES[i]["type"] == 0:
				tmp.append(i)
		tmp.shuffle()
		Global.ESinWeek = tmp.slice(0, 5)
	else:
		var candidats = []
		for i in range(Global.ES.size()):
			if Global.ES[i]["type"] in [0, 1]:
				candidats.append(i)
		if candidats.size() > 0:
			candidats.shuffle()
			Global.ESinWeek = candidats.slice(0,5)
	
var ESinWeek := [2,5,7,9,11]
