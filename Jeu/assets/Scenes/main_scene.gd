extends Node3D
func _ready() -> void:
	get_tree().get_root().get_node("/root/Scene/CharacterBody3D/Camera3D")
	$Maison/Cuisine/Patate.visible=Global.patate
	$Maison/Cuisine/Steak.visible=Global.steak
	$Maison/Cuisine/Viande.visible=Global.viande
	$Maison/Cuisine/Tomate.visible=Global.tomate
	$Maison/Cuisine/Salade.visible=Global.salade
	Global.hud=$HUD
