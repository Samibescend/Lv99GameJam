extends Area2D

var QTE = false
var transi = false
var coordChange = 0
var i = 0
var player 
var listOfSprite = ["res://assets/gauche.png","res://assets/droite.png","res://assets/haut.png","res://assets/bas.png"]
var listOfInput = ["left","right","up","down"]
var camera
var rng = RandomNumberGenerator.new()
var j = 0
var rand 
func _ready():
	camera = get_node("../Camera2D")
	player = get_node("../Player")

func _physics_process(delta):
	pass


func _process(delta):
	#travelling vers le joueur
	if transi:
		camera.position -= coordChange
		i += 1
		if i >= 10:
			transi = false
	if QTE:
		if Input.is_action_just_pressed(listOfInput[rand]):
			QTE = false
			$TimerQTE.stop()
			print('reussi')
			j+=1
			if j < 3:
				createQTE()
			if j == 3: 
				player.speed = 400
				camera.zoom.x = 1
				camera.zoom.y = 1
				queue_free()
	pass

func animCamera(player : CharacterBody2D):
	print('animation !')
	# Appliquer le zoom
	var anim = camera.get_child(0)
	anim.play("cameraTransition")

func run_QTE():
	print('QTE')
	createQTE()
		

func createQTE():
	var QTE_sprite = get_node("QTE")
	rand = rng.randf_range(0,3)
	QTE_sprite.texture = load(listOfSprite[rand])
	QTE_sprite.scale.x = 2
	QTE_sprite.scale.y = 2
	QTE = true
	$TimerQTE.start()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		transi = true
		coordChange = (camera.position - body.position) / 10
		animCamera(body) # Replace with function body.
		body.speed = 0 #arrete le joueur pour le QTE
		await get_tree().create_timer(1.5).timeout
		run_QTE()
		


func _on_timer_qte_timeout():
	print('fail')
	pass # Replace with function body.
