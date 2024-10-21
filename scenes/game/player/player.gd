extends CharacterBody2D
class_name Player

var speed: float = 100
var acceleration: float = 15
@export var legs: Node2D
@export var move_comp: MoveComp
var direction := Vector2.ZERO

var interactors: Array[InteractionPoint]

func _ready() -> void:
	VfxManager.set_target(get_parent())

## Find closest interactor and make it active
func handle_interactors() -> void:
	var best_len := 99999
	var best_pos := Vector2.ZERO
	
	for interactor in interactors:
		interactor.closest = false
		var leng := global_position.distance_to(interactor.global_position)
		if leng < best_len:
			best_len = leng
			best_pos = interactor.global_position
	
	for interactor in interactors:
		if interactor.global_position == best_pos:
			interactor.closest = true
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	move_comp.lerp_vel(input * speed, acceleration * delta)
	
	var vel := move_comp.velocity
	
	## Move animation
	direction = Global.dlerp(direction, vel.normalized(), 20 * delta)
	$Body.global_rotation = direction.angle()
	$Body/Head.position.x = Global.dlerp(
		$Body/Head.position.x, vel.length() * 0.025 + 1, 20 * delta
	)
	var bob_head := sin(Global.time * PI * 4) * 0.15
	var bob_body := sin(Global.time * PI * 4 + PI * 0.25) * 0.15
	$Body/Head.scale = Global.dlerp(
		$Body/Head.scale, Vector2.ONE * (1 + bob_head * input.length()), 20 * delta
	)
	$Body/Body.scale = Global.dlerp(
		$Body/Body.scale, Vector2.ONE * (1 + bob_body * input.length()), 20 * delta
	)
	
	legs.global_position = global_position + move_comp.get_speed() * 0.25
	
	handle_interactors()

func _on_health_died() -> void:
	VfxManager.explode_sprite($Sprite)
	queue_free()
