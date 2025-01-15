extends Node

## Nome do arquivo onde sera salvo as configuracoes
@export var file_name : String = "user://game_config.cfg"
@export var config_at_startup : bool = false
@export_category("Encryption")
## Marque essa caixa se voce quer que o arquivo de configuracao seja salvo com criptografia
@export var encrypt_file : bool = false
## Se o arquivo for criptografado, aqui voce colocara a chave criptografica
@export var encryption_key : String = ""

func _ready() -> void:
	load_configs()
	
	if config_at_startup:
		apply_configs()

func _get_config_node(config_manager: String) -> ConfigManager:
	
	var node = get_node_or_null(config_manager)
	
	if not node:
		printerr("Erro! Config Manager \"%s\" nao existe!")
	
	return node

func get_config(config_manager: String, 
				config: String) -> Dictionary:
	
	var node = _get_config_node(config_manager)
	if node == null:
		return {}
	
	return node.get_config_by_id(config) 
	
	
func get_configs(configs: PackedStringArray = []) -> Dictionary:
	
	var config_dictionary : Dictionary = {}
	
	for config_node in get_children():
		
		if not config_node is ConfigManager:
			continue
		
		if configs.is_empty() or configs.has(config_node.name):
			config_dictionary[config_node.name] = config_node.get_configs()
		
	return config_dictionary

func set_config(config_manager: String, 
				config: String, 
				value: Variant) -> bool:
	
	var node = _get_config_node(config_manager)
	if node == null:
		return false
	
	return node.set_config(config,value) 

## Salvar todas as configuracoes que estao ativas na cena do configurador
func save_configs(apply_all: bool = false) -> void:

	var config_nodes = get_tree().get_nodes_in_group(ConfigManager.GROUP_NAME)
	
	var config_file = ConfigFile.new()
	
	for config in config_nodes:
		
		var config_to_save : Dictionary = config.get_configs()
		
		for key in config_to_save.keys():
			var config_json = config_to_save[key]
			
			config_file.set_value(config.name, key, var_to_str(config_json.value))
		
		if apply_all:
			config.apply_configs()
	
	if encrypt_file and not encryption_key.is_empty():
		config_file.save_encrypted_pass(file_name, encryption_key)
	else:
		if encrypt_file and encryption_key.is_empty():
			printerr("Erro! a chave criptografica esta vazia, salvando o arquivo sem criptografia...")
		config_file.save(file_name)
	
func apply_configs(save: bool = false) -> void:
	var config_nodes = get_tree().get_nodes_in_group(ConfigManager.GROUP_NAME)
	
	for config in config_nodes:
		config.apply_configs()
		
	if save:
		save_configs()
	
func load_configs() -> void:
	var config_file = ConfigFile.new()
	var error = OK
	if encrypt_file and not encryption_key.is_empty():
		error = config_file.load_encrypted_pass(file_name, encryption_key)
	else:
		if encrypt_file and encryption_key.is_empty():
			printerr("Erro! a chave criptografica esta vazia, carregando o arquivo sem criptografia...")
		error = config_file.load(file_name)
		
	if error != OK:
		if error != ERR_FILE_NOT_FOUND:
			printerr("Não foi possível abrir o arquivo: %d" % [error])
		return
	
	var config_nodes = get_tree().get_nodes_in_group(ConfigManager.GROUP_NAME)
	
	for config in config_nodes:
		if not config_file.has_section(config.name):
			continue
		
		var config_to_load = {}
		for key in config_file.get_section_keys(config.name):
			config_to_load[key] = config_file.get_value(config.name, key)
		
		config.set_configs(config_to_load)

func connect_to_applied_signal(config_manager: String, 
										config: String, 
										callable: Callable,
										flags: int = 0) -> bool:
										
	var node = _get_config_node(config_manager)
	if node == null:
		return false
	
	return node.connect_config_applied_to_callable(config,callable,flags) 
