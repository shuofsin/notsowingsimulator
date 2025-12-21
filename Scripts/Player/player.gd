extends CharacterBody2D
class_name Player

var speed: float = 50.0
var TOTAL_SWING_TIME: float = 0.4
var swing_number: int = 0 
var MAX_SWINGS: int = 3
var is_swinging: bool = false
var swing_reset_timer: float
var SWING_RESET_TIME: float = 0.2
@onready var hitbox_small: HitboxComponent = %HitboxSmall
@onready var tool_sprite: Sprite2D = %ToolSprite


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("use") and !is_swinging:
		_swing()

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
	if swing_number % 3 == 0: 
		swing_tween.tween_property(hitbox_small, "rotation", hitbox_small.rotation + 2*PI, TOTAL_SWING_TIME * 1.5)
		return 
	swing_tween.tween_property(hitbox_small, "rotation", hitbox_small.rotation + (PI/2 * (-1 if swing_number % 2 == 0 else 1)), TOTAL_SWING_TIME)


func _stop_swinging() -> void: 
	hitbox_small.disable()
	tool_sprite.visible = false 
	is_swinging = false
	swing_reset_timer = SWING_RESET_TIME 
