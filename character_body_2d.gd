extends CharacterBody2D

@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var PlayerSound: AudioStreamPlayer = $AudioStreamPlayer
@onready var PlayerSoundResource := PlayerSound.stream

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		PlayerSound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction < 0:
		Sprite.flip_h = true
	if direction > 0:
		Sprite.flip_h = false
	
	SpriteHandler()
	
	move_and_slide()

func SpriteHandler():
	
	if velocity.x != 0:
		Sprite.play("Walk")
	else:
		Sprite.play("Idle")
	
	if velocity.y != 0:
		Sprite.play("Jump")
	
	pass
