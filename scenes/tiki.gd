extends Area2D

var tile_size = 48

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}
var speed = 4

onready var tween = $Tween
onready var ray = $RayCast2D

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

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

