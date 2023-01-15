tool
extends Node2D

class Bitch:
	extends Node

var my_bitches := [Bitch.new(), Bitch.new(), Bitch.new()] # you have zero bitches
var inventory := [[1, 2, 3], [4, 5], [6, 7, 8, 9]] # 2D array

func _get_property_list() -> Array:
	return AdvExp.new()\
	.typed_array("inventory", [2, TYPE_INT])\
	.properties
	# .typed_array("my_bitches", [1, TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE, "Resource"])\
