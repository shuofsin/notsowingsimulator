extends Area2D
class_name Phantom

@onready var health_component: HealthComponent = %HealthComponent
var speed: float = 50

func _ready() -> void: 
	body_entered.connect(_body_has_entered)

func _physics_process(delta: float) -> void:
	if Global.player:
		var direction_to_player: Vector2 = global_position.direction_to(Global.player.global_position)
		var velocity = direction_to_player * speed
		position += velocity * delta
	
	if health_component.health <= 0:
		queue_free()

func _body_has_entered(_body_entered: Node2D):
	if _body_entered is Player:
		Global.score = floor(Global.score / 2)
		queue_free()
