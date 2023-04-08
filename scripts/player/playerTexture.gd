extends Sprite
class_name PlayerTexture

onready var animation: AnimationPlayer =  get_node("%Animation")

onready var parent: KinematicBody2D = get_parent()

var on_action: bool = false

func animate(velocity: Vector2) -> void:
	verifyOrientation(velocity.x)
	
	if on_action:
		return
	
	if velocity.y != 0:
		verticalBehavior(velocity.y)
		return
	
	horizontalBehavior(velocity.x)

func verifyOrientation(speed: float) -> void:
	if speed > 0:
		flip_h = false
	
	if speed < 0:
		flip_h = true
		
func action_behavior(action: String) -> void:
	on_action = true
	animation.play(action)

func verticalBehavior(speed: float) -> void:
	if speed < 0:
		animation.play("running")

func horizontalBehavior(speed: float) -> void:
	if speed != 0:
		animation.play("running")
		return
	
	animation.play("idle")

func _on_animation_finished(anim_name: String) -> void:
	print(anim_name)
	if anim_name == "hit":
		on_action = false
		parent.set_physics_process(true)
