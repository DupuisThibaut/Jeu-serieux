extends ColorRect
func _ready():
	if Global.Statistiques["Santé"] <=0 or Global.Statistiques["Argent"] <=0 :
		visible = true
		await get_tree().create_timer(2.0).timeout
		SceneTransition.change_scene("res://assets/Scenes/End2.tscn",1)
		
	else :
		visible = false
