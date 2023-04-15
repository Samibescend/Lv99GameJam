extends Area2D


func _ready():
	pass

func _physics_process(delta):
	pass


func run_QTG():
	print('QTG !')




func _on_body_entered(body):
	if body.is_in_group("Player"):
		run_QTG() # Replace with function body.
		body.speed = 0 #arrete le joueur pour le QTG
