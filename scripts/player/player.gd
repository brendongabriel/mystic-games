extends KinematicBody2D
class_name Player

onready var sprite: Sprite = get_node("Texture")

var velocity: Vector2
var can_attack: bool = true

export(int) var moveSpeed
export(int) var jumpSpeed

export(int) var gravitySpeed
export(int) var health


func _physics_process(delta: float) -> void:
	move()
	attack()
	jump(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	sprite.animate(velocity)
	verify_heigth();

func move() -> void:
	velocity.x = moveSpeed * getDirection()
	pass 
	
func getDirection() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func jump(delta: float) -> void:
	velocity.y += delta * gravitySpeed
	
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = -jumpSpeed

func attack() -> void:
	if Input.is_action_just_pressed("ui_attack") and is_on_floor() and can_attack:
		sprite.action_behavior("attack")
		can_attack = false
		
		

func update_health(value: int) -> void:
	health -= value
	print(health)
	
	if health <= 0:
		var _reload: bool = get_tree().change_scene("res://scences/management/gameLevel.tscn")
		return
		
	sprite.action_behavior("hit")
	
func verify_heigth() -> void:
	if position.y > 200:
		var _reload: bool = get_tree().change_scene("res://scences/management/gameLevel.tscn")
		return
	print(position.y)

