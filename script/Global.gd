extends Node

var player_position = Vector2.ZERO  #全局存储角色坐标
var player_direction = ""
var player_is_movable = true #可否移动

var next_spawn_point = ""  #角色出生标记点，举例：一个大地图可能有多个入口，这个需要记录每次传送
var player_data = {}  # 用于存储玩家的重要数据
