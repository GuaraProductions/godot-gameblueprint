extends ColorRect

@onready var window_resolution_field : OptionButton = %WindowResolutionField

@onready var window_mode_field : OptionButton = %WindowModeField
@onready var window_mode_label : Label = %WindowModeLabel

@onready var vsync_label : Label = %VsyncLabel
@onready var vsync_field : CheckBox = %VsyncField

const POSSIBLE_SCREEN_RESOLUTIONS : Array = [
	"1280x720",
	"1366x768",
	"1536x864",
	"1920x1080",
	"2560x1440",
	"3840x2160"
]

func _ready() -> void:
	
	var screen_size : Vector2i = DisplayServer.screen_get_size()
	
	for resolution in POSSIBLE_SCREEN_RESOLUTIONS:
		if _resolution_string_to_vector(resolution) <= screen_size:
			window_resolution_field.add_item(resolution)

func _resolution_string_to_vector(resolution_string : String) -> Vector2i:
	var values : PackedStringArray = resolution_string.split("x")
	return Vector2i(int(values[0]), int(values[1]))

func _on_go_back_pressed() -> void:
	pass # Replace with function body.


func _on_max_fps_slider_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_window_mode_field_item_selected(index: int) -> void:
	GameConfig.set_config("Video","window_mode", index)

func _on_window_resolution_field_item_selected(index: int) -> void:
	var value : String = window_resolution_field.get_item_text(index)
	var resolution : Vector2i = _resolution_string_to_vector(value)
	GameConfig.set_config("Video","resolution", resolution)

func _on_vsync_field_toggled(toggled_on: bool) -> void:
	GameConfig.set_config("Video", "vsync", DisplayServer.VSYNC_ENABLED if toggled_on else DisplayServer.VSYNC_DISABLED)

func _on_apply_pressed() -> void:
	GameConfig.apply_configs(true)
