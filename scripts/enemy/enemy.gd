extends KinematicBody2D
class_name Enemy

onready var sprite: Sprite = get_node("Texture")
onready var attack_timer: Timer = get_node("AttackCooldown")

var player_ref: KinematicBody2D = null
var velocity: Vector2

export(int) var move_speed
export(int) var distance_threshold
export(int) var enemy_damage
export(int) var health
export(float) var attack_cooldown

var can_deal_damaga: bool = true

func _physics_process(_delta: float) -> void:
	if player_ref == null:
		return
		
	move()
	velocity = move_and_slide(velocity)
	verify_orientation()

func move() -> void:
	var x_distance: float = player_ref.global_position.x - global_position.x
	var x_direction: float = sign(x_distance)
	if abs(x_distance) < distance_threshold and can_deal_damaga:
		player_ref.update_health(enemy_damage)
		attack_timer.start(attack_cooldown)
		can_deal_damaga = false
		velocity.x = 0
	if abs(x_distance) > distance_threshold:
		velocity.x = x_direction * move_speed

func update_health(value: int) -> void:
	health -= value
	if health <= 0:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null


func _on_timeout() -> void:
	can_deal_damaga = true

func verify_orientation() -> void:
	if velocity.x > 0:
		sprite.flip_h = true
	if velocity.x < 0:
		sprite.flip_h = false	
