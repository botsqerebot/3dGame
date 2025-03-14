extends RigidBody3D

@export var item: InvItem

var player = null  
var player_in_area = false

var max_pickups = 5


func _process(_delta: float) -> void:
	if max_pickups == 0:
		$".".queue_free()
	if player_in_area:
		#print("entered")
		if Input.is_action_just_pressed("e") and max_pickups > 0:
			print("picked up item")
			player.collect(item)
			max_pickups -= 1
			$MeshInstance3D.scale *= 0.8
			#$RigidBody3D.scale *= 0.8
			$CollisionShape3D.scale *= 0.8
			$Area3D/CollisionShape3D.scale *= 1.2

func _on_area_3d_body_entered(body) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body
		print("entered v2")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		player_in_area = false
