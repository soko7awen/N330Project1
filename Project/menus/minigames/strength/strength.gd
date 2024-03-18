extends Control
var started = false
var just_started = false
var caller = null
var level = 2
var ticks = 0
var enemy_slowness = 10
var enemy_speed = 20
var player_strength = 200
var space_presses = []
signal ended(node,caller,winlose,score)

func _ready():
	if level == 2:
		enemy_slowness = 12
		enemy_speed = 30
		player_strength = 360
		$Hands/ArmEnemy.texture = load("res://menus/minigames/strength/minigame-arm-jester-4.png")

func _process(delta):
	if started:
		if just_started:
			$Hands.position.x -= player_strength * delta
			$Hands/AnimationPlayer.play("shake")
			just_started = false
		if $Hands.position.x >= 300:
			print('lose')
			ended.emit(self,caller,'lose',-1)
		elif $Hands.position.x <= -300:
			print('win')
			ended.emit(self,caller,'win',1)
		if Input.is_action_just_pressed("move_jump"):
			space_presses.append(1)
		if ticks <= enemy_slowness:
			ticks += 60 * delta
		else:
			if space_presses.size() >= level:
				$Hands.position.x -= player_strength * delta
				space_presses = []
			ticks = 0
		$Hands.position.x += enemy_speed*2 * delta
	else:
		if Input.is_action_just_pressed("move_jump"):
			started = true
			just_started = true
