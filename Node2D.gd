tool
extends Node2D

enum State {DIE, RUN}

var test

func _get_property_list() -> Array:
	var e = AdvExp.new()
	e.enum("test", State)
	return e.properties
