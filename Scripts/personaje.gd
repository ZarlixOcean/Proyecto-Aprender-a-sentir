extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -320.0

@onready var anim = $Sprite2D
@onready var camera = $Camera2D

func _ready():
	add_to_group("Personaje")
	if camera:
		camera.global_position.x = global_position.x
		camera.global_position.y = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if not is_on_floor() and velocity.y < 0:
		anim.play("saltar")
	elif direction != 0:
		anim.play("caminar")
	else:
		anim.play("respirar")
	
	if camera:
		camera.global_position.x = global_position.x
		camera.global_position.y = -130
