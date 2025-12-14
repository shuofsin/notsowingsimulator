extends CharacterBody2D
class_name Player

var speed: float = 100.0
@onready var collision_polygon_2d: CollisionPolygon2D = %CollisionPolygon2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _process(delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
