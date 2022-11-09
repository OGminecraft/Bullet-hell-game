extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func create_pickup_collected_effect():
	pass

func _on_Hurtbox_area_entered(area):
	if area.name == "Player_Hitbox":
		create_pickup_collected_effect()
		queue_free()
