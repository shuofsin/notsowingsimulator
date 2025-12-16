extends StaticBody2D

@onready var area_2d: Area2D = %Area2D
@onready var points_scene: PackedScene = preload("res://Scenes/GUI/points.tscn")

func _ready() -> void:
	area_2d.area_entered.connect(_entered)
	
func _entered(_area_entered: Area2D):
	var points: Node = points_scene.instantiate() 
	points.global_position = global_position
	get_parent().add_child(points)
	queue_free()
