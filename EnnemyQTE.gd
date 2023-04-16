extends Area2D

var transi = false
var coordChange = 0
var i = 0
var listOfSprite = ["res://assets/gauche.png","res://assets/droite.png","res://assets/haut.png","res://assets/bas.png"]
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


func animCamera(player : CharacterBody2D):
	print('animation !')
	var camera = get_node("../Camera2D")
	# Appliquer le zoom
	var anim = get_node("../Camera2D/AnimationPlayer")
	anim.play("cameraTransition")
	await get_tree().create_timer(1.5).timeout
	run_QTE()

func run_QTE():
	print('QTE')
	var QTE_sprite = get_node("QTE")
	var rng = RandomNumberGenerator.new()
	var rand = rng.randf_range(0,3)
	var texture = load(listOfSprite[rand])

	QTE_sprite.texture = texture
	QTE_sprite.scale.x = 2
	QTE_sprite.scale.y = 2

func _on_body_entered(body):
	if body.is_in_group("Player"):
		transi = true
		var camera = get_node("../Camera2D")
		coordChange = (camera.position - body.position) / 10
		animCamera(body) # Replace with function body.
		body.speed = 0 #arrete le joueur pour le QTE

