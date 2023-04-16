extends Area2D


func _ready():
	pass

func _physics_process(delta):
	pass


func run_QTE(player : CharacterBody2D):
	print('QTE !')
	var camera = get_node("../Camera2D")
	# Appliquer le zoom
	camera.position.x = player.position.x
	camera.position.y = player.position.y
	var anim = get_node("../Camera2D/AnimationPlayer")
	anim.play("cameraTransition")




func _on_body_entered(body):
	if body.is_in_group("Player"):
		run_QTE(body) # Replace with function body.
		body.speed = 0 #arrete le joueur pour le QTG
