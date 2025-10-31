extends CanvasLayer
func _ready() -> void:
	$health.visible = false
	$health.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func change_scene(newScene, transitionType):
	$anim_transition.play(anim_name("open",transitionType))
	await $anim_transition.animation_finished
	get_tree().change_scene_to_file(newScene)
	$anim_transition.play(anim_name("close",transitionType))
	$health.visible = true
	var h = clamp(Global.Statistiques["Santé"], 0, 100)
	$health.material.set_shader_parameter("health", h)
	$health.material.set_shader_parameter("blur_strength", (1.0-(h/100.0)))

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
	elif transitionState=="close":
		if transitionType==1:
			return "anim1_close"
