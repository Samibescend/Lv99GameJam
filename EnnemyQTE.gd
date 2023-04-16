extends Area2D

var transi = false
var coordChange = 0
var i = 0

func _ready():
	pass


func _physics_process(delta):
	pass


func _process(delta):
	if transi:
		var camera = get_node("../Camera2D")
		camera.position -= coordChange
		i += 1
		if i >= 10:
			transi = false
	pass


func run_QTE(player : CharacterBody2D):
	print('QTE !')
	var camera = get_node("../Camera2D")
	# Appliquer le zoom
	var anim = get_node("../Camera2D/AnimationPlayer")
	anim.play("cameraTransition")


func _on_body_entered(body):
	if body.is_in_group("Player"):
		transi = true
		var camera = get_node("../Camera2D")
		coordChange = (camera.position - body.position) / 10
		run_QTE(body) # Replace with function body.
		body.speed = 0 #arrete le joueur pour le QTG

