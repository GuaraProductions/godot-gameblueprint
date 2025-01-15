extends Resource
class_name AbstractConfig

signal applied(value)

## O identificador da configuracao, usando para encontrar ela quando carregado do arquivo de configuracoes
@export var id : String = "" 
## O nome da configuracao
@export var name : String = "" : get = _get_name
## Descricao da configuracao
@export_multiline var description : String = "" : get = _get_description

var value : Variant = null : get = _get_value, set = _set_value

func _init(p_id: String = "",
		   p_name: String = "", 
		   p_description : String = "") -> void:
	
	id = p_id
	name = p_name
	description = p_description

func _get_name() -> String:
	return tr(name)
	
func _get_description() -> String:
	return tr(description)

func _set_value(new_value: Variant) -> void:
	if is_valid(new_value):
		value = new_value

func _get_value() -> Variant:
	return value if value != null else _default_value()
	
func _default_value() -> Variant:
	return null
	
func is_valid(new_value: Variant) -> bool:
	printerr("Config \"is_valid\" function not implemented!")
	printerr("Config id: ", id)
	printerr("Config name: ", name)
	return false
	
func try_to_apply() -> bool:
	
	var value_applied : bool = apply()
	
	if value_applied:
		applied.emit(value)
		
	return value_applied
	
func apply() -> bool:
	printerr("Config \"apply\" function not implemented!")
	printerr("Config id: ", id)
	printerr("Config name: ", name)
	return false
	
func to_json() -> Dictionary:
	return {
		"id" : id,
		"name" : name,
		"description" : description,
		"value" : value
	}
