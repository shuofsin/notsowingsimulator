extends CharacterBody2D
class_name Player

var speed: float = 100.0
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		animation_player.play("Hit")

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
