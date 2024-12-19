extends AbstractVideoConfig
class_name VSyncConfig

func is_valid(value: Variant) -> bool:
	return value is bool
	
func _default_value() -> Variant:
	return false
	
func apply() -> bool:
	var vsync_value : int = DisplayServer.VSYNC_ENABLED if value else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(vsync_value)
	
	return DisplayServer.window_get_vsync_mode() == vsync_value
