extends AbstractVideoConfig
class_name ResolutionConfig

func is_valid(value: Variant) -> bool:
	return value is Vector2i and value.x > 0 and value.y > 0

func _default_value() -> Variant:
	return Vector2i(1920, 1080) # Default resolution

func apply() -> bool:
	if not is_valid(value):
		return false
	
	DisplayServer.window_set_size(value)
	
	# Verify if the resolution was applied correctly
	var current_size: Vector2i = DisplayServer.window_get_size()
	return current_size == value
