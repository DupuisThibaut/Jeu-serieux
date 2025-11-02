extends CanvasLayer

var start=false

func _ready() -> void:
	$health.visible = false
	$health.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _input(event):
	if start:
		if event is InputEventKey:
			if event.pressed and event.keycode==KEY_ENTER:
				start=false
				get_tree().change_scene_to_file("res://assets/Scenes/MainScene.tscn")
				$anim_transition.play(anim_name("close",3))
				if $health.visible == false:
					$health.visible = true
					var h = clamp(Global.Statistiques["Santé"], 0, 100)
					$health.material.set_shader_parameter("health", h)
					$health.material.set_shader_parameter("blur_strength", (1.0-(h/100.0)))
			
func new():
	$Start.visible=true
	$anim_transition.play(anim_name("open",3))
	await $anim_transition.animation_finished
	start=true
	
func douche():
	#$AudioStreamPlayer.stop()
	$Jour.text="Je prends ma douche !"
	$Jour.visible=true
	$anim_transition.play(anim_name("open",2))
	$BruitDouche.play()
	await $anim_transition.animation_finished
	await $BruitDouche.finished
	$BruitDouche.stop()
	$anim_transition.play(anim_name("close",2))
	$Jour.visible=false

func change_scene(newScene, transitionType):
	if transitionType==2:
		$Jour.text="Jour "+str(Global.numDay)
		$Jour.visible=true
	$anim_transition.play(anim_name("open",transitionType))
	await $anim_transition.animation_finished
	get_tree().change_scene_to_file(newScene)
	$anim_transition.play(anim_name("close",transitionType))
	$health.visible = true
	var h = clamp(Global.Statistiques["Santé"], 0, 100)
	$health.material.set_shader_parameter("health", h)
	$health.material.set_shader_parameter("blur_strength", (1.0-(h/100.0)))
	$Jour.visible=false

func change_camera(camera, transitionType):
	$anim_transition.play(anim_name("open",transitionType))
	await $anim_transition.animation_finished
	camera.make_current()
	$anim_transition.play(anim_name("close",transitionType))
	if $health.visible == true:
		$health.visible = false
	else :
		$health.visible = true
		var h = clamp(Global.Statistiques["Santé"], 0, 100)
		$health.material.set_shader_parameter("health", h)
		$health.material.set_shader_parameter("blur_strength", (1.0-(h/100.0)))
	
func anim_name(transitionState,transitionType):
	if transitionState=="open":
		if transitionType==1:
			return "anim1_open"
		if transitionType==2:
			return "anim2_open"
		if transitionType==3:
			return "anim3_open"
	elif transitionState=="close":
		if transitionType==1:
			return "anim1_close"
		if transitionType==2:
			return "anim2_close"
		if transitionType==3:
			return "anim3_close"
