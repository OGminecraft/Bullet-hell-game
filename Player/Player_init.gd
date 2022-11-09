extends KinematicBody2D

#Initialize Consts
const BULLET_PATH = preload("res://Player/Guns/Player_Bullet_1.tscn")
const DEATH_SCREEN = preload("res://Data/UI/death_screen.tscn")
const MAX_SPEED = 400
const ACCELERATION = 800
const MAX_ROTATION_SPEED = 5
const FRICTION = 810

#Initialize vars
var velocity = Vector2.ZERO
var coins = 0
var can_shoot = true
var can_dash = true
var dash_on_cooldown = false

#Initialize Funcs
func calc_rotate_speed(RS, delta, MRS):
	return (RS * delta * MRS)
