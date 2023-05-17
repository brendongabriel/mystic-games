extends Area2D
class_name Arrow

onready var sprite: Sprite = get_node("Texture")
onready var animation: AnimationPlayer = get_node("Animation")

var direction: int = 1.0

export(int) var speed = 60
export(int) var damage = 10

func _ready() -> void:
	if direction == -1.0:
		sprite.flip_h = true
		
func _physics_process(delta: float) -> void:
	translate(Vector2(delta * direction * speed, 0))

func _on_body_entered(body) -> void:
	if body is Enemy:
		body.update_health(damage)
		queue_free()
		
	if body is TileMap:
		animation.play("stuck")
		set_physics_process(false)


func _on_animation_finished(_anim_name: String) -> void:
	queue_free()


func _on_screen_exited() -> void:
	queue_free()
