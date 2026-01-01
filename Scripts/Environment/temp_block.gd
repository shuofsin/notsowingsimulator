extends StaticBody2D

@onready var points_scene: PackedScene = preload("res://Scenes/GUI/points.tscn")
@onready var health_component: HealthComponent = %HealthComponent
@onready var progress_bar: ProgressBar = %ProgressBar
var cell_position: Vector2 
var health: int

func _ready() -> void: 
	health_component.MAX_HEALTH = health
	health_component.health = health
	
func _process(_delta: float) -> void:
	if health_component.health <= 0:
		var new_points: Node2D = points_scene.instantiate()
		new_points.global_position = global_position
		get_parent().add_child(new_points)
		Global.score += 100
		Global.map.set_cell(cell_position, 0, Vector2i(1, 0), 0)
		queue_free()
	
	progress_bar.visible = (health_component.health != health_component.MAX_HEALTH)
	progress_bar.value = (health_component.health / health_component.MAX_HEALTH * 100)
