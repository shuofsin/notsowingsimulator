extends TileMapLayer
class_name Map

const WORLD_DENSITY: int = 5
var block_scene: PackedScene = preload("res://Scenes/Environment/temp_block.tscn")
var rock_scene: PackedScene = preload("res://Scenes/Environment/temp_rock.tscn")
var block_health: int = 10;
const ROCK_CHANCE: float = 0.2
var blocks: Dictionary[Vector2i, StaticBody2D]

func _ready() -> void: 
	Global.map = self

func _physics_process(_delta: float) -> void:
	_generate_cells()

func _generate_cells() -> void: 
	# get player cell position
	if !Global.player:
		print("PLAYER NOT FOUND!")
		return
	
	var player_position: Vector2i
	player_position = local_to_map(to_local(Global.player.global_position))
	var camera_extents: Dictionary = {
		"left" : player_position.x - 15,
		"right": player_position.x + 15,
		"top": player_position.y - 10,
		"bottom": player_position.y + 10
	}
	
	var used_cells = get_used_cells()
	for i in range(camera_extents.left, camera_extents.right):
		for j in range(camera_extents.top, camera_extents.bottom):
			var cell_coords = Vector2i(i, j)
			if cell_coords in used_cells:
				continue
			if cell_coords == player_position:
				set_cell(cell_coords, 0, Vector2i(2, 0), 0)
			elif randi_range(0, int(1/ROCK_CHANCE)) == 0:
				set_cell(cell_coords, 0, Vector2i(3, 0), 0)
				var new_rock: StaticBody2D = rock_scene.instantiate()
				new_rock.global_position = to_global(map_to_local(cell_coords))
				blocks.set(cell_coords, new_rock)
				get_parent().add_child.call_deferred(new_rock)
			else:
				set_cell(cell_coords, 0, Vector2i(0, 0), 0)
				var new_block: StaticBody2D = block_scene.instantiate()
				new_block.global_position = to_global(map_to_local(cell_coords))
				new_block.cell_position = cell_coords
				new_block.health = block_health
				blocks.set(cell_coords, new_block)
				get_parent().add_child.call_deferred(new_block)
	for cell in used_cells:
		if !(cell.x < camera_extents.right && cell.x > camera_extents.left && cell.y < camera_extents.bottom && cell.y > camera_extents.top):
			if blocks.get(cell):
				blocks.get(cell).queue_free()
			blocks.erase(cell)
			set_cell(Vector2(cell.x, cell.y), -1, Vector2i(-1, -1), -1)
