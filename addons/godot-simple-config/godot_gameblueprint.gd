@tool
extends EditorPlugin

const GAME_CONFIG_SINGLETON_NAME : String = "GameConfig"
const GAME_CONFIG_SCENE_PATH : String = "res://addons/godot_gameblueprint/GameConfig/GameConfig.tscn"

const ACTIONS_TO_CONFIGURE : Dictionary = {
	"ui_screenshot" : [KEY_F12]
}

func _enter_tree() -> void:
	_add_singletons()
	_configure_bindings()

func _exit_tree() -> void:
	_remove_singletons()
	_remove_bindings()
	
func _configure_bindings() -> void:
	"""
	for action in ACTIONS_TO_CONFIGURE.keys():
		
		if not InputMap.has_action(action):
			InputMap.add_action(action)
			
		for key in ACTIONS_TO_CONFIGURE[action]:
			var event = InputEventKey.new()
			event.physical_keycode = key
			InputMap.action_add_event(action, event)
			
		print("action_events: ", InputMap.action_get_events(action))
	"""

func _remove_bindings() -> void:
	pass
	"""
	for action in ACTIONS_TO_CONFIGURE.keys():
		if InputMap.has_action(action):
			InputMap.erase_action(action)
	"""

func _add_singletons() -> void:
	add_autoload_singleton(GAME_CONFIG_SINGLETON_NAME, GAME_CONFIG_SCENE_PATH)
	
func _remove_singletons() -> void:
	remove_autoload_singleton(GAME_CONFIG_SINGLETON_NAME)
