extends StaticBody2D

var can_shoot = true
var rotate_now = true
var rotation_cur = 2
const BULLET_PATH = preload("res://Data/LevelEditor/Game_Objects/Enemys/Spinner_Enemy.bullet.tscn")

func _process(delta):
	create_bullet()
	_rotate()

func _rotate():
	get_node("bullet_positions").rotate(0.1)
	"""if rotate_now == true:
		if rotation_cur == 1:
			get_node("bullet_positions").rotate(get_angle_to(Vector2(0,5)))
			rotate_now = false
			get_node("rotation_timer").start()
			rotation_cur = 2
		else:
			get_node("bullet_positions").rotate(get_angle_to($rotation_target.global_position))
			rotate_now = false
			get_node("rotation_timer").start()
			rotation_cur = 1"""

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
