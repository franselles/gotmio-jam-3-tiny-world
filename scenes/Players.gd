extends Node

var inputs_tiki = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

var inputs_toko = {"right": Vector2.LEFT,
			"left": Vector2.RIGHT,
			"up": Vector2.DOWN,
			"down": Vector2.UP}	

var tile_size = 48

onready var tiki = get_node('Tiki')
onready var toko = get_node('Toko')
onready var tikiRay = get_node('Tiki/RayCast2D')
onready var tokoRay = get_node('Toko/RayCast2D')
onready var tikiAnim = get_node('Tiki/AnimationPlayer')
onready var tokoAnim = get_node('Toko/AnimationPlayer')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event) -> void:
	tokoAnim.play('idle')
	tikiAnim.play('idle')
	
	for dir in inputs_tiki.keys():
		if event.is_action_pressed(dir):
			tikiRay.cast_to = inputs_tiki[dir] * tile_size
			tikiRay.force_raycast_update()
			tokoRay.cast_to = inputs_toko[dir] * tile_size
			tokoRay.force_raycast_update()
			
			if !tikiRay.is_colliding() and !tokoRay.is_colliding():
				tiki.move_tween(inputs_tiki[dir])
				toko.move_tween(inputs_toko[dir])
				
	if tokoRay.is_colliding():	
		if tokoRay.get_collider().name == "Tiki":
			var level = int(get_tree().get_root().get_child(0).get_name())
			level = level + 1
			if level < 4:
				get_tree().change_scene("res://scenes/Level_" + str(level) + ".tscn")
				
	if tikiRay.is_colliding():	
		if tikiRay.get_collider().name == "Toko":
			var level = int(get_tree().get_root().get_child(0).get_name())
			level = level + 1
			if level < 5:
				get_tree().change_scene("res://scenes/NextLevel_" + str(level) + ".tscn")				

