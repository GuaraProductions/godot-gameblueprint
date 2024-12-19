@tool
extends Config
class_name VideoConfig

func validate(config: AbstractConfig) -> bool:
	return config.category == category_name
