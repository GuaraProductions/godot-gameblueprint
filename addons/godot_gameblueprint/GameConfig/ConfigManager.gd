extends Node
class_name ConfigManager

@export var config_at_startup : bool = true
@export var configs : Array[AbstractConfig] = []
const GROUP_NAME : String = "Config"

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not is_in_group(GROUP_NAME):
		add_to_group(GROUP_NAME)
		
	if not config_at_startup:
		return
		
	apply_configs()

func get_config() -> Dictionary:
	var result : Dictionary = {}
	for curr in configs:
		result[curr.id] = var_to_str(curr.value)
	return result
	
func apply_configs() -> void:
	for curr in configs:
		if curr == null:
			continue
		curr.apply()

func set_config(config: String, value: Variant) -> bool:
	
	var found : bool = false
	
	for curr in configs:
		if curr.id == config:
			continue
			
		curr.value = value
		found = curr.value == value
		break
		
	return found

func set_configs(dict: Dictionary) -> bool:
	for curr in configs:
		if not dict.has(curr.id):
			continue
			
		var value = str_to_var(dict[curr.id])
		curr.value = value
		
	return true
