extends CanvasLayer

func change_scene(newScene, transitionType):
	$anim_transition.play(anim_name("open",transitionType))
	await $anim_transition.animation_finished
	get_tree().change_scene_to_file(newScene)
	$anim_transition.play(anim_name("close",transitionType))
	
func change_camera(camera, transitionType):
	$anim_transition.play(anim_name("open",transitionType))
	await $anim_transition.animation_finished
	camera.make_current()
	$anim_transition.play(anim_name("close",transitionType))
	
func anim_name(transitionState,transitionType):
	if transitionState=="open":
		if transitionType==1:
			return "anim1_open"
	elif transitionState=="close":
		if transitionType==1:
			return "anim1_close"
