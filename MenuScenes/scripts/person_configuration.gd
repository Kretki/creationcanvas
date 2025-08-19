extends Control
class_name PersonConfiguration

@onready var mainContainer : PanelContainer = $MainContainter
@onready var vLayout : VBoxContainer = $MainContainter/VLayout
@onready var nameLabel : InputLine = $MainContainter/VLayout/InputLine

func _ready() -> void:
	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	nameLabel.setInputLine("Text", "InputText")
