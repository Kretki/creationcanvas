extends HBoxContainer
class_name InputLine

@onready var nameLabel : Label = $Name
@onready var input : LineEdit = $Input

func setInputLine(text : String, placeholder : String) -> void:
	self.size_flags_horizontal = HBoxContainer.SIZE_EXPAND_FILL
	nameLabel.set_text(text)
	nameLabel.size_flags_horizontal = Label.SIZE_EXPAND_FILL
	nameLabel.size_flags_stretch_ratio = 3
	input.set_placeholder(placeholder)
	input.size_flags_horizontal = LineEdit.SIZE_EXPAND_FILL
	input.size_flags_stretch_ratio = 7
