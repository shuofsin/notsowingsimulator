extends Node2D

func _ready() -> void: 
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "global_position:y", global_position.y - 25, 1.0)
	tween.tween_property(self, "modulate:a", 0, 1.0)
	tween.finished.connect(queue_free)
