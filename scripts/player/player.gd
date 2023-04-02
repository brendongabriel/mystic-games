extends KinematicBody2D
class_name Player

onready var sprite: Sprite = get_node("Texture")

var velocity: Vector2

export(int) var moveSpeed
export(int) var jumpSpeed

export(int) var gravitySpeed

func _physics_process(delta: float) -> void:
	move()
	jump(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	sprite.animate(velocity)

func move() -> void:
	velocity.x = moveSpeed * getDirection()
	pass 
	
func getDirection() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func jump(delta: float) -> void:
	velocity.y += delta * gravitySpeed
	
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = -jumpSpeed
