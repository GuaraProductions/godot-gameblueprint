extends Node

## Nome do arquivo onde sera salvo as configuracoes
@export var file_name : String = "user://game_config.cfg"
@export_category("Encryption")
## Marque essa caixa se voce quer que o arquivo de configuracao seja salvo com criptografia
@export var encrypt_file : bool = false
## Se o arquivo for criptografado, aqui voce colocara a chave criptografica
@export var encryption_key : String = ""

func _ready() -> void:
	save_configs()

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
	
