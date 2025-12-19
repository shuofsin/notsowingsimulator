extends StaticBody2D

@onready var points_scene: PackedScene = preload("res://Scenes/GUI/points.tscn")
@onready var health_component: HealthComponent = %HealthComponent

func _process(_delta: float) -> void:
	if health_component.health <= 0:
		var new_points: Node2D = points_scene.instantiate()
		new_points.global_position = global_position
		get_parent().add_child(new_points)
		Global.score += 1
		queue_free()
