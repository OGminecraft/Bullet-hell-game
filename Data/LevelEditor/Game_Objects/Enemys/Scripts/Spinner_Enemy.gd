extends StaticBody2D#KinematicBody2D

var can_shoot = true
var rotate_now = true
var rotation_cur = 2
const BULLET_PATH = preload("res://Data/LevelEditor/Game_Objects/Enemys/Spinner_Enemy.bullet.tscn")
export var health = 100

func _process(delta):
	create_bullet()
	_rotate()

#func _physics_process(delta):
#	var collision_info = move_and_collide(Vector2.ZERO)
#	if collision_info != null:
#		print(collision_info.collider.name)
#		if "Player_Bullet" in collision_info.collider.name:
#			print("zomp")

func _rotate():
	get_node("bullet_positions").rotate(0.1)

func create_bullet():
	if can_shoot == true:
		for x in range(4):
			x+=1
			var bullet =BULLET_PATH.instance()
			get_parent().add_child(bullet)
			bullet.position = get_node("bullet_positions/B_spawn_"+ str(x)).global_position
			bullet.velocity = get_node("bullet_positions/B_target_"+ str(x)).global_position - bullet.position
	else:return
	can_shoot = false
	var shot_speed = get_node("shot_timer")
	shot_speed.start()

func _on_shot_timer_timeout():
	can_shoot = true

func _on_rotation_timer_timeout():
	rotate_now = true

func _on_Player_dead():
	queue_free()
