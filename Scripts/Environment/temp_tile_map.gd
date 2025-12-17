extends TileMapLayer


func _ready() -> void: 
	var block_scene: PackedScene = preload("res://Scenes/Environment/temp_block.tscn")
	for pos in self.get_used_cells():
		print(self.map_to_local(pos))
		var new_block: Node2D = block_scene.instantiate()
		new_block.global_position = self.map_to_local(pos)
		get_parent().add_child.call_deferred(new_block)
	visible = false
	pass
