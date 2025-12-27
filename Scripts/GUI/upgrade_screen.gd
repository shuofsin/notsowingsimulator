extends CanvasLayer

@onready var swing_button: Button = %SwingButton
@onready var swing_label: Label = %SwingLabel
@onready var tool_button: Button = %ToolButton
@onready var tool_label: Label = %ToolLabel
@onready var speed_button: Button = %SpeedButton
@onready var speed_label: Label = %SpeedLabel
@onready var damage_button: Button = %DamageButton
@onready var damage_label: Label = %DamageLabel
@onready var score_label: Label = %ScoreLabel


var swing_cost: float = 5.0
var tool_cost: float = 5.0
var speed_cost: float = 5.0
var damage_cost: float = 5.0

func _ready() -> void:
	visible = false 
	swing_button.pressed.connect(_swing_press)
	tool_button.pressed.connect(_tool_press)
	speed_button.pressed.connect(_speed_press)
	damage_button.pressed.connect(_damage_press)

func _process(_delta: float) -> void: 
	if Global.state == "menu":
		visible = true
	if Global.state == "game":
		visible = false
	
	swing_label.text = "x" + str(Global.player.stats.swing_speed) + "(" + str(swing_cost) + ")"
	tool_label.text = "x" + str(Global.player.stats.tool_scale) + "(" + str(tool_cost) + ")"
	speed_label.text = "x" + str(Global.player.stats.speed) + "(" + str(speed_cost) + ")"
	damage_label.text = "x" + str(Global.player.stats.tool_damage) + "(" + str(damage_cost) + ")"
	
	score_label.text = "Score: " + str(Global.score)

	pass

func _swing_press() -> void: 
	if Global.score >= swing_cost: 
		Global.player.stats.swing_speed += 0.1
		Global.score -= swing_cost
		swing_cost *= 1.1

func _tool_press() -> void: 
	if Global.score >= tool_cost: 
		Global.player.stats.tool_scale += 0.1
		Global.score -= tool_cost
		tool_cost *= 1.1

func _speed_press() -> void:
	if Global.score >= speed_cost: 
		Global.player.stats.speed += 0.1
		Global.score -= speed_cost
		speed_cost *= 1.1

func _damage_press() -> void: 
	if Global.score >= damage_cost: 
		Global.player.stats.tool_damage += 0.1
		Global.score -= damage_cost
		damage_cost *= 1.1
