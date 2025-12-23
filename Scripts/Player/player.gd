extends CharacterBody2D
class_name Player


var base_stats: Dictionary = {
	"speed" : 50.0,
	"swing_time" : 0.4,
	"tool_scale" : 1.0
}

var speed: float = base_stats.speed
var total_swing_time: float = base_stats.swing_time
var swing_number: int = 0 
var MAX_SWINGS: int = 3
var is_swinging: bool = false
var swing_reset_timer: float
var SWING_RESET_TIME: float = 0.2
@onready var hitbox_small: HitboxComponent = %HitboxSmall
@onready var tool_sprite: Sprite2D = %ToolSprite
@onready var sounds: AudioStreamPlayer2D = %Sounds

func _ready() -> void: 
	Global.player = self
	speed = base_stats.speed
	total_swing_time = base_stats.swing_time
	hitbox_small.scale = Vector2(base_stats.tool_scale, base_stats.tool_scale)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("use") and !is_swinging:
		_swing()
	
	if Input.is_action_just_pressed("1"):
		speed *= 1.2
	
	if Input.is_action_just_pressed("2"):
		total_swing_time *= 0.8
	
	if Input.is_action_just_pressed("3"):
		hitbox_small.scale *= 1.2

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

	swing_reset_timer -= delta
	if !is_swinging && swing_reset_timer <= 0: 
		swing_number = 0

	move_and_slide()

func _swing() -> void: 
	swing_number += 1
	hitbox_small.rotation = global_position.direction_to(get_global_mouse_position()).angle() - (PI/4 * (-1 if swing_number % 2 == 0 else 1))
	hitbox_small.disable(false)
	tool_sprite.visible = true
	if swing_number % 2 == 0: 
		tool_sprite.flip_v = true 
	else: 
		tool_sprite.flip_v = false 

	is_swinging = true
	var swing_tween = create_tween()
	swing_tween.finished.connect(_stop_swinging)
	sounds.play()
	if swing_number % 3 == 0: 
		swing_tween.tween_property(hitbox_small, "rotation", hitbox_small.rotation + 2*PI, total_swing_time * 1.5)
		return 
	swing_tween.tween_property(hitbox_small, "rotation", hitbox_small.rotation + (PI/2 * (-1 if swing_number % 2 == 0 else 1)), total_swing_time)

func _stop_swinging() -> void: 
	hitbox_small.disable()
	tool_sprite.visible = false 
	is_swinging = false
	swing_reset_timer = SWING_RESET_TIME 
