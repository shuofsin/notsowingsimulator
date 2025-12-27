extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var quota_label: Label = %QuotaLabel

func _process(_delta: float) -> void:
	score_label.text = "Score: " + ("%0.1f" % Global.score); 
	quota_label.text = "Quota: " + ("%0.1f" % Global.quota);
	
	if Global.state == "menu":
		visible = false
	else: 
		visible = true
