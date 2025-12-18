extends TileMapLayer


func _ready() -> void: 
	for i in randi_range(0, 40):
		for j in randi_range(0, 40):
			if randi_range(1, 5)%5 == 0: 
				set_cell(Vector2i(i, j), 0, Vector2i(0, 0), 0)
	
	var block_scene: PackedScene = preload("res://Scenes/Environment/temp_block.tscn")
	for pos in get_used_cells():
		print(map_to_local(pos))
		var new_block: Node2D = block_scene.instantiate()
		new_block.global_position = map_to_local(pos)
		get_parent().add_child.call_deferred(new_block)
	visible = false
	pass
