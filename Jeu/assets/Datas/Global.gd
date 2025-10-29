extends Node

var Actions = ["Réviser", "Sortir", "Dormir"]

var Note = 12

var choixMatin = -1

var choixAprem = -1

var choixSoir = -1

var Statistiques = {
	"Note" : 0,
	"Social" : 50,
	"Santé" : 50,
	"Argent" : 150
}

var ChoixES = {}

var numDay = 1
var numDayWeek = 0

var ESinWeek = [0,1,2,3,4]

var ES = [
		{ "name" : "Faire des courses","Catégorie" : ["Santé","Argent"],"Description" : "Le frigo est vide, il faut que j'aille faire des courses aujourd'hui.","Oui" : {"Description" : "Aller faire les courses", "Conséquences": {"Argent" : -30, "Santé" : 10}}, "Non" : {"Description" : "On verra plus tard", "Conséquences" : {"Santé" : -10}}, "Créneau" : ["Créneau du matin"]},
		{"name" : "Blocus","Catégorie" : "Note","Description" : "Les étudiants sont pas content, ils ont bloqué la fac. Compliqué d'y aller aujourd'hui.","Oui" : {"Description" : "Je vais réviser chez moi", "Conséquences": {"Note" : 10}}, "Non" : {"Description" : "Je vais me reposer", "Conséquences" : {"Santé" : 10}}, "Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]},
		{"name" : "Evenement entre amis","Catégorie" : ["Social", "Argent"],"Description" : "Aujourd'hui, je dois rejoindre mes amis, j'aurais pas le temps de travailler...", "Oui" : {"Description" : "Je vais profiter de mes amis" , "Conséquences": {"Argent" : -20, "Social" : 10}}, "Non" : {"Description" : "Je préfère réviser", "Conséquences" : {"Note" : 5}}, "Créneau" : ["Créneau du soir"]},
		{"name" : "Malade", "Catégorie" : ["Santé"], "Description": "Je suis malade, j'aurais dû faire plus attentation à ma santé...", "Oui": {"Description": "Je devrais rester chez moi et me reposer", "Conséquences":{"Santé" : 20}}, "Non" : {"Description" : "Il faut que j'aille travailler", "Conséquences" : {"Note" : 10, "Santé" : -10}}, "Créneau" : ["Créneau du matin", "Créneau de l'après-midi"]},
		{"name" : "Gagner de l'argent", "Catégorie" : ["Argent"], "Description" : "Je n'ai plus assez d'argent pour finir le mois, je devrais travailler un peu","Oui" : {"Description" : "Je vais faire du babysitting aujourd'hui", "Conséquences" : {"Argent" : 30}}, "Non" : {"Description" : "Je vais diminuer mes dépenses", "Conséquences":{}}, "Créneau" : ["Créneau du soir"]}
		]

var viseur
var interaction
var quitter

var cameraPerso
func cam():
	cameraPerso.make_current()

@onready
var cameraOrdi=get_node("CameraOrdi")

signal changementScene()
func _on_changement_scene():
	print("i")
