extends Node

## Nome do arquivo onde sera salvo as configuracoes
@export var file_name : String = "user://game_config.cfg"
@export_category("Encryption")
## Marque essa caixa se voce quer que o arquivo de configuracao seja salvo com criptografia
@export var encrypt_file : bool = false
## Se o arquivo for criptografado, aqui voce colocara a chave criptografica
@export var encryption_key : String = ""

func _ready() -> void:
	load_configs()

func save_configs() -> void:

	var config_nodes = get_tree().get_nodes_in_group(Config.GROUP_NAME)
	
	var config_file = ConfigFile.new()
	
	for config in config_nodes:
		
		var config_to_save : Dictionary = config.get_config()
		
		for key in config_to_save.keys():
			var value = config_to_save[key]
			
			config_file.set_value(config.name, key, value)
	
	if encrypt_file:
		config_file.save_encrypted_pass(file_name, encryption_key)
	else:
		config_file.save(file_name)
	
func load_configs() -> void:
	var config_file = ConfigFile.new()
	var error = OK
	if encrypt_file:
		error = config_file.load_encrypted_pass(file_name, encryption_key)
	else:
		error = config_file.load(file_name)
		
	if error != OK:
		print("Não foi possível abrir o arquivo: %d" % [error])
		return
	
	var config_nodes = get_tree().get_nodes_in_group(Config.GROUP_NAME)
	
	for config in config_nodes:
		if not config_file.has_section(config.name):
			continue
		
		var config_to_load = {}
		for key in config_file.get_section_keys(config.name):
			config_to_load[key] = config_file.get_value(config.name, key)
		
		config.set_config(config_to_load)
