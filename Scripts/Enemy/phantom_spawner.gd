extends Node2D

var spawn_timer: float
var time_between_spawns: float = 4.0
var phantom: PackedScene = preload("res://Scenes/Enemy/temp_phantom.tscn")
var viewport_size: Vector2 = Vector2(640, 360)
enum SIDES {LEFT, RIGHT, DOWN, UP}

func _ready() -> void: 
	Global.spawner = self
	spawn_timer = time_between_spawns

func _physics_process(delta: float) -> void:
	spawn_timer -= delta
	if Global.player && spawn_timer <= 0: 
		var new_phantom: Phantom = phantom.instantiate()
		var extents: Dictionary = {
			"left": Global.player.global_position.x - viewport_size.x / 2,
			"right": Global.player.global_position.x + viewport_size.x / 2,
			"up": Global.player.global_position.y - viewport_size.y / 2,
			"down": Global.player.global_position.y + viewport_size.y / 2
		}
		var side = SIDES.values().pick_random()
		if side == SIDES.LEFT:
			var new_y: float = randf_range(extents.up, extents.down)
			new_phantom.global_position = Vector2(extents.left - 16, new_y)
		elif side == SIDES.RIGHT:
			var new_y: float = randf_range(extents.up, extents.down)
			new_phantom.global_position = Vector2(extents.right + 16, new_y)
		elif side == SIDES.UP:
			var new_x: float = randf_range(extents.left, extents.right)
			new_phantom.global_position = Vector2(new_x, extents.up - 16)
		elif side == SIDES.DOWN:
			var new_x: float = randf_range(extents.left, extents.right)
			new_phantom.global_position = Vector2(new_x, extents.down + 16)
		get_parent().add_child(new_phantom)
		spawn_timer = time_between_spawns
		time_between_spawns = time_between_spawns * 0.99
