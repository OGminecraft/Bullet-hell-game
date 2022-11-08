extends KinematicBody2D

#Initialize exports
export var rotation_speed = 0
export var coins_per_coin = 1
export var health = 100
export var max_health = 100

#Initialize vars
var velocity = Vector2.ZERO
var coins = 0
var can_shoot = true

#Initialize Consts
const MAX_SPEED = 400
const ACCELERATION = 800
const MAX_ROTATION_SPEED = 5
const FRICTION = 810
const BULLET_PATH = preload("res://Player/Guns/Player_Bullet_1.tscn")
const DEATH_SCREEN = preload("res://Data/UI/death_screen.tscn")

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
		print(rotation_degrees)
	if Input.is_action_pressed("rotate_left"):
		rotate(-calc_rotate_speed(rotation_speed, delta, MAX_ROTATION_SPEED))
		print(rotation_degrees)
		
	if Input.is_action_pressed("shoot"):
		print(rotation_degrees)
		create_bullet()
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

func calc_rotate_speed(RS, delta, MRS):
	return (RS * delta * MRS)
	
	
#So the player can shoot bullets	
func create_bullet():
	if can_shoot == true:
		var bullet =BULLET_PATH.instance()
			
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
			
		bullet.velocity = $Target.global_position - bullet.position
	else:return
	can_shoot = false
	var shot_speed = get_node("shot_speed")
	shot_speed.start()
#So the player dosent shoot hundreds of bullets a second
func _on_shot_speed_timeout():
	can_shoot = true
