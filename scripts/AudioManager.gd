extends Node


var sounds = {}

var last_track_played = null

var track_pitch = 1



func add_track(name : String, path : String):
	
	var audioNode = AudioStreamPlayer.new()
	
	audioNode.stream = load(path)
	
	audioNode.name = name
	
	audioNode.volume_db = -40
	
	add_child(audioNode)



func play_track(name : String, time : float = 1.0):
	
	var TrackPlayer = get_node(name)
	
	TrackPlayer.play()
	
	$TrackTween.interpolate_property(TrackPlayer, "volume_db", TrackPlayer.volume_db, 0, time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	if last_track_played != null:
		
		$TrackTween.interpolate_property(get_node(last_track_played), "volume_db", get_node(last_track_played).volume_db, -40, time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	$TrackTween.start()
	
	last_track_played = name
	
	
	
func stop_track(time : float = 1.0):
	
	if last_track_played != null:
		
		$TrackTween.interpolate_property(get_node(last_track_played), "volume_db", get_node(last_track_played).volume_db, -40, time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$TrackTween.start()
		
	last_track_played = null
	
	
	
func _on_TrackTween_tween_completed(object, key): # Stop faded out sounds from playing
	
	if object.volume_db == -40:
		
		object.stop()



func add_sound(name : String, path : String):
	sounds[name] = load(path)



func play_sound(sound : String, pitch : float = 1.0, added_volume : float = 0.0, pitch_randomness : float = 0.0):
	
	var audioNode = AudioStreamPlayer.new()
	
	audioNode.stream = sounds[sound]
	audioNode.autoplay = true
	audioNode.pitch_scale = pitch + randf() * pitch_randomness
	audioNode.volume_db = added_volume
	
	audioNode.connect("finished", audioNode, "queue_free")
	
	add_child(audioNode)
	
	return audioNode

func play_randsound(soundsArg : Array, pitch : float = 1.0, added_volume : float = 0.0, pitch_randomness : float = 0.0):
	
	return play_sound(soundsArg[int( randf() * len(soundsArg) )], pitch, added_volume, pitch_randomness)



func play_sound2d(sound : float, pos : Vector2, max_dist : int, pitch : float = 1.0, added_volume : float = 0.0, pitch_randomness : float = 0.0):
	
	var audioNode = AudioStreamPlayer2D.new()
	
	audioNode.stream = sounds[sound]
	audioNode.autoplay = true
	audioNode.pitch_scale = pitch + randf() * pitch_randomness
	audioNode.volume_db = added_volume
	audioNode.global_position = pos
	audioNode.max_distance = max_dist
	
	audioNode.connect("finished", audioNode, "queue_free")
	
	add_child(audioNode)
	
	return audioNode



func play_randsound2d(soundsArg : Array, pos : Vector2, max_dist : int, pitch : float = 1.0, added_volume : float = 0.0, pitch_randomness : float = 0.0):
	
	return play_sound2d(soundsArg[int( randf() * len(soundsArg) )], pos, max_dist, pitch, added_volume, pitch_randomness)
