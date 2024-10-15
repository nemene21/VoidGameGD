extends CanvasLayer

var next_scene = null

func transition_scene(scene : String, time : float = 1.0, transition : String = "FadeInOut"):
	
	if next_scene != null: # Return if timer is active
		
		return
		
	$Transitioner.playback_speed = 1 / time
	
	$Transitioner.play(transition)
	
	next_scene = scene # Set new scene

func rand_transition():
	
	randomize()
	
	return $Transitioner.get_animation_list()[rand_range(0, len($Transitioner.get_animation_list()))]

func _on_Transitioner_animation_finished(anim_name): # Transition done
	
	next_scene = null

func switch_scene():
	
	get_tree().change_scene(next_scene)
