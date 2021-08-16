extends Area2D

var tile_size = 48

var inputs = {"right": Vector2.LEFT,
			"left": Vector2.RIGHT,
			"up": Vector2.DOWN,
			"down": Vector2.UP}
var speed = 4

onready var tween = $Tween
onready var ray = $RayCast2D

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	$AnimationPlayer.play('idle')

func move_tween(dir) -> void:
	if tween.is_active():
		return
		
	if dir.x == -1:
		$AnimationPlayer.play('left')
	elif dir.x == 1:
		$AnimationPlayer.play('right')
	elif dir.y == -1:
		$AnimationPlayer.play('up')
	elif dir.y == 1:
		$AnimationPlayer.play('down')
		
	tween.interpolate_property(self, "position",
		position, position + dir * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
