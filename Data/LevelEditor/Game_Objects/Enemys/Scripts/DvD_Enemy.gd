extends KinematicBody2D

export var velocity = Vector2(50,50)
export var health = 100
var collision =null

func _physics_process(delta):
	collision =move_and_collide(velocity * delta)
	if collision != null:# and "spinner" not in collision.collider.name:
		print(collision.collider.name)
		if "Player_Bullet" in collision.collider.name:
			print("DvD was hit")
			health -= 25
		elif rand_range(-8,8) < 0:
			velocity.x *= -1
		else:velocity.y *= -1
	if health <= 0:
		queue_free()

func _on_Player_dead():
	queue_free()
