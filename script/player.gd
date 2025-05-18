extends CharacterBody2D

var speed = 100
var player_state

@export var ivn: Ivn

var bow_equiped = false
var bow_cooldown = true
var arrow =  preload("res://scene/arrow.tscn")

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
	
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("e"):
		if bow_equiped:
			bow_equiped = false
		else:
			bow_equiped = true
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	
	play_anim(direction)
	
func play_anim(dir):

	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("ne_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw_walk")

func player():
	pass

func collect(item):
	ivn.insert(item)
