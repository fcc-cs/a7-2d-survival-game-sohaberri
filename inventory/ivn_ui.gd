extends Control

var is_open = false
 
@onready var ivn = preload("res://inventory/playerivn.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	#ivn.update.connect(update_slots)
	#update_slots()
	#close()
	if ivn.slots.is_empty():
		ivn.slots.resize(slots.size())
		for i in range(ivn.slots.size()):
			ivn.slots[i] = IvnSlot.new()
			
	ivn.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(ivn.slots.size(), slots.size())):
		slots[i].update(ivn.slots[i])

func _process(delta):
	if Input.is_action_just_pressed("i"):
		print("i")
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
