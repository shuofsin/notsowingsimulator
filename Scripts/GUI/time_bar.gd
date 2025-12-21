extends CanvasLayer

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@export var total_time: float = 10

func _ready() -> void:
	timer.start(total_time)
	timer.timeout.connect(_reset_scene)

func _physics_process(_delta: float) -> void:
	progress_bar.value = (timer.time_left / timer.wait_time) * 100

func _reset_scene() -> void: 
	Global.score = 0
	get_tree().reload_current_scene()
