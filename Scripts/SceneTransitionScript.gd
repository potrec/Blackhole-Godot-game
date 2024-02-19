extends CanvasLayer

func change_scene(target: String) ->void:
	$AnimationPlayer.play("Dissolve")
	await($AnimationPlayer)
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("Dissolve")
	
	
