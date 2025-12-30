extends Area2D
class_name Phantom

@onready var health_component: HealthComponent = %HealthComponent
@onready var progress_bar: ProgressBar = %ProgressBar
var speed: float = 45

func _ready() -> void: 
	body_entered.connect(_body_has_entered)
	health_component.MAX_HEALTH = Global.phantom_health
	health_component.health = Global.phantom_health

func _physics_process(delta: float) -> void:
	if Global.player:
		var direction_to_player: Vector2 = global_position.direction_to(Global.player.global_position)
		var velocity = direction_to_player * speed
		position += velocity * delta
	
	progress_bar.value = health_component.health / health_component.MAX_HEALTH * 100
	if health_component.health <= 0:
		queue_free()

func _body_has_entered(_body_entered: Node2D):
	if _body_entered is Player:
		Global.score = floor(Global.score * 0.8)
		queue_free()
