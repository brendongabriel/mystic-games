extends KinematicBody2D
class_name Player

const PROJECTILE: PackedScene = preload("res://scences/player/arrow.tscn")

onready var sprite: Sprite = get_node("Texture")
onready var spawn_point: Position2D = get_node("SpawnPoint")

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

func spawn_projectile() -> void:
	var projectile: Arrow = PROJECTILE.instance()
	projectile.direction = sign(spawn_point.position.x)
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = spawn_point.global_position

func attack() -> void:
	if Input.is_action_just_pressed("ui_attack") and is_on_floor() and can_attack:
		sprite.action_behavior("attack")
		can_attack = false

func update_health(value: int) -> void:
	health -= value
	
	if health <= 0:
		var _reload: bool = get_tree().change_scene("res://scences/management/gameLevel.tscn")
		return
		
	sprite.action_behavior("hit")
	
func verify_heigth() -> void:
	if position.y > 200:
		var _reload: bool = get_tree().change_scene("res://scences/management/gameLevel.tscn")
		return

