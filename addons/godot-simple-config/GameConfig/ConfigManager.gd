extends Node
class_name ConfigManager

@export var configs : Array[AbstractConfig] = []
const GROUP_NAME : String = "Config"

var config_ids_and_index : Dictionary = {}

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	if not is_in_group(GROUP_NAME):
		add_to_group(GROUP_NAME)
		
	var idx : int = 0
	for curr in configs:
		config_ids_and_index[curr.id] = idx
		idx += 1

func get_config_by_id(config: String) -> Dictionary:
	var config_found := {}
	
	var idx : int = config_ids_and_index.get(config, -1)
	
	if idx == -1:
		return config_found
		
	return configs[idx].to_json()
	
func get_configs() -> Dictionary:
	var result : Dictionary = {}
	for curr in configs:
		result[curr.id] = curr.to_json()
	return result
	
func apply_configs() -> void:
	for curr in configs:
		if curr == null:
			continue
		curr.try_to_apply()

func connect_config_applied_to_callable(config: String, 
										callable: Callable,
										flags: int) -> bool:
	var connected : bool = false
	
	var idx : int = config_ids_and_index.get(config, -1)
	
	if idx == -1:
		return connected
		
	connected = true
		
	if not configs[idx].applied.is_connected(callable):
		configs[idx].applied.connect(callable, flags)
		
	return connected

func set_config(config: String, value: Variant) -> bool:
	
	var found : bool = false
	
	var idx : int = config_ids_and_index.get(config, -1)
	
	if idx == -1:
		return found
			
	configs[idx].value = value
	found = configs[idx].value == value
		
	return found

func set_configs(dict: Dictionary) -> bool:
	for curr in configs:
		if not dict.has(curr.id):
			continue
		
		var value = str_to_var(dict[curr.id])
		curr.value = value
		
	return true
