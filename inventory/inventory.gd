extends Resource

class_name Ivn

signal update

@export var slots: Array[IvnSlot] = []

func insert(item: IvnItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if not itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
