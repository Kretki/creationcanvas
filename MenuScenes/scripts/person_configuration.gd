extends Control
class_name PersonConfiguration

signal submitInput(name : String)

@export var contentPadding : int = 12

@onready var mainContainer : PanelContainer = $MainContainer
@onready var vLayout : VBoxContainer = $MainContainer/VLayout
@onready var nameLabel : InputLine = $MainContainer/VLayout/InputLine
@onready var submitBtn : Button = $MainContainer/VLayout/Submit

func _ready() -> void:	
	set_anchors_preset(Control.PRESET_FULL_RECT)
	#size_flags_vertical = Control.SIZE_EXPAND_FILL
	offset_left = 0
	offset_top = 0
	offset_right = 0
	offset_bottom = 0
	
	mainContainer.set_anchors_preset(Control.PRESET_FULL_RECT)
	mainContainer.offset_left = 0
	mainContainer.offset_right = 0
	mainContainer.offset_top = 0
	mainContainer.offset_bottom = 0

	nameLabel.size_flags_horizontal = Control.SIZE_FILL
	
	await get_tree().process_frame
	
	var sb = mainContainer.get_theme_stylebox("panel").duplicate()
	sb.content_margin_left = contentPadding
	sb.content_margin_right = contentPadding
	sb.content_margin_top = contentPadding
	sb.content_margin_bottom = contentPadding
	mainContainer.add_theme_stylebox_override("panel", sb)
	
	nameLabel.setInputLine("Text", "InputText")
	
	submitBtn.pressed.connect(onSubmitPressed)

func onSubmitPressed() -> void:
	emit_signal("submitInput", nameLabel.getInput())
