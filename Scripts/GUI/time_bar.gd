extends CanvasLayer

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@export var total_time: float = 2

func _ready() -> void:
	timer.start(total_time)
	timer.timeout.connect(_switch_state)

func _physics_process(_delta: float) -> void:
	progress_bar.value = (timer.time_left / timer.wait_time) * 100

func _reset_scene() -> void: 
	Global.score = 0
	get_tree().reload_current_scene()

func _switch_state() -> void: 
	if Global.state == "game":
		Global.player.set_physics_process(false)
		Global.player.set_process(false)
		Global.spawner.set_physics_process(false)
		Global.state = "menu"
		Global.score -= Global.quota
		if Global.score <= 0:
			get_tree().quit()
		_clear_phantoms()
		timer.start(total_time)
		return 
	if Global.state == "menu":
		Global.player.set_physics_process(true)
		Global.player.set_process(true)
		Global.spawner.set_physics_process(true)
		Global.spawner.time_between_spawns *= 0.95
		Global.map.block_health = int(Global.map.block_health * 1.2)
		Global.quota *= 1.2
		Global.phantom_health = int(Global.phantom_health * 1.2)
		Global.state = "game"
		timer.start(total_time)
		return 

func _clear_phantoms() -> void:
	for child in get_parent().get_children():
		if child is Phantom:
			print("phantoms_cleared")
			child.queue_free()
