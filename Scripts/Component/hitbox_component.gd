extends Area2D
class_name HitboxComponent

@export var attack: Attack
var collision_shape: CollisionShape2D

func _ready() -> void:
	area_entered.connect(_on_healthbox_area_entered)
	if get_child(0):
		collision_shape = get_child(0)
		disable()

func _on_healthbox_area_entered(area: Area2D) -> void: 
	if area is HealthboxComponent:
		area.damage(attack)

func disable(disabled: bool = true): 
	if collision_shape: 
		collision_shape.disabled = disabled
