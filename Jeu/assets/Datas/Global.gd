extends Node

var Actions = ["Réviser", "Sortir", "Dormir"]

var choixMatin = -1

var choixAprem = -1

var choixSoir = -1

var Statistiques = {
	"Note" : 0,
	"Social" : 50,
	"Santé" : 100,
	"Argent" : 150
}

var ChoixES = {}

var numDay = 1
var numDayWeek = 0

var viseur
var interaction
var quitter

var cameraPerso
func cam():
	cameraPerso.make_current()



signal changementScene()
func _on_changement_scene():
	print("i")

var ES = [
	{ "name" : "Faire des courses","Catégorie" : ["Santé","Argent"],"Description" : "Le frigo est vide, il faut que j'aille faire des courses aujourd'hui.",
	  "Oui" : {"Description" : "Aller faire les courses", "Conséquences": {"Argent" : -30, "Santé" : 10}}, 
	  "Non" : {"Description" : "On verra plus tard", "Conséquences" : {"Santé" : -10}}, 
	  "Créneau" : ["Créneau du matin"]},
	
	{ "name" : "Blocus","Catégorie" : "Note","Description" : "Les étudiants sont pas content, ils ont bloqué la fac. Compliqué d'y aller aujourd'hui.",
	  "Oui" : {"Description" : "Je vais réviser chez moi", "Conséquences": {"Note" : 0.3}}, 
	  "Non" : {"Description" : "Je vais me reposer", "Conséquences" : {"Santé" : 5}}, 
	  "Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]},
	
	{ "name" : "Evenement entre amis","Catégorie" : ["Social", "Argent"],"Description" : "Aujourd'hui, je dois rejoindre mes amis, j'aurais pas le temps de travailler...", 
	  "Oui" : {"Description" : "Je vais profiter de mes amis" , "Conséquences": {"Argent" : -20, "Social" : 10}}, 
	  "Non" : {"Description" : "Je préfère réviser", "Conséquences" : {"Note" : 0.5}}, 
	  "Créneau" : ["Créneau du soir"]},
	
	{ "name" : "Malade", "Catégorie" : ["Santé"], "Description": "Je suis malade, j'aurais dû faire plus attentation à ma santé...", 
	  "Oui": {"Description": "Je devrais rester chez moi et me reposer", "Conséquences":{"Santé" : 20}}, 
	  "Non" : {"Description" : "Il faut que j'aille travailler", "Conséquences" : {"Note" : 0.2, "Santé" : -20}}, 
	  "Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]},
	
	{ "name" : "Gagner de l'argent", "Catégorie" : ["Argent"], "Description" : "Je n'ai plus assez d'argent pour finir le mois, je devrais travailler un peu",
	  "Oui" : {"Description" : "Je vais faire du babysitting aujourd'hui", "Conséquences" : {"Argent" : 30}}, 
	  "Non" : {"Description" : "Je vais diminuer mes dépenses", "Conséquences":{}}, 
	  "Créneau" : ["Créneau du soir"]},
	
	{ "name": "Aller courir", "Catégorie": ["Santé"], "Description": "Il fait beau, c’est l’occasion d’aller courir pour rester en forme.", 
	  "Oui": {"Description": "Je pars courir", "Conséquences": {"Santé": 15}}, 
	  "Non": {"Description": "Je reste chez moi", "Conséquences": {"Santé": -10}}, 
	  "Créneau": ["Créneau du matin"]},

	{ "name": "Visite chez le médecin", "Catégorie": ["Santé", "Argent"], "Description": "J’ai un petit malaise, devrais-je aller chez le médecin ?", 
	  "Oui": {"Description": "Je vais chez le médecin", "Conséquences": {"Santé": 20, "Argent": -20}}, 
	  "Non": {"Description": "J’ignore le malaise", "Conséquences": {"Santé": -20}}, 
	  "Créneau": ["Créneau de l'après-midi"]},

	{ "name": "Vendre des objets", "Catégorie": ["Argent"], "Description": "J’ai des objets inutilisés, je pourrais les vendre pour gagner un peu d’argent.", 
	  "Oui": {"Description": "Je vends mes objets", "Conséquences": {"Argent": 20, "Social": -5}}, 
	  "Non": {"Description": "Je garde mes objets", "Conséquences": {}}, 
	  "Créneau": ["Créneau du matin"]},

	{ "name": "Acheter un café luxueux", "Catégorie": ["Argent", "Santé"], "Description": "Envie d’un bon café pour me réveiller, ça coûte cher…", 
	  "Oui": {"Description": "J’achète le café", "Conséquences": {"Argent": -5, "Santé": 5}}, 
	  "Non": {"Description": "Je reste sobre", "Conséquences": {}}, 
	  "Créneau": ["Créneau du matin"]},

	{ "name": "Participer à un groupe de révision", "Catégorie": ["Note", "Social"], "Description": "Un groupe de révision est organisé aujourd’hui, devrais-je y aller ?", 
	  "Oui": {"Description": "Je participe au groupe", "Conséquences": {"Note": 0.3, "Social": 5}}, 
	  "Non": {"Description": "Je n’y vais pas", "Conséquences": {"Note": -0.1, "Social": -5}}, 
	  "Créneau": ["Créneau du matin", "Créneau de l'après-midi"]},

	{ "name": "Faire un projet personnel", "Catégorie": ["Note"], "Description": "Travailler sur un projet perso pourrait améliorer mes compétences.", 
	  "Oui": {"Description": "Je travaille sur mon projet", "Conséquences": {"Note": 0.2, "Social": -5}}, 
	  "Non": {"Description": "Je ne fais rien", "Conséquences": {"Note": 0}}, 
	  "Créneau": ["Créneau de l'après-midi"]},

	{ "name": "Sortie cinéma avec amis", "Catégorie": ["Social", "Argent"], "Description": "Mes amis vont au cinéma, devrais-je les rejoindre ?", 
	  "Oui": {"Description": "Je vais au cinéma", "Conséquences": {"Social": 15, "Argent": -10}}, 
	  "Non": {"Description": "Je reste chez moi", "Conséquences": {"Social": -5}}, 
	  "Créneau": ["Créneau du soir"]},

	{ "name": "Appeler un membre de la famille", "Catégorie": ["Social"], "Description": "Je devrais appeler ma famille pour prendre des nouvelles.", 
	  "Oui": {"Description": "J’appelle ma famille", "Conséquences": {"Social": 10}}, 
	  "Non": {"Description": "Je ne les appelle pas", "Conséquences": {"Social": -5}}, 
	  "Créneau": ["Créneau de l'après-midi"]},

	{ "name": "Faire du sport avec des amis", "Catégorie": ["Santé", "Social"], "Description": "Mes amis proposent de faire du sport ensemble, devrais-je y aller ?", 
	  "Oui": {"Description": "Je vais faire du sport", "Conséquences": {"Santé": 10, "Social": 10}}, 
	  "Non": {"Description": "Je reste tranquille", "Conséquences": {"Santé": -5}}, 
	  "Créneau": ["Créneau du matin", "Créneau du soir"]},

	{ "name": "Travailler sur un stage", "Catégorie": ["Note", "Argent"], "Description": "Mon stage demande du travail aujourd’hui, devrais-je m’y consacrer ?", 
	  "Oui": {"Description": "Je travaille sur le stage", "Conséquences": {"Note": 0.2, "Argent": 10}}, 
	  "Non": {"Description": "Je procrastine", "Conséquences": {"Note": -0.5}}, 
	  "Créneau": ["Créneau du matin", "Créneau de l'après-midi"]}
	]
var ESinWeek := Array(range(ES.size()))
