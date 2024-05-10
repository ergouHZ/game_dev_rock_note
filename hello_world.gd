extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#这个会隐藏鼠标
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	print("hello world!")
	pass


var count = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _input(event:InputEvent):
