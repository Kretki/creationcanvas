extends Control
class_name BottomMenu

@export var drawerHeight : float = 240.0
@export var slideTime : float = 0.25
@export var tabExtraMargin : float = 20.0
@export var btnStretchRatio : float = 0.2

var isOpen: bool = false
var tabHeight: float = 0.0

@onready var drawer : PanelContainer = $Drawer
@onready var handle : Button = $Drawer/OuterLayout/HandleLayout/Handle
@onready var handleFillerLeft : Panel = $Drawer/OuterLayout/HandleLayout/HandleLeft
@onready var handleFillerRight : Panel = $Drawer/OuterLayout/HandleLayout/HandleRight

func _ready() -> void:
	#self.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	handleFillerLeft.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	handleFillerLeft.size_flags_stretch_ratio = 10 * (1 - btnStretchRatio) / 2
	handle.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	handle.size_flags_stretch_ratio = 10 * btnStretchRatio
	handleFillerRight.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	handleFillerRight.size_flags_stretch_ratio = 10 * (1 - btnStretchRatio) / 2
	
	handle.pressed.connect(onHandlePressed)
	
	drawer.anchor_left = 0.0
	drawer.anchor_right = 1.0
	drawer.anchor_top = 1.0
	drawer.anchor_bottom = 1.0
	drawer.offset_left = 0
	drawer.offset_right = 0
	
	resized.connect(onResized)
	
	await get_tree().process_frame
	tabHeight = clampf(handle.size.y + tabExtraMargin, 0.0, drawerHeight - 1.0)
	
	isOpen = false
	setDrawerInstant(isOpen)
	updateHandleArrow()
	
	var empty := StyleBoxEmpty.new()
	drawer.add_theme_stylebox_override("panel", empty)

func onResized() -> void:
	tabHeight = clampf(handle.size.y + tabExtraMargin, 0.0, drawerHeight - 1.0)
	setDrawerInstant(isOpen)

func drawerOffset(open: bool) -> float:
	if open: return -drawerHeight
	else: return -tabHeight
	
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
	handle.text = "▼" if isOpen else "▲"
	handle.tooltip_text = "Hide menu" if isOpen else "Show menu"
