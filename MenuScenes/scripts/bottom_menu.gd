extends Control
class_name BottomMenu

@export var drawerHeight : float = 240.0
@export var slideTime : float = 0.25
@export var tabExtraMargin: float = 20.0

var isOpen: bool = false
var tabHeight: float = 0.0

@onready var drawer : PanelContainer = $Drawer
@onready var handle : Button = $Drawer/OuterLayout/Handle
@onready var nameLabel : InputLine = $Drawer/OuterLayout/InputLine

func _ready() -> void:
	#drawer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	#self.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	#self.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# Hook up signals
	handle.pressed.connect(onHandlePressed)
	
	drawer.anchor_left = 0.0
	drawer.anchor_right = 1.0
	drawer.anchor_top = 1.0
	drawer.anchor_bottom = 1.0
	drawer.offset_left = 0
	drawer.offset_right = 0
	# React to window resizes
	resized.connect(onResized)
	
	await get_tree().process_frame
	tabHeight = clampf(handle.size.y + tabExtraMargin, 0.0, drawerHeight - 1.0)
	
	# Initial layout & state
	isOpen = false
	setDrawerInstant(isOpen)
	updateHandleArrow()
	nameLabel.setInputLine("Text", "InputText")

func onResized() -> void:
	# Keep drawer aligned after a resize
	tabHeight = clampf(handle.size.y + tabExtraMargin, 0.0, drawerHeight - 1.0)
	setDrawerInstant(isOpen)

func drawerOffset(open: bool) -> float:
	# Visible: top of drawer sits at bottom - height. Hidden: moved just below screen.
	if open:
		return -drawerHeight
	else:
		return -tabHeight
	
func setDrawerInstant(open: bool) -> void:
	var offset = drawerOffset(open)
	drawer.offset_top = offset

func onHandlePressed() -> void:
	toggle()

func toggle(open: bool = !isOpen) -> void:
	isOpen = open
	updateHandleArrow()
	var tw = create_tween()
	tw.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.parallel().tween_property(drawer, "offset_top", drawerOffset(open), slideTime)

func updateHandleArrow() -> void:
	# ▲ when closed (press to open), ▼ when open (press to close)
	handle.text = "▼" if isOpen else "▲"
	handle.tooltip_text = "Hide menu" if isOpen else "Show menu"
