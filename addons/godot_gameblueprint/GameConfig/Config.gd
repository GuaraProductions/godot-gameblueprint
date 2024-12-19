@tool
extends Node
class_name Config

@export var configs : Array[AbstractConfig] = []
@export var category_name : String = "NoName" : set = _set_category_name
const GROUP_NAME : String = "Config"

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not is_in_group(GROUP_NAME):
		add_to_group(GROUP_NAME)
		
	for curr in configs:
		if curr == null:
			continue
		curr.apply()

func _get_configuration_warnings() -> PackedStringArray:
	var result : PackedStringArray = []
	if category_name.is_empty():
		result.append("Erro! O nome de categoria está vazio, configure um que seja válido!")
	
	return result

func _set_category_name(value: String) -> void:
	category_name = value
	update_configuration_warnings()

func validate(config: AbstractConfig) -> bool:
	printerr("Not implemented")
	return false

func get_config() -> Dictionary:
	var result : Dictionary = {}
	for curr in configs:
		result[curr.id] = var_to_str(curr.value)
	return result
