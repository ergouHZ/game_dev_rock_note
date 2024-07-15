extends Node

# 定义角色的基础属性
class_name Character

# 属性
var affection: int # 好感度，每个单位10%
var cur_affection : int # 当前格子好感度
var desire: int # 性欲
var perversion: int # 变态
var proficiency: int # 熟练
var initiative: int # 主动

# 构造方法
func _init():
	affection = 0
	cur_affection = 0
	desire = 0
	perversion = 0
	proficiency = 0
	initiative = 0

# 方法来增加属性值
func increase_affection(value: int):
	cur_affection += value
	if(cur_affection >= 100):
		cur_affection -= 100
		affection += 1
	 # 限制在12单位以内
	_check_affection()

func increase_desire(value: int):
	desire = min(desire + value, 100) # 假设满值是100

func increase_perversion(value: int):
	perversion = min(perversion + value, 100) # 假设满值是100

func increase_proficiency(value: int):
	proficiency = min(proficiency + value, 100) # 假设满值是100

func increase_initiative(value: int):
	initiative = min(initiative + value, 100) # 假设满值是100

# 检查好感度是否触发CG
# TODO 之后每个角色需要修改
func _check_affection():
	if affection % 3 == 0 and affection > 0:
		print("CG triggered!")

# 检查是否解锁特定选项
func check_desire_for_action():
	if desire >= 40:
		print("Unlock action")

func check_advanced_attributes():
	if perversion >= 60 and proficiency >= 60 and initiative >= 60:
		print("Character has significant changes.")
	if perversion >= 80 and initiative >= 80:
		print("3P option unlocked")
