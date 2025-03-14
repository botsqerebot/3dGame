extends Control

@onready var inv: Inventory = preload("res://Inventory/player_inventory.tres")
@onready var slots = $NinePatchRect/Pocket.get_children()
@onready var backpack = InvSlot
@onready var armor = $NinePatchRect/Armor.get_children()
@onready var blots = "res://Inventory/player_inventory.tres"
var is_open = false

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	close()

#func _get_drag_data(at_position):
	#var dragSlotNode = get_slot_node_at_position(at_position)
	#print("drag start")
	#if dragSlotNode.texture == null: return
	#print("has texture")
	#var dragPreviewNode = dragSlotNode.duplicate()
	##dragPreviewNode.custom_minimum_size = Vector2(60, 60)
	#set_drag_preview(dragPreviewNode)
#
#func _can_drop_data(at_position, data):
	#var targetSlotNode = get_slot_node_at_position(at_position)
	#
	#return targetSlotNode != null
#
#func _drop_data(at_position, dragSlotNode):
	#var targetSlotNode = get_slot_node_at_position(at_position)
	#var targetTexture = targetSlotNode.texture
	#
	#targetSlotNode.texture = dragSlotNode.texture
	#
	#if targetTexture == null:
		#dragSlotNode.texture = null
	#else: 
		#dragSlotNode.texture = targetTexture
#
#func get_slot_node_at_position(position):
	#var allSlotNodes = (backpack.get_children() + armor.get_children())
	#
	#for node in allSlotNodes:
		#var nodeRect = node.get_global_rect()
		#
		#if nodeRect.has_point(position): return node
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close():
	visible = false
	is_open = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
