extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var slots = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func _ready() -> void:
	#amount_text.text = str("hello")
	pass

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible= false
	else: 
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)

func _get_drag_data(at_position):
	var dragSlotNode = get_slot_node_at_position(at_position)
	print("drag start", dragSlotNode)
	if dragSlotNode.texture == null: return
	print("has texture")
	var dragPreviewNode = dragSlotNode.duplicate()
	#dragPreviewNode.custom_minimum_size = Vector2(60, 60)
	set_drag_preview(dragPreviewNode)

func _can_drop_data(at_position, data):
	var targetSlotNode = get_slot_node_at_position(at_position)
	
	return targetSlotNode != null

func _drop_data(at_position, dragSlotNode):
	var targetSlotNode = get_slot_node_at_position(at_position)
	var targetTexture = targetSlotNode.texture
	
	targetSlotNode.texture = dragSlotNode.texture
	
	if targetTexture == null:
		dragSlotNode.texture = null
	else: 
		dragSlotNode.texture = targetTexture

func get_slot_node_at_position(position):
	var allSlotNodes = (slots.get_children() + slots.get_children())
	
	for node in allSlotNodes:
		var nodeRect = node.get_global_rect()
		
		if nodeRect.has_point(position): return node
