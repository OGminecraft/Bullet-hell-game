extends "res://Player/Player_init.gd"

#Initialize exports
export var fire_rate = 0.08#secs
export var dash_cooldown = 5#secs
export var health = 100
export var max_health = 100
export var rotation_speed = 1.3
export var coins_per_coin = 1

#create signals
signal dead

#Key Binds so the player can interact with the player
func _physics_process(delta):
	#Movement/Player Rotation
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
		
	if Input.is_action_pressed("rotate_right"):
		rotate(calc_rotate_speed(rotation_speed, delta, MAX_ROTATION_SPEED))
	if Input.is_action_pressed("rotate_left"):
		rotate(-calc_rotate_speed(rotation_speed, delta, MAX_ROTATION_SPEED))
	if Input.is_action_pressed("shoot"):
		create_bullet()
	
	if Input.is_action_just_pressed("dash") and can_dash == true and dash_on_cooldown == false:
		print("dash")
		_play_dash_effect()
		move_local_x($Target.position.x)
		move_local_y($Target.position.y)
		dash_on_cooldown = true
		$dash_cooldown.start(dash_cooldown)
	
	if health <= 0:
		emit_signal("dead")
		queue_free()#player_dead = true
		
#Collision Detection between pickups and enemys (might redo later)
func _on_Hitbox_area_entered(area):
	#pickupable code
	if area.name == "Coin_Hurtbox":
		print(area)
		coins += coins_per_coin
		print(coins)
	if area.name == "Health_Pickup_Hurtbox":
		if health + (health/2) > max_health:
			health = max_health
		else:
			health += health / 2
		print(health)
	
	#enemy code
	if area.name == "DvD_Enemy_Hitbox":
		health -= 25
		print(health)
	if area.name == "Spinner_bullet_hitbox":
		health -= 25
		print(health)
		
#So the player can shoot bullets	
func create_bullet():
	if can_shoot == true:
		var bullet =BULLET_PATH.instance()
			
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
			
		bullet.velocity = $Target.global_position - bullet.position
	else:return
	can_shoot = false
	$shot_speed.start(fire_rate)
	
#So the player dosent shoot hundreds of bullets a second
func _on_shot_speed_timeout():
	can_shoot = true

func _play_dash_effect():
	pass

func _on_dash_check_area_area_entered(_area):
	can_dash = false
func _on_dash_check_area_area_exited(_area):
	can_dash = true
func _on_dash_check_area_body_entered(_body):
	can_dash = false
func _on_dash_check_area_body_exited(_body):
	can_dash = true
func _on_dash_cooldown_timeout():
	dash_on_cooldown = false
