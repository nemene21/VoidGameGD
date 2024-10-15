extends Particles2D

var dieTimer = 12

func _ready():
	emitting = true

func _process(delta):
	
	dieTimer -= delta
	
	if dieTimer < 0:
		queue_free()
		print("q267q2467q2647q24")
