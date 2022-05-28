class_name AdvExp, "res://addons/advanced-inspector-exporter/adv_exp.svg"
extends Reference

export var properties: Array

"""

This class is use to make advanced exporting is easier and shorter for people whose normal export keyword is not enough.
Godot Documentation: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#advanced-exports
Requires `tool` keyword in the script file to be use.


Note: This addon might have no need for Godot 4.0 since there's coming a better export keyword

"""

# Extends property hint const that doesn't get documented
enum {
	PROPERTY_HINT_OBJECT_ID=23,
	PROPERTY_HINT_TYPE_STRING,
	PROPERTY_HINT_NODE_PATH_TO_EDITED_NODE,
	PROPERTY_HINT_METHOD_OF_VARIANT_TYPE,
	PROPERTY_HINT_METHOD_OF_BASE_TYPE,
	PROPERTY_HINT_METHOD_OF_INSTANCE,
	PROPERTY_HINT_METHOD_OF_SCRIPT,
	PROPERTY_HINT_PROPERTY_OF_VARIANT_TYPE,
	PROPERTY_HINT_PROPERTY_OF_BASE_TYPE,
	PROPERTY_HINT_PROPERTY_OF_INSTANCE,
	PROPERTY_HINT_PROPERTY_OF_SCRIPT,
	PROPERTY_HINT_OBJECT_TOO_BIG,
	PROPERTY_HINT_NODE_PATH_VALID_TYPES,
}

static func enum2str(enum_dict: Dictionary, include_values: bool = false) -> String:
	var enum_string := ""
	
	if include_values:
		for k in enum_dict:
			enum_string += k.capitalize() + ":" + str(enum_dict[k]) + ","
		enum_string.erase( enum_string.length() - 1, 1 )
	else:
		for k in enum_dict:
			enum_string += k.capitalize() + ","
		enum_string.erase( enum_string.length() - 1, 1 )
	
	return enum_string


# Exporting class or category
#
# Example:
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.catergory("AdvExp")
#		return e.properties
func category(category_name: String):
	self.properties.append({
		"name": category_name,
		"type": TYPE_NIL,
		"usage": PROPERTY_USAGE_CATEGORY
	})


# Exporting group of variables
#
# where hint_string is a front name of each variables that has the front name
#
# Example:
#   var player_name: String
#   var player_velocity: float
#   var player_speed: float 
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.group("Player Variables", "player_")
#       e.default("player_name", TYPE_STRING)
#       e.default("player_velocity", TYPE_REAL)
#       e.default("player_speed", TYPE_REAL)
#      	return e.properties
func group(group_name: String, hint_string := ""):
	self.properties.append({
		"name": group_name,
		"type": TYPE_NIL,
		"hint_string": hint_string,
		"usage": PROPERTY_USAGE_GROUP
	})


# Exporting normal variables
#
# Example:
#   var player_name: String
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.default("player_name", TYPE_STRING)
#      	return e.properties
func default(
		var_name: String, type: int, hint := PROPERTY_HINT_NONE, 
		hint_string := "", extra_usage := 0
):
	self.properties.append({
		"name": var_name,
		"type": type,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE | extra_usage,
		"hint": hint,
		"hint_string": hint_string
	})


# Exporting resource type
#
# Note:
#   You cannot export custom resource with normal `export` keyword, this will later be fix in Godot 4.0.
#   This function might help you in doing so but Godot will return an error saying that resource do not exist but this will works just fine.
#
# Example:
#   var some_resource: SomeResource
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.resource("some_resource", "SomeResource")
#      	return e.properties
func resource(var_name: String, resource_name: String, extra_usage := 0):
	self.properties.append({
		"name": var_name,
		"type": TYPE_OBJECT,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE | extra_usage,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": resource_name
	})


# Exporting enum
#
# Godot analyzer is a little goofy; enum function looks like it's an `enum` keyword but it works like a function just fine.
#
# Example:
#   enum State {IDLE, RUNNING, DIE, HI_MOM}
#   
#   var state: int
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.enum("state", State)
#      	return e.properties
func enum(var_name: String, enum_: Dictionary, extra_usage := 0):
	self.properties.append({
		"name": var_name,
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE | extra_usage,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": enum2str(enum_, true)
	})


# Exporting bit flags
#
# Example:
#   enum Target {
#       SPONGEBOB = 1 << 0,
#       PATRICK = 1 << 1,
#       SQUIDWARD = 1 << 2,
#       SANDY = 1 << 3,
#       LARRY = 1 << 4,
#       PEARL = 1 << 5,
#       MR_KRABS = 1 << 6,
#       PLANKTON = 1 << 7,
#       KAREN = 1 << 8,
#       GARY = 1 << 9,
#       MS_PUFF = 1 << 10,
#       KING_NEPTUNE = 1 << 11,
#   }
#
#   var target_executed: int
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.flags("target_executed", Target)
#      	return e.properties
func flags(var_name: String, enum_flag: Dictionary, extra_usage := 0):
	self.properties.append({
		"name": var_name,
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE | extra_usage,
		"hint": PROPERTY_HINT_FLAGS,
		"hint_string": enum2str(enum_flag)
	})


# Exporting typed array
# 
# The parameter `hint` is kinda advance. I will walk through you by examples
#
#     How it works
#     Export array of type string
#    
#     `export(Array, string) var array: [String]`
#    
#     translated as hint string to "4:"
#     where:
#       4 is `TYPE_STRING`
#
#     As array `[1, TYPE_STRING]`
#     
#    
#     Export array of type int with range 10 to 20 with step 2
#    
#     `export(Array, int, 10, 20, 2) var array`
#    
#     translated as hint string to "2/1:10,17,2"
#     where:
#       first 2 is `TYPE_INT`
#       1 is `PROPERTY_HINT_RANGE`
#       and 10, 17, 2 is the range 10 to 17 with step 2
#
#     As array `[1, TYPE_INT, PROPERTY_HINT_RANGE, 10, 17, 2]`
#     
#    
#     Export array of type resource
#    
#     `export(Array, Resource) var array`
#    
#     translated as hint string to "17/17:Resource"
#     where:
#		first 17 is `TYPE_OBJECT`
#       second 17 is `PROPERTY_HINT_RESOURCE_TYPE`
#       and "Resource" is the name of the resource type
#
#     As array `[1, TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE, "Resource"]`
#    
#    
#     Export 2D array of type dictionary
#     
#     `export(Array, Array, Dictionary)`
#    
#     translated as hint string to "19:18:"
#     where:
#       19 is `TYPE_ARRAY`
#       18 IS `TYPE_DICTIONARY`
#
#     As array `[2, TYPE_DICTIONARY]`
#
#     If 3D it will be "19:19:18:" and as array `[3, TYPE_DICTIONARY]`
# 
#     You get the idea
#     Index 0 is number of array dimension
#     Index 1 is type
#     Index 2 is hint
#     The rest is hint string
#
#
# Example:
#   var my_bitches := [Bitch.new(), Bitch.new(), Bitch.new()] # you have zero bitches
#   var inventory := [[1, 2, 3], [4, 5], [6, 7, 8, 9]] # 2D array
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.typed_array("my_bitches", [1, TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE, "Bitch"])
#       e.typed_array("inventory", [2, TYPE_INT])
#      	return e.properties
func typed_array(var_name: String, hint: Array, extra_usage := 0):
	var hint_string := ""

	assert(hint.size() < 2, "Hint parameter need to have 2 index or more")

	for _i in hint[0] - 1:
		hint_string += "19:"
	
	hint_string += hint[1].to_string()

	if hint.size() == 2:
		hint_string += ":"
	else:
		hint_string += "/" + hint[2].to_string() + ":"

		if hint.size() > 3:
			for i in range(3, hint.size()):
				match typeof(hint[i]):
					TYPE_INT:
						hint_string += hint[i].to_string() + ","
					TYPE_STRING:
						hint_string += hint[i] + ","
					_:
						assert(false, "Hint parameter array can be only int and String")
			
			hint_string.erase(hint_string.length() - 1, 1)
	
	self.typed_array_s(var_name, hint_string, extra_usage)


func typed_array_s(var_name: String, hint_string: String, extra_usage := 0):
	self.properties.append({
		"name": var_name,
		"type": TYPE_ARRAY,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE | extra_usage,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"hint_string": hint_string,
	})


# Exporting typed nodepath
#
# Example:
#   export(NodePath) var some_node
#
#   func _get_property_list() -> Array:
#       var e = AdvExp.new()
#       e.typed_nodepath("some_node", "Node")
#      	return e.properties
func typed_nodepath(var_name: String, node: String, extra_usage := 0):
	self.properties.append({
		"name": var_name,
		"type": TYPE_NODE_PATH,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE | extra_usage,
		"hint": PROPERTY_HINT_NODE_PATH_VALID_TYPES,
		"hint_string": node
	})
