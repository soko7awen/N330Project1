extends Control
var level = 2
var ticks = 0
var enemy_slowness = 12
var player_strength = 1000
var space_presses = []
signal ended(node)

func _ready():
	if level == 2:
		enemy_slowness = 24
		$Hands/ArmEnemy.texture = load("res://menus/minigames/strength/minigame-arm-jester-4.png")

func _process(delta):
	if $Hands.position.x >= 300:
		print('lose')
	elif $Hands.position.x <= -300:
		print('win')
		ended.emit(self)
	if Input.is_action_just_pressed("move_jump"):
		space_presses.append(1)
	if ticks == enemy_slowness/2-4:
		$Hands.position.x -= 3
	if ticks == enemy_slowness/2:
		$Hands.position.x += 3
	if ticks == enemy_slowness/2+4:
		$Hands.position.x -= 3
	if ticks <= enemy_slowness:
		ticks += 1
	else:
		if space_presses.size() >= level:
			$Hands.position.x -= player_strength * delta
			space_presses = []
		ticks = 0
	$Hands.position.x += 50 * delta
