@tool
extends Config

func validate(config: AbstractConfig) -> bool:
	return config is AbstractVideoConfig

func get_config() -> Dictionary:
	return {
		"locale" : "pt_br"
	}
