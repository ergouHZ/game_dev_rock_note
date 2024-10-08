extends CharacterBody2D
@onready var transition_rect = $TransitionColorRect 
@export var SPEED: int = 250
var timer = 0 # 计时器
const STOP_MOVEMENT_THRESHOLD = 20 # 开始计时的速度阈值
var is_animation_paused = false  # 新增的布尔变量，用于判断动画暂停的瞬间
var is_in_conversation = false # 用于判断角色是否在对话中，如果是的话，不能操作

func _ready():
	
	
	
	if Global.player_direction != "" :
		$playerSprite.play(Global.player_direction)
		$playerSprite.stop()
	
	Dialogic.timeline_started.connect(start_dialog) #获取对话开始信号并传递至函数
	

func _process(delta):
	var input_direction = Vector2.ZERO #获取输入的向量
	var playerSprite: AnimatedSprite2D = $playerSprite
	var interactArea: Area2D = $interactArea_Dialog
	
	
	
	#当玩家处于对话外的时候才能操作
	if not is_in_conversation and Global.player_is_movable:
		# 获取用户输入 并播放对应方向动画
		if Input.is_action_pressed("up"):
			input_direction.y -= 1
			Global.player_direction = "up" #处理进入房间后的朝向
		elif Input.is_action_pressed("down"):
			input_direction.y += 1
			Global.player_direction = "down"
		if Input.is_action_pressed("left"):
			input_direction.x -= 1
			Global.player_direction = "left"
		elif Input.is_action_pressed("right"):
			input_direction.x += 1
			Global.player_direction = "right"

		# 处理动画
		if input_direction != Vector2.ZERO:
			is_animation_paused = false  # 重置暂停标记
			timer = 0 # 停止的时候开始计时
			match input_direction:
				#每一个判断设置播放的动画以及互动的区域
				Vector2( - 1, 0):
					playerSprite.play("left")
					interactArea.position.x=-40 
					interactArea.position.y=0
					interactArea.rotation=0
				Vector2(1, 0):
					playerSprite.play("right")
					interactArea.position.x=40
					interactArea.position.y=0
					interactArea.rotation=0
				Vector2(0, -1):
					playerSprite.play("up")
					interactArea.position.x=0
					interactArea.position.y=-40
					interactArea.rotation=deg_to_rad(90)
				Vector2(0, 1):
					playerSprite.play("down")
					interactArea.position.x=0
					interactArea.position.y=40
					interactArea.rotation=deg_to_rad(90)
				_:
					# 对角线移动的情况
					playerSprite.play("left" if input_direction.x < 0 else "right")
		else:
			if not is_animation_paused:
				is_animation_paused = true #切换动画暂停播放的状态，只暂停一次
				playerSprite.stop()

		# 应用速度
		velocity = input_direction.normalized() * SPEED
		
		# 如果玩家的速度低于阈值,开始计时
		if velocity.length() < STOP_MOVEMENT_THRESHOLD:
			timer += delta
		#print(timer)
		if timer >= 8:
			# 时间到的时候播放待机动画
			playerSprite.play("idle")
		move_and_slide()
	else:
		playerSprite.stop()
		
		
func start_dialog():
	is_in_conversation = true #在对话中 无法操作
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	print("dialog started！")

func _on_timeline_ended():
	is_in_conversation = false #在对话中 无法操作
	print("dialog ended!")
	#结束时取消信号链接，并发送对话结束的信号
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	# do something else here
	


