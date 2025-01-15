@tool
extends Node

@export var property_name : String = "" : set = _set_property_name
@export var config_manager_id : String = "" : set = _set_config_manager_id
@export var config_id : String = "" : set = _set_config_id

var parent

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	var config_information : Dictionary = \
	 GameConfig.get_config(config_manager_id, config_id)
	
	GameConfig.connect_to_applied_signal(config_manager_id, 
										 config_id, 
										 update_value)
	
	parent = get_parent()
	parent.ready.connect(_parent_ready.bind(config_information.value))

func _parent_ready(value: Variant) -> void:
	
	if not parent is Control:
		return
		
	update_value(value)
	
func update_value(value: Variant) -> void:
	parent.set(property_name, value)

func _set_config_id(value: String) -> void:
	config_id = value
	update_configuration_warnings()
	
func _set_config_manager_id(value: String) -> void:
	config_manager_id = value
	update_configuration_warnings()
	
func _set_property_name(value: String) -> void:
	property_name = value
	update_configuration_warnings()
	
func _get_configuration_warnings() -> PackedStringArray:
	
	var errors := []
	
	if config_manager_id.is_empty():
		errors.append("Please configure the \"config_manager_id\" property")
		
	if config_id.is_empty():
		errors.append("Please configure the \"config_id\" property")
		
	if property_name.is_empty():
		errors.append("Please configure the \"property_name\" property")
		
	return errors
