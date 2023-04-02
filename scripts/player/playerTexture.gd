extends Sprite
class_name PlayerTexture

onready var animation: AnimationPlayer =  get_node("%Animation")

func animate(velocity: Vector2) -> void:
	verifyOrientation(velocity.x)
	
	if velocity.y != 0:
		verticalBehavior(velocity.y)
		return
	
	horizontalBehavior(velocity.x)

func verifyOrientation(speed: float) -> void:
	if speed > 0:
		flip_h = false
	
	if speed < 0:
		flip_h = true
		

func verticalBehavior(speed: float) -> void:
	if speed < 0:
		animation.play("running")

func horizontalBehavior(speed: float) -> void:
	if speed != 0:
		animation.play("running")
		return
	
	animation.play("idle")
