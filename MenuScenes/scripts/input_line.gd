extends HBoxContainer
class_name InputLine

@onready var nameLabel : Label = $Name
@onready var input : LineEdit = $Input

func setInputLine(text : String, placeholder : String) -> void:
	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	nameLabel.set_text(text)
	input.set_placeholder(placeholder)
