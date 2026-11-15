extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audios: AudioStreamPlayer2D = $"../Audios"

func _physics_process(delta: float) -> void:
	if (velocity.x < -1 || velocity.x > 1 ):
		if animated_sprite_2d.animation != "default":
			animated_sprite_2d.play("default")
	else:
		if animated_sprite_2d.animation != "default_yes":
			animated_sprite_2d.play("default_yes")
	
	
	
	# Add the gravity.
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var isLeft = velocity.x < 0
	animated_sprite_2d.flip_h = isLeft
	
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	if is_on_wall():
		velocity.y = JUMP_VELOCITY
		

		
