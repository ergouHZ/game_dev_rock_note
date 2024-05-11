extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("up"):
		Dialogic.start("res://dialog/timeline/timeline1.dtl")
	var playerSprite:AnimatedSprite2D =$playerSprite
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		playerSprite.play("left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		playerSprite.stop()
	move_and_slide()
