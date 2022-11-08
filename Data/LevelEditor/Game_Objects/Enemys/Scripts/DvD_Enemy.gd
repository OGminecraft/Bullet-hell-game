extends KinematicBody2D

export var velocity = Vector2(50,50)
var collision =null

func _physics_process(delta):
	collision =move_and_collide(velocity * delta)
	if collision != null:# and "spinner" not in collision.collider.name:
		if rand_range(-8,8) < 0:
			velocity.x *= -1
		else:velocity.y *= -1


func _on_Player_dead():
	queue_free()
