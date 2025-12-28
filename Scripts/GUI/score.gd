extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var quota_label: Label = %QuotaLabel
@onready var score_bar: ProgressBar = %ScoreBar
@onready var score_quota_label: Label = %ScoreQuotaLabel

func _process(_delta: float) -> void:
	score_label.text = "Score: " + ("%0.1f" % Global.score); 
	quota_label.text = "Quota: " + ("%0.1f" % Global.quota);
	
	score_bar.max_value = Global.quota 
	score_bar.value = Global.score if Global.score < Global.quota else Global.quota
	
	if Global.score >= Global.quota:
		score_quota_label.text = "Score exceeding quota!"
	else:
		score_quota_label.text = "Score " + str(Global.quota - Global.score) + " less than Quota!"
	
	if Global.state == "menu":
		visible = false
	else: 
		visible = true
