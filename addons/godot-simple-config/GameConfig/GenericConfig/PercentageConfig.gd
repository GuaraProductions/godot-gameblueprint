extends AbstractConfig
class_name PercentageConfig

@export_range(0,1,0.01) var default_value : float = 0.6

func is_valid(value: Variant) -> bool:
	return value is float and value >= 0.0 and value <= 1.0

func apply() -> bool:
	applied.emit(value)
	
	return true
	

func _default_value() -> Variant:
	return default_value 
