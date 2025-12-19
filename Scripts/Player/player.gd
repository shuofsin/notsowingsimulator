extends CharacterBody2D
class_name Player

var speed: float = 100.0
var TOTAL_SWING_TIME: float = 0.3
var swing_timer: float
var is_swinging: bool = false
@onready var hitbox_small: HitboxComponent = %HitboxSmall
@onready var tool_sprite: Sprite2D = %ToolSprite


func _process(_delta: float) -> void:
	if !is_swinging: hitbox_small.rotation = global_position.direction_to(get_global_mouse_position()).angle()
	tool_sprite.visible = is_swinging
	if Input.is_action_just_pressed("use"):
		hitbox_small.disable(false)
		swing_timer = TOTAL_SWING_TIME
		is_swinging = true 
	
	pass

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	swing_timer -= delta
	if is_swinging && swing_timer <= 0:
		hitbox_small.disable()
		is_swinging = false

	move_and_slide()
