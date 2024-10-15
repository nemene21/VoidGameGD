extends Camera2D

var shake_strength  = 0
var shakes_left     = 0
var shake_time      = 0
var shake_direction = null
export(float, 0, 100, 2) var rotation_strength

var transition = Tween.TRANS_QUAD
var easing     = Tween.EASE_IN_OUT

func _process(delta):
	
	rotation_degrees = offset.x * rotation_strength * 0.025

func interpolate_offset():
	
	$Tween.interpolate_property(
		self, "offset",
		
		offset,
		Vector2(
			rand_range(- 0.5 * shake_strength, 0.5 * shake_strength),
			rand_range(- 0.5 * shake_strength, 0.5 * shake_strength)
		),
		
		shake_time, transition, easing
	)
	
	$Tween.start()


func shake(new_shake_strength : float, new_shake_n : int, new_shake_time : float, new_shake_direction = null):
	
	if shake_strength <= new_shake_strength or shakes_left == 0: # If there is no stronger shake active...
		
		shake_strength = new_shake_strength
		
		shake_direction = new_shake_direction
		
		shakes_left = new_shake_n
		
		if new_shake_n == 1: shakes_left += 1
		
		shake_time = new_shake_time
		
		$Tween.stop(self, "offset")
		
		if shake_direction == null:
			
			interpolate_offset()
			
		else:
			
			var interpolate_to = Vector2(randf() * shake_strength, 0)
			
			interpolate_to = interpolate_to.rotated(deg2rad(shake_direction))
			
			$Tween.interpolate_property(
				self, "offset",
				
				offset,
				interpolate_to,
				
				shake_time, transition, easing
			)
			
			$Tween.start()


func _on_Tween_tween_completed(object, key):
	
	shakes_left -= 1
	
	if shakes_left == 0:
		
		shake_strength  = 0
		shake_direction = 0
		
		return
	
	if shakes_left == 1:
		
		$Tween.interpolate_property(
			self, "offset",
			
			offset,
			Vector2(),
			
			shake_time, transition, easing
		)
		
		$Tween.start()
		
		return
	
	if shake_direction == null:
		
		interpolate_offset()
		
	else:
		
		var interpolate_to = Vector2(randf() * shake_strength, 0)
		
		interpolate_to = interpolate_to.rotated(deg2rad(shake_direction))
		
		$Tween.interpolate_property(
			self, "offset",
			
			offset,
			interpolate_to,
			
			shake_time, transition, easing
		)
		
		$Tween.start()
