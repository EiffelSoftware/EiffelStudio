indexing
	description:
		"Eiffel Vision internal information."
	status: "See notice at end of class."
	keywords: "internal, description, keyword"

class
	EV_INTERNAL

feature -- Access

	class_descriptions: HASH_TABLE [STRING, STRING] is
			-- Table of class descriptions by name.
		once
			create Result.make(100)
			
			Result.force (		"Action sequence for accelerator events."

, "EV_ACCELERATOR_ACTION_SEQUENCE")
			Result.force (		"Base Eiffel Vision action sequence."

, "EV_ACTION_SEQUENCE[EVENT_DATA->TUPLEcreatemakeend]")
			Result.force (		"Action sequences for EV_APPLICATION."

, "EV_APPLICATION_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_BUTTON."

, "EV_BUTTON_ACTION_SEQUENCES")
			Result.force (		"Action sequence for multi column list column events."

, "EV_COLUMN_ACTION_SEQUENCE")
			Result.force (		"Action sequence for multi column list column click events."

, "EV_COLUMN_TITLE_CLICK_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_CONTAINER."

, "EV_CONTAINER_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_DRAWING_AREA."

, "EV_DRAWING_AREA_ACTION_SEQUENCES")
			Result.force (		"Action sequence for lose/gain of keyboard-focus."

, "EV_FOCUS_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_GAUGE."

, "EV_GAUGE_ACTION_SEQUENCES")
			Result.force (		"Action sequence for geometry related events."

, "EV_GEOMETRY_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_ITEM."

, "EV_ITEM_ACTION_SEQUENCES")
			Result.force (		"Action sequence for keyboard events."

, "EV_KEY_ACTION_SEQUENCE")
			Result.force (		"Action sequence for keyboard events."

, "EV_KEY_STRING_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_LIST_ITEM."

, "EV_LIST_ITEM_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_LIST_ITEM_LIST."

, "EV_LIST_ITEM_LIST_ACTION_SEQUENCES")
			Result.force (		"Action sequence for list item selection events."

, "EV_LIST_ITEM_SELECT_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_MENU_ITEM."

, "EV_MENU_ITEM_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_MENU_ITEM_LIST."

, "EV_MENU_ITEM_LIST_ACTION_SEQUENCES")
			Result.force (		"Action sequence for menu item selection events."

, "EV_MENU_ITEM_SELECT_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_MULTI_COLUMN_LIST."

, "EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_MULTI_COLUMN_LIST_ROW."

, "EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES")
			Result.force (		"Action sequence for multi column list row selection events."

, "EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE")
			Result.force (		"Action sequence for new container item events."

, "EV_NEW_ITEM_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_NOTEBOOK."

, "EV_NOTEBOOK_ACTION_SEQUENCES")
			Result.force (		"Action sequence for general notify events with no parameters."

, "EV_NOTIFY_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_PICK_AND_DROPABLE."

, "EV_PICK_AND_DROPABLE_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_PIXMAP."

, "EV_PIXMAP_ACTION_SEQUENCES")
			Result.force (		"Action sequence for PND drop events."

, "EV_PND_ACTION_SEQUENCE")
			Result.force (		"Action sequence for pick and drop transport start events."

, "EV_PND_START_ACTION_SEQUENCE")
			Result.force (		"Action sequence for mouse button up/down events."

, "EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.force (		"Action sequence for mouse movement events."

, "EV_POINTER_MOTION_ACTION_SEQUENCE")
			Result.force (		"Action sequence for proximity in/out events."

, "EV_PROXIMITY_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_STANDARD_DIALOG."

, "EV_STANDARD_DIALOG_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_TEXT_COMPONENT."

, "EV_TEXT_COMPONENT_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_TEXT_FIELD."

, "EV_TEXT_FIELD_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_TOOL_BAR_BUTTON."

, "EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_TREE."

, "EV_TREE_ACTION_SEQUENCES")
			Result.force (		"Action sequence for tree item selection events."

, "EV_TREE_ITEM_SELECT_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_TREE_NODE."

, "EV_TREE_NODE_ACTION_SEQUENCES")
			Result.force (		"Action sequence for change of integer value events."

, "EV_VALUE_CHANGE_ACTION_SEQUENCE")
			Result.force (		"Action sequences for EV_WIDGET."

, "EV_WIDGET_ACTION_SEQUENCES")
			Result.force (		"Action sequences for EV_WINDOW."

, "EV_WINDOW_ACTION_SEQUENCES")
			Result.force (		"Figure that is can have an arrowhead at its start or endpoint."

, "EV_ARROWED_FIGURE")
			Result.force (		"Figures that cannot contain other figures."

, "EV_ATOMIC_FIGURE")
			Result.force (		"Closed figures filled with `background_color'."

, "EV_CLOSED_FIGURE")
			Result.force (		"Figures consisting of two points."

, "EV_DOUBLE_POINTED_FIGURE")
			Result.force (		"Projectors that make representations of `world' on%N%

		%EV_DRAWING_AREA."

, "EV_DRAWING_AREA_PROJECTOR")
			Result.force (		"Graphically representable objects."

, "EV_FIGURE")
			Result.force (		"Curves as defined by two rectangle points, a `start_angle' and%N%

		%`aperture'."

, "EV_FIGURE_ARC")
			Result.force (		"Pixels on `point' with size `line_width'."

, "EV_FIGURE_DOT")
			Result.force (		"Adapters for EV_DRAWABLE that allow drawing of figures."

, "EV_FIGURE_DRAWER")
			Result.force (		"Abstract class for drawing of figures."

, "EV_FIGURE_DRAWING_ROUTINES")
			Result.force (		"Biggest ellipse fitting in imaginary rectangle defined by%N%

		%`point_a' and `point_b'."

, "EV_FIGURE_ELLIPSE")
			Result.force (		"Figures with its sides the same size."

, "EV_FIGURE_EQUILATERAL")
			Result.force (		"Group of EV_FIGURE's. If a figure is added to%

		%this group, it is removed from its previous group first."

, "EV_FIGURE_GROUP")
			Result.force (		"Figure that is a line segment between 2 points."

, "EV_FIGURE_LINE")
			Result.force (		"Facilities class for EV_FIGURE."

, "EV_FIGURE_MATH")
			Result.force (		"Pixmaps drawn on `point'."

, "EV_FIGURE_PICTURE")
			Result.force (		"Slices from a circle with `center_point'. Size is determined by%N%

		%`aperture' [-2*Pi..2*Pi]."

, "EV_FIGURE_PIE_SLICE")
			Result.force (		"Filled area's defined by any number of `points'."

, "EV_FIGURE_POLYGON")
			Result.force (		"Sequences of lines through `points'."

, "EV_FIGURE_POLYLINE")
			Result.force (		"Class for drawing of figures to postscript."

, "EV_FIGURE_POSTSCRIPT_DRAWER")
			Result.force (		"Rectangular area defined by `point_a' and `point_b'."

, "EV_FIGURE_RECTANGLE")
			Result.force (		"Rectangular figures with rounded corners."

, "EV_FIGURE_ROUNDED_RECTANGLE")
			Result.force (		"`line_count' lines emerging from `center_point'."

, "EV_FIGURE_STAR")
			Result.force (		"`text's in a `font' displayed on `point'."

, "EV_FIGURE_TEXT")
			Result.force (		"Figure groups that are the root of a world of figures.%N%

		%May be interpreted by any kind of projection.%N%

		%Examples: may be output to a printer, saved to an XML file,%N%

		%drawn on a drawing area, etc."

, "EV_FIGURE_WORLD")
			Result.force (		"Handles that allow the user to control certain EV_RELATIVE_POINTs%N%

		%in an EV_FIGURE_WORLD."

, "EV_MOVE_HANDLE")
			Result.force (		"Figures consisting of zero or more points."

, "EV_MULTI_POINTED_FIGURE")
			Result.force (		"Projectors that make representations of `world' on EV_PIXMAP."

, "EV_PIXMAP_PROJECTOR")
			Result.force (		"Page size constants for use with EV_POSTSCRIPT_PROJECTOR."

, "EV_POSTSCRIPT_PAGE_CONSTANTS")
			Result.force (		"Projection to Postscript files."

, "EV_POSTSCRIPT_PROJECTOR")
			Result.force (		"Abstract class for figure projection routines."

, "EV_PROJECTION_ROUTINES")
			Result.force (		"Viewers of EV_FIGURE_WORLDs."

, "EV_PROJECTOR")
			Result.force (		"Positions relative to other positions.%N%

		%Takes another relative point as origin and then defines a%N%

		%hor. & vert. scaling factor, x, y and angle.%N%

		%You can then access absolute scale_x, scale_y, x, y and angle%N%

		%which are recomputed only if invalidate_absolute_position has%N%

		%been called.%N%

		%You may also choose to specify a positioner. This is an agent%N%

		%that gets called everytime a recomputation is requested.%N%

		%When a positioner is installed, the other attributes are ignored.%N%

		%The x and y are transformed by the angle and scaling of the origin.%N%

		%This implies that the scale_x, scale_y and angle features of this%N%

		%object are only for propagation to referring points."

, "EV_RELATIVE_POINT")
			Result.force (		"Figures consisting of one point."

, "EV_SINGLE_POINTED_FIGURE")
			Result.force (		"Projectors for widgets."

, "EV_WIDGET_PROJECTOR")
			Result.force (		"Basic mathematical operations using lookup table."

, "LOOKUP_DOUBLE_MATH")
			Result.force (		"Menu item with a check box."

, "EV_CHECK_MENU_ITEM")
			Result.force (		"Dynamically expandable tree item."

, "EV_DYNAMIC_TREE_ITEM")
			Result.force (		"Base class for all items that may be held in EV_ITEM_LISTs."

, "EV_ITEM")
			Result.force (		"Item for use in EV_LIST and EV_COMBO_BOX."

, "EV_LIST_ITEM")
			Result.force (		"Item for use in EV_MENU."

, "EV_MENU_ITEM")
			Result.force (		"Horizontal scored line separator for use in EV_MENU."

, "EV_MENU_SEPARATOR")
			Result.force (		"Row item for use in EV_MULTI_COLUMN_LIST"

, "EV_MULTI_COLUMN_LIST_ROW")
			Result.force (		"Menu item with state displayed as a circular check box.%N%

		%`is_selected' is mutually exclusive with respect to other radio menu%

		%items between separators in a menu."

, "EV_RADIO_MENU_ITEM")
			Result.force (		"Base class for menu items that have two states (See `is_selected')"

, "EV_SELECT_MENU_ITEM")
			Result.force (		"Item for use with EV_STATUS_BAR."

, "EV_STATUS_BAR_ITEM")
			Result.force (		"Press button for use with EV_TOOL_BAR"

, "EV_TOOL_BAR_BUTTON")
			Result.force (		"Base class for items for use with EV_TOOL_BAR"

, "EV_TOOL_BAR_ITEM")
			Result.force (		"Toggle button for use with EV_TOOL_BAR.%N%

		%`is_selected' is mutualy exclusive with respect to other tool bar%

		%radio buttons between separators in a tool bar."

, "EV_TOOL_BAR_RADIO_BUTTON")
			Result.force ("No description", "EV_TOOL_BAR_SELECT_BUTTON")
			Result.force (		"Scored line separator for use in EV_TOOL_BAR."

, "EV_TOOL_BAR_SEPARATOR")
			Result.force (		"Button for use with EV_TOOL_BAR that toggles between states each time%

		%it is pressed"

, "EV_TOOL_BAR_TOGGLE_BUTTON")
			Result.force (		"Item for use with EV_TREE.%N%

		%A tree item is also a tree-item container because if%

		%we create a tree-item with a tree-item as parent, the%

		%parent will become a subtree."

, "EV_TREE_ITEM")
			Result.force (		"Node for use with EV_TREE."

, "EV_TREE_NODE")
			Result.force (		"A keyboard accelerator defines `actions' to be performed when a%

		%`key' is pressed. See `{EV_TITLED_WINDOW}.accelerators'"

, "EV_ACCELERATOR")
			Result.force (		"Base class for Eiffel Vision interface.%N%

		%Eiffel Vision uses the bridge pattern.%N%

		%(See bridge pattern notes below.)%N%

		%Descendents of this class are coupled to descendents of EV_ANY_I%N%

		%(the base class for Eiffel Vision implementation classes).%N%

		%EV_ANY's descendants provide a common interface across all%N%

		%platforms while EV_ANY_I's descendants provide any necessary%N%

		%platform specific implementation."

, "EV_ANY")
			Result.force (		"Eiffel Vision Application.%N%

		%To start an Eiffel Vision application: create exactly one%

		%EV_APPLICATION object and call `launch' after setting up initial%

		%window(s)"

, "EV_APPLICATION")
			Result.force ("No description", "EV_CLIPBOARD")
			Result.force (		"Color modeled as red, green, blue and alpha intensities%

		%each with range [0,1]."

, "EV_COLOR")
			Result.force (		"A position in a 2 dimensional space as INTEGERs (x, y)"

, "EV_COORDINATES")
			Result.force (		"Apearance of a screen pointer cursor, typically moved by a mouse."

, "EV_CURSOR")
			Result.force ("No description", "EV_CURSOR_CODE")
			Result.force (		"Facilities for inspecting global environment information."

, "EV_ENVIRONMENT")
			Result.force (		"Representation of a typeface.%N%

		%Appearance is specified in terms of font family, height, shape and%N%

		%weight. The local system font closest to the specification will be%N%

		%displayed. A specific font name may optionally be specified. %

		%See `set_preferred_face'"

, "EV_FONT")
			Result.force (		"Facilities used by and for ues with EV_FONT."

, "EV_FONT_CONSTANTS")
			Result.force ("No description", "EV_FONT_CONSTANTS")
			Result.force (		"Eiffel Vision key. Represents a virtual key code. `code' can be any%N%

		%of the constant values defined in EV_KEY_CONSTANTS."

, "EV_KEY")
			Result.force (		"Eiffel Vision key constants. Each constant defined here %N%

		%corresponds to a possible value of {EV_KEY}.code"

, "EV_KEY_CONSTANTS")
			Result.force (		"Drop in replacement for old EV_APPLICATION class."

, "EV_OLD_APPLICATION")
			Result.force ("No description", "EV_RECTANGLE")
			Result.force (		"Eiffel Vision Simple application.%N%

		%Base for root class in a simple application.%N%

		%Inherit and define `prepare'."

, "EV_SIMPLE_APPLICATION")
			Result.force (		"Repeatedly executes a sequence of `actions' at a regular `interval'."

, "EV_TIMEOUT")
			Result.force (		"Abstract interface for all pick and dropable classes.%N%

		%Descendants include: widgets, items and figures."

, "EV_ABSTRACT_PICK_AND_DROPABLE")
			Result.force (		"Abstraction for objects that can change color."

, "EV_COLORIZABLE")
			Result.force (		"Abstraction for objects that may be parented."

, "EV_CONTAINABLE")
			Result.force (		"Abstraction for objects that may be selected/unselected."

, "EV_DESELECTABLE")
			Result.force (		"Abstraction for objects onto which graphical primitives may be%N%

		%applied."

, "EV_DRAWABLE")
			Result.force (		"Constants for use by and with EV_DRAWABLE."

, "EV_DRAWABLE_CONSTANTS")
			Result.force (		"Abstraction for objects that have a font property."

, "EV_FONTABLE")
			Result.force (		"Abstraction for objects that support active help contexts."

, "EV_HELP_CONTEXTABLE")
			Result.force (		"Facilities for pick and drop mechanism.%N%

		%Decendents can act both as pick and drop sources and as targets.%N%

		%When the user picks a `pebble' from a source and drops on a target,%

		%the `drop_actions' of the target receive the `pebble' as input.%N%

		%The user interface can be either pick and drop or drag and drop,%

		%selected by `set_pick_and_drop' and `set_drag_and_drop'."

, "EV_PICK_AND_DROPABLE")
			Result.force (		"Abstraction for objects that have a pixmap property."

, "EV_PIXMAPABLE")
			Result.force (		"Abstraction for objects whos position can be set."

, "EV_POSITIONABLE")
			Result.force (		"Abstraction for objects that have geometric position."

, "EV_POSITIONED")
			Result.force (		"Abstraction for objects that may be selected."

, "EV_SELECTABLE")
			Result.force (		"Abstraction for objects that may ignore user input."

, "EV_SENSITIVE")
			Result.force (		"Enumeration class for text alignment. Default is left."

, "EV_TEXT_ALIGNMENT")
			Result.force (		"Enumeration class for text rich alignment       %

		% (left, center, right) for horizontal alignment %

		% (top, middle, bottom) for vertical alignment   "

, "EV_TEXT_RICH_ALIGNMENT")
			Result.force (		"Abstraction for objects that have a text label."

, "EV_TEXTABLE")
			Result.force (		"Abstraction for objects that have a tooltip property."

, "EV_TOOLTIPABLE")
			Result.force ("No description", "EV_ACCELERATOR_LIST")
			Result.force (		""

, "EV_BMP_FORMAT")
			Result.force (		"Facilities for accessing standardized colors."

, "EV_STOCK_COLORS")
			Result.force (		"Facilities for accessing default fonts."

, "EV_STOCK_FONTS")
			Result.force (		"Facilities for accessing default pixmaps."

, "EV_STOCK_PIXMAPS")
			Result.force (		"Multiple Eiffel Vision object containers accessible as list."

, "EV_DYNAMIC_LIST[G->EV_CONTAINABLE]")
			Result.force (		"Cursor for Eiffel Vision dynamic lists."

, "EV_DYNAMIC_LIST_CURSOR[G]")
			Result.force (		"Base class for graphical formats"

, "EV_GRAPHICAL_FORMAT")
			Result.force ("No description", "EV_HELP_CONTEXT")
			Result.force ("No description", "EV_HELP_ENGINE")
			Result.force (		"Base class for widgets that contain EV_ITEMs"

, "EV_ITEM_LIST[G->EV_ITEM]")
			Result.force (		""

, "EV_PNG_FORMAT")
			Result.force ("No description", "EV_PRINT_CONTEXT")
			Result.force (		"Projection to a Printer."

, "EV_PRINT_PROJECTOR")
			Result.force (		"Facilities for managing peer relations between radio buttons.%N%

		%Base class for EV_RADIO_BUTTON, EV_RADIO_MENU_ITEM and%

		%EV_TOOL_BAR_RADIO_BUTTON."

, "EV_RADIO_PEER")
			Result.force (		""

, "EV_RAW_IMAGE_DATA")
			Result.force ("No description", "EV_SIMPLE_HELP_CONTEXT")
			Result.force ("No description", "EV_SIMPLE_HELP_ENGINE")
			Result.force (		"Objects that have a feature `test_widget'."

, "EV_TESTABLE_NON_WIDGET")
			Result.force (		"Base class for EV_TREE and EV_TREE_ITEM."

, "EV_TREE_NODE_LIST")
			Result.force ("No description", "EV_COLOR_DIALOG")
			Result.force ("No description", "EV_CONFIRMATION_DIALOG")
			Result.force (		"Eiffel Vision directory dialog."

, "EV_DIRECTORY_DIALOG")
			Result.force (		"EiffelVision error dialog."

, "EV_ERROR_DIALOG")
			Result.force (		"EiffelVision file selection dialog."

, "EV_FILE_DIALOG")
			Result.force (		"Eiffel Vision file open dialog."

, "EV_FILE_OPEN_DIALOG")
			Result.force (		"Eiffel Vision file save dialog."

, "EV_FILE_SAVE_DIALOG")
			Result.force (		"EiffelVision font selection dialog."

, "EV_FONT_DIALOG")
			Result.force (		"EiffelVision information dialog."

, "EV_INFORMATION_DIALOG")
			Result.force ("No description", "EV_INPUT_DEVICE_DIALOG")
			Result.force (		"EiffelVision input dialog."

, "EV_INPUT_DIALOG")
			Result.force (		"EiffelVision message dialog. Dialogs that always consist of %N%

		%a pixmap, a text and one or more buttons."

, "EV_MESSAGE_DIALOG")
			Result.force ("No description", "EV_PRINT_DIALOG")
			Result.force (		"EiffelVision question dialog."

, "EV_QUESTION_DIALOG")
			Result.force (		"EiffelVision selection dialog. Interface."

, "EV_SELECTION_DIALOG")
			Result.force (		"EiffelVision standard dialog."

, "EV_STANDARD_DIALOG")
			Result.force (		"EiffelVision warning dialog."

, "EV_WARNING_DIALOG")
			Result.force (		"Base class for all widgets.%N%

		%Facilities for geometry management and user input."

, "EV_WIDGET")
			Result.force (		"Horizontal box for use in EV_AGGREGATE_WIDGET only.%N%

		%`parent' is always Void to isolate components of the aggregate%

		%widget from the rest of the system."

, "EV_AGGREGATE_BOX")
			Result.force (		"Container that holds only one widget."

, "EV_AGGREGATE_CELL")
			Result.force (		"Container that aligns one widget within its allocated space."

, "EV_ALIGNMENT")
			Result.force (		"Linear widget container.%N%

		%Base class for EV_HORIZONTAL_BOX and EV_VERTICAL_BOX"

, "EV_BOX")
			Result.force (		"Container that holds only one widget."

, "EV_CELL")
			Result.force (		"Widget that contains other widgets.%N%

		%Base class for all containers."

, "EV_CONTAINER")
			Result.force (		"Window intended for transient user interaction.%N%

		%Optionaly modal. A modal dialog blocks the rest of the application%

		%until closed."

, "EV_DIALOG")
			Result.force (		"Container that allows custom placement of widgets. Widgets are%N%

		%placed relative to (`origin_x', `origin_y'). Clipping will be%N%

		%applied. Items are ordered in z-order with the last item as the%N%

		%topmost."

, "EV_FIXED")
			Result.force (		"Displays an optionally labeled border around a widget."

, "EV_FRAME")
			Result.force (		"Constants for use by and with EV_FRAME."

, "EV_FRAME_CONSTANTS")
			Result.force (		"Horizontal linear widget container."

, "EV_HORIZONTAL_BOX")
			Result.force (		"Displays two widgets side by side, seperated by an adjustable divider."

, "EV_HORIZONTAL_SPLIT_AREA")
			Result.force ("No description", "EV_MENU_ITEM_LIST")
			Result.force (		"Multiple widget container. Each widget is displayed on an individual%

		%page. A tab is displayed for each page allow its selection. Only the%

		%selected page is visible."

, "EV_NOTEBOOK")
			Result.force (		"Displays a single widget that may be larger that the container.%

		%Scroll bars allow the user to select the area displayed."

, "EV_SCROLLABLE_AREA")
			Result.force (		"Contains two widgets, each on either side of an adjustable separator."

, "EV_SPLIT_AREA")
			Result.force (		"EiffelVision table. Invisible container that allows %N%

		% unlimited number of other widgets to be packed inside it.%N%

		% A table controls the children's location and size%N%

		% automatically."

, "EV_TABLE")
			Result.force (		"Top level titled window. Contains a single widget."

, "EV_TITLED_WINDOW")
			Result.force (		"Abstract class for container that hold tree nodes"

, "EV_TREE_NODE_CONTAINER")
			Result.force (		"Horizontal linear widget container"

, "EV_VERTICAL_BOX")
			Result.force (		"Displays two widgets one above the other separated by an adjustable%

		%divider"

, "EV_VERTICAL_SPLIT_AREA")
			Result.force (		"Displays a single widget that may be larger than the container.%

		%Clipping may occur though item size is not effected by viewport"

, "EV_VIEWPORT")
			Result.force (		"Multiple widget container accessible as a list."

, "EV_WIDGET_LIST")
			Result.force (		"Cursor for widget lists."

, "EV_WIDGET_LIST_CURSOR")
			Result.force (		"Top level window. Contains a single widget.%N%

		%`title' is not displayed."

, "EV_WINDOW")
			Result.force (		"Push button widget that displays text and/or a pixmap.%N%

		%(Also base class for other button widgets)"

, "EV_BUTTON")
			Result.force (		"Toggle button with state displayed as a check box."

, "EV_CHECK_BUTTON")
			Result.force (		"A text field with a button. When the button is pressed, a list of%

		%text strings is displayed. Selecting one causes it to be copied into%

		%the text field."

, "EV_COMBO_BOX")
			Result.force (		"Widget onto which graphical primatives may be drawn.%N%

		%Primitives are drawn directly onto the screen without buffering.%

		%(When buffering is required use EV_PIXMAP.)"

, "EV_DRAWING_AREA")
			Result.force (		"Base class for widgets that display `value' within a `value_range'.%N%

		%See EV_RANGE, EV_SCROLL_BAR, EV_SPIN_BUTTON and EV_PROGRESS_BAR."

, "EV_GAUGE")
			Result.force (		"Horizontal bar graph gauge for displaying progress of a process."

, "EV_HORIZONTAL_PROGRESS_BAR")
			Result.force (		"Interactive horizontal range widget. A sliding thumb displays the%N%

		%current `value' and allows it to be adjusted"

, "EV_HORIZONTAL_RANGE")
			Result.force (		"Interactive horizontal scrolling widget."

, "EV_HORIZONTAL_SCROLL_BAR")
			Result.force (		"Scored horizontal line."

, "EV_HORIZONTAL_SEPARATOR")
			Result.force (		"Displays a textual label."

, "EV_LABEL")
			Result.force (		"Displays a list of items from which the user can select."

, "EV_LIST")
			Result.force (		"Common ancestor for EV_LIST and EV_COMBO_BOX."

, "EV_LIST_ITEM_LIST")
			Result.force (		"Displays a list of multi item rows from which the user can select."

, "EV_MULTI_COLUMN_LIST")
			Result.force (		"Button that displays a `menu' when pressed.%N%

		%The most recently `selected_item' is displayed on the button."

, "EV_OPTION_BUTTON")
			Result.force (		"Input field for a single line of `text', displayed%N%

		%as a sequence of `*'."

, "EV_PASSWORD_FIELD")
			Result.force (		"Base class for simple, non container widgets."

, "EV_PRIMITIVE")
			Result.force (		"Base class for bar graph gauges that display progress of a process.%N%

		%See EV_HORIZONTAL_PROGRESS_BAR and EV_VERTICAL_PROGRESS_BAR"

, "EV_PROGRESS_BAR")
			Result.force (		"Toggle button with state displayed as a circular check box.%N%

		%`is_selected' is mutually exclusive with respect to other%

		%radio buttons in `parent' container."

, "EV_RADIO_BUTTON")
			Result.force (		"Interactive range widget. A sliding thumb displays the current `value'%

		%and allows it to be adjusted%N%

		%See EV_HORIZONTAL_RANGE and EV_VERTICAL_RANGE"

, "EV_RANGE")
			Result.force (		"Displays a rich textual label."

, "EV_RICH_LABEL")
			Result.force (		"Base class for interactive scrolling widgets.%N%

		%See EV_HORIZONTAL_SCROLL_BAR and EV_VERTICAL_SCROLL_BAR"

, "EV_SCROLL_BAR")
			Result.force (		"Base class for buttons that have two states (See `is_selected')."

, "EV_SELECT_BUTTON")
			Result.force (		"Base class for simple scored line separator widgets.%N%

		%See EV_HORIZONTAL_SEPARATOR and EV_VERTICAL_SEPARATOR"

, "EV_SEPARATOR")
			Result.force (		"Displays `value' and two buttons that allow it to be adjusted up and%

		%down within `range'."

, "EV_SPIN_BUTTON")
			Result.force (		"EiffelVision text area. To query multiple lines of text from the user."

, "EV_TEXT")
			Result.force (		"Eiffel Vision text component. Base class for text editing widgets."

, "EV_TEXT_COMPONENT")
			Result.force (		"Input field for a single line of `text'."

, "EV_TEXT_FIELD")
			Result.force (		"Button that toggles between states each time it is pressed."

, "EV_TOGGLE_BUTTON")
			Result.force (		"EiffelVision toolbar. Can only contain tool bar items."

, "EV_TOOL_BAR")
			Result.force ("No description", "EV_TREE")
			Result.force (		"Vertical bar graph gauge for displaying progress of a process."

, "EV_VERTICAL_PROGRESS_BAR")
			Result.force (		"Interactive vertical range widget. A sliding thumb displays the%N%

		%current `value' and allows it to be adjusted"

, "EV_VERTICAL_RANGE")
			Result.force (		"Interactive vertical scrolling widget."

, "EV_VERTICAL_SCROLL_BAR")
			Result.force (		"Scored vertical line."

, "EV_VERTICAL_SEPARATOR")
			Result.force (		"Drop down menu containing EV_MENU_ITEMs"

, "EV_MENU")
			Result.force (		"Menu bar containing drop down menus. See EV_MENU."

, "EV_MENU_BAR")
			Result.force (		"Graphical picture stored as a two dimensional map of pixels.%N%

		%Can be modified and displayed."

, "EV_PIXMAP")
			Result.force (		"Facilities for direct drawing on the screen."

, "EV_SCREEN")
			Result.force (		"Horizontal bar for display of status messages."

, "EV_STATUS_BAR")
		end

	class_keywords: HASH_TABLE [ARRAY [STRING], STRING] is
			-- Table of class keywords by name.
		once
			create Result.make(100)
			
			Result.force (<<"ev_accelerator">>, "EV_ACCELERATOR_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_ACTION_SEQUENCE[EVENT_DATA->TUPLEcreatemakeend]")
			Result.force (<<"event","action","sequence">>, "EV_APPLICATION_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_BUTTON_ACTION_SEQUENCES")
			Result.force (<<"ev_column">>, "EV_COLUMN_ACTION_SEQUENCE")
			Result.force (<<"ev_column_title_click">>, "EV_COLUMN_TITLE_CLICK_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_CONTAINER_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_DRAWING_AREA_ACTION_SEQUENCES")
			Result.force (<<"ev_focus">>, "EV_FOCUS_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_GAUGE_ACTION_SEQUENCES")
			Result.force (<<"ev_geometry">>, "EV_GEOMETRY_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_ITEM_ACTION_SEQUENCES")
			Result.force (<<"ev_key">>, "EV_KEY_ACTION_SEQUENCE")
			Result.force (<<"ev_key_string">>, "EV_KEY_STRING_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_LIST_ITEM_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_LIST_ITEM_LIST_ACTION_SEQUENCES")
			Result.force (<<"ev_list_item_select">>, "EV_LIST_ITEM_SELECT_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_MENU_ITEM_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_MENU_ITEM_LIST_ACTION_SEQUENCES")
			Result.force (<<"ev_menu_item_select">>, "EV_MENU_ITEM_SELECT_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES")
			Result.force (<<"ev_multi_column_list_row_select">>, "EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE")
			Result.force (<<"ev_new_item">>, "EV_NEW_ITEM_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_NOTEBOOK_ACTION_SEQUENCES")
			Result.force (<<"ev_notify">>, "EV_NOTIFY_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_PICK_AND_DROPABLE_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_PIXMAP_ACTION_SEQUENCES")
			Result.force (<<"pick and drop","drag and drop","PND","DND","drop">>, "EV_PND_ACTION_SEQUENCE")
			Result.force (<<"ev_pnd_start">>, "EV_PND_START_ACTION_SEQUENCE")
			Result.force (<<"ev_pointer_button">>, "EV_POINTER_BUTTON_ACTION_SEQUENCE")
			Result.force (<<"ev_pointer_motion">>, "EV_POINTER_MOTION_ACTION_SEQUENCE")
			Result.force (<<"ev_proximity">>, "EV_PROXIMITY_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_STANDARD_DIALOG_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_TEXT_COMPONENT_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_TEXT_FIELD_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_TREE_ACTION_SEQUENCES")
			Result.force (<<"ev_tree_item_select">>, "EV_TREE_ITEM_SELECT_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_TREE_NODE_ACTION_SEQUENCES")
			Result.force (<<"ev_value_change">>, "EV_VALUE_CHANGE_ACTION_SEQUENCE")
			Result.force (<<"event","action","sequence">>, "EV_WIDGET_ACTION_SEQUENCES")
			Result.force (<<"event","action","sequence">>, "EV_WINDOW_ACTION_SEQUENCES")
			Result.force (<<"figure","line","arrow">>, "EV_ARROWED_FIGURE")
			Result.force (<<"figure","atomic">>, "EV_ATOMIC_FIGURE")
			Result.force (<<"figure","atomic","filled","closed">>, "EV_CLOSED_FIGURE")
			Result.force (<<"figure","points">>, "EV_DOUBLE_POINTED_FIGURE")
			Result.force (<<"figures","project","pointer","drawing","points">>, "EV_DRAWING_AREA_PROJECTOR")
			Result.force (<<"figure","graphic">>, "EV_FIGURE")
			Result.force (<<"figure","arc","curve">>, "EV_FIGURE_ARC")
			Result.force (<<"figure","dot","point","pixel">>, "EV_FIGURE_DOT")
			Result.force (<<"figure","primitives","drawing">>, "EV_FIGURE_DRAWER")
			Result.force (<<"figure","primitives","drawing">>, "EV_FIGURE_DRAWING_ROUTINES")
			Result.force (<<"figure","ellipse","circle">>, "EV_FIGURE_ELLIPSE")
			Result.force (<<"figure","equilateral","hexagon","octagon">>, "EV_FIGURE_EQUILATERAL")
			Result.force (<<"group","figure">>, "EV_FIGURE_GROUP")
			Result.force (<<"figure","line","segment","arrow">>, "EV_FIGURE_LINE")
			Result.force (<<"math">>, "EV_FIGURE_MATH")
			Result.force (<<"figure","picture","pixmap">>, "EV_FIGURE_PICTURE")
			Result.force (<<"figure","slice","pizza","pie">>, "EV_FIGURE_PIE_SLICE")
			Result.force (<<"figure","polygon">>, "EV_FIGURE_POLYGON")
			Result.force (<<"figure","polyline","line">>, "EV_FIGURE_POLYLINE")
			Result.force (<<"figure","primitives","drawing","postscript">>, "EV_FIGURE_POSTSCRIPT_DRAWER")
			Result.force (<<"figure","rectangle","square">>, "EV_FIGURE_RECTANGLE")
			Result.force (<<"figure","rectangle","rounded","radius">>, "EV_FIGURE_ROUNDED_RECTANGLE")
			Result.force (<<"figure","star","plus">>, "EV_FIGURE_STAR")
			Result.force (<<"figure","text","string">>, "EV_FIGURE_TEXT")
			Result.force (<<"figure","world","group","universe","system">>, "EV_FIGURE_WORLD")
			Result.force (<<"point","handle","move","resize","grab">>, "EV_MOVE_HANDLE")
			Result.force (<<"figure","points">>, "EV_MULTI_POINTED_FIGURE")
			Result.force (<<"figures","project","pointer","drawing","points">>, "EV_PIXMAP_PROJECTOR")
			Result.force (<<"postscript","page","size","dimensions">>, "EV_POSTSCRIPT_PAGE_CONSTANTS")
			Result.force (<<"projector","events","postscript">>, "EV_POSTSCRIPT_PROJECTOR")
			Result.force (<<"projector","events","routines">>, "EV_PROJECTION_ROUTINES")
			Result.force (<<"projector","world","figure">>, "EV_PROJECTOR")
			Result.force (<<"point","position","location","origin">>, "EV_RELATIVE_POINT")
			Result.force (<<"figure","point">>, "EV_SINGLE_POINTED_FIGURE")
			Result.force (<<"projector","events">>, "EV_WIDGET_PROJECTOR")
			Result.force (<<"math","table">>, "LOOKUP_DOUBLE_MATH")
			Result.force (<<"menu","item","check","select","deselect","uncheck">>, "EV_CHECK_MENU_ITEM")
			Result.force (<<"tree","item","dynamic">>, "EV_DYNAMIC_TREE_ITEM")
			Result.force (<<"item">>, "EV_ITEM")
			Result.force (<<"list","item","combo">>, "EV_LIST_ITEM")
			Result.force (<<"menu","item","dropdown","popup">>, "EV_MENU_ITEM")
			Result.force (<<"menu","item","separator">>, "EV_MENU_SEPARATOR")
			Result.force (<<"multi column list","row","item","select">>, "EV_MULTI_COLUMN_LIST_ROW")
			Result.force (<<"radio","item","menu","check","select","unselect">>, "EV_RADIO_MENU_ITEM")
			Result.force (<<"menu","item","check","select">>, "EV_SELECT_MENU_ITEM")
			Result.force (<<"status","bar","report","message">>, "EV_STATUS_BAR_ITEM")
			Result.force (<<>>, "EV_TOOL_BAR_BUTTON")
			Result.force (<<>>, "EV_TOOL_BAR_ITEM")
			Result.force (<<"toggle","button","tool","bar">>, "EV_TOOL_BAR_RADIO_BUTTON")
			Result.force (<<"state","toggle","button">>, "EV_TOOL_BAR_SELECT_BUTTON")
			Result.force (<<"separator","tool","bar","line","devide">>, "EV_TOOL_BAR_SEPARATOR")
			Result.force (<<"tool","bar","toggle","button">>, "EV_TOOL_BAR_TOGGLE_BUTTON")
			Result.force (<<"tree","item","leaf","node","branch">>, "EV_TREE_ITEM")
			Result.force (<<"tree","item","leaf","node","branch">>, "EV_TREE_NODE")
			Result.force (<<"accelerator","keyboard","key","shortcut","hotkey">>, "EV_ACCELERATOR")
			Result.force (<<"interface","base","root","any">>, "EV_ANY")
			Result.force (<<"application","accelerator","event loop">>, "EV_APPLICATION")
			Result.force (<<>>, "EV_CLIPBOARD")
			Result.force (<<"color","pixel","rgb","8","16","24">>, "EV_COLOR")
			Result.force (<<>>, "EV_COORDINATES")
			Result.force (<<"mouse","pointer","cursor","arrow">>, "EV_CURSOR")
			Result.force (<<>>, "EV_CURSOR_CODE")
			Result.force (<<"environment","application","global","system">>, "EV_ENVIRONMENT")
			Result.force (<<"character","face","height","family","weight","shape","bold","italic">>, "EV_FONT")
			Result.force (<<"character","face","size","family","weight","shape","bold","italic">>, "EV_FONT_CONSTANTS")
			Result.force (<<>>, "EV_FONT_CONSTANTS")
			Result.force (<<>>, "EV_KEY")
			Result.force (<<"key","code","constant">>, "EV_KEY_CONSTANTS")
			Result.force (<<"application","accelerator","event loop">>, "EV_OLD_APPLICATION")
			Result.force (<<>>, "EV_RECTANGLE")
			Result.force (<<"application","accelerator","event loop">>, "EV_SIMPLE_APPLICATION")
			Result.force (<<"timout","delay","timer","background">>, "EV_TIMEOUT")
			Result.force (<<"pick and drop","figure","widget","item">>, "EV_ABSTRACT_PICK_AND_DROPABLE")
			Result.force (<<"color","colored","colorable","colorizable","colorize">>, "EV_COLORIZABLE")
			Result.force (<<"parentable","containable","child">>, "EV_CONTAINABLE")
			Result.force (<<"deselect","deselectable","select","selected","selectable">>, "EV_DESELECTABLE")
			Result.force (<<"figure","primitive","drawing","line","point","ellipse">>, "EV_DRAWABLE")
			Result.force (<<"figures","primitives","drawing","line","point","ellipse">>, "EV_DRAWABLE_CONSTANTS")
			Result.force (<<"font","name","property">>, "EV_FONTABLE")
			Result.force (<<"help">>, "EV_HELP_CONTEXTABLE")
			Result.force (<<"pick and drop","drag and drop","source","PND","DND">>, "EV_PICK_AND_DROPABLE")
			Result.force (<<"pixmap","bitmap","icon","graphic","image">>, "EV_PIXMAPABLE")
			Result.force (<<"position","width","height">>, "EV_POSITIONABLE")
			Result.force (<<"position","width","height">>, "EV_POSITIONED")
			Result.force (<<"select","selected","selectable">>, "EV_SELECTABLE")
			Result.force (<<"sensitive","sensitivity","input">>, "EV_SENSITIVE")
			Result.force (<<"text","aligment">>, "EV_TEXT_ALIGNMENT")
			Result.force (<<"text","aligment","vertical","horizontal">>, "EV_TEXT_RICH_ALIGNMENT")
			Result.force (<<"text","label","font","name","property">>, "EV_TEXTABLE")
			Result.force (<<"tooltip","popup","hint">>, "EV_TOOLTIPABLE")
			Result.force (<<>>, "EV_ACCELERATOR_LIST")
			Result.force (<<>>, "EV_BMP_FORMAT")
			Result.force (<<"color","default">>, "EV_STOCK_COLORS")
			Result.force (<<"font","default">>, "EV_STOCK_FONTS")
			Result.force (<<"pixmap","default">>, "EV_STOCK_PIXMAPS")
			Result.force (<<"widget list","item list","container","dynamic","set","any">>, "EV_DYNAMIC_LIST[G->EV_CONTAINABLE]")
			Result.force (<<"container","list","cursor">>, "EV_DYNAMIC_LIST_CURSOR[G]")
			Result.force (<<>>, "EV_GRAPHICAL_FORMAT")
			Result.force (<<>>, "EV_HELP_CONTEXT")
			Result.force (<<>>, "EV_HELP_ENGINE")
			Result.force (<<"item","list">>, "EV_ITEM_LIST[G->EV_ITEM]")
			Result.force (<<>>, "EV_PNG_FORMAT")
			Result.force (<<>>, "EV_PRINT_CONTEXT")
			Result.force (<<"printer","output","projector">>, "EV_PRINT_PROJECTOR")
			Result.force (<<"radio","item","menu","check","select">>, "EV_RADIO_PEER")
			Result.force (<<>>, "EV_RAW_IMAGE_DATA")
			Result.force (<<>>, "EV_SIMPLE_HELP_CONTEXT")
			Result.force (<<>>, "EV_SIMPLE_HELP_ENGINE")
			Result.force (<<>>, "EV_TESTABLE_NON_WIDGET")
			Result.force (<<>>, "EV_TREE_NODE_LIST")
			Result.force (<<>>, "EV_COLOR_DIALOG")
			Result.force (<<>>, "EV_CONFIRMATION_DIALOG")
			Result.force (<<>>, "EV_DIRECTORY_DIALOG")
			Result.force (<<>>, "EV_ERROR_DIALOG")
			Result.force (<<>>, "EV_FILE_DIALOG")
			Result.force (<<>>, "EV_FILE_OPEN_DIALOG")
			Result.force (<<>>, "EV_FILE_SAVE_DIALOG")
			Result.force (<<>>, "EV_FONT_DIALOG")
			Result.force (<<>>, "EV_INFORMATION_DIALOG")
			Result.force (<<>>, "EV_INPUT_DEVICE_DIALOG")
			Result.force (<<>>, "EV_INPUT_DIALOG")
			Result.force (<<"dialog","standard","pixmap","text","button","modal">>, "EV_MESSAGE_DIALOG")
			Result.force (<<>>, "EV_PRINT_DIALOG")
			Result.force (<<>>, "EV_QUESTION_DIALOG")
			Result.force (<<>>, "EV_SELECTION_DIALOG")
			Result.force (<<"modal","ok","cancel">>, "EV_STANDARD_DIALOG")
			Result.force (<<>>, "EV_WARNING_DIALOG")
			Result.force (<<"widget","component","control">>, "EV_WIDGET")
			Result.force (<<"container","horizontal","box">>, "EV_AGGREGATE_BOX")
			Result.force (<<"container">>, "EV_AGGREGATE_CELL")
			Result.force (<<"container">>, "EV_ALIGNMENT")
			Result.force (<<"box","container","child">>, "EV_BOX")
			Result.force (<<"container">>, "EV_CELL")
			Result.force (<<"container","pack">>, "EV_CONTAINER")
			Result.force (<<"dialog","dialogue","popup","window">>, "EV_DIALOG")
			Result.force (<<"container","fixed","custom">>, "EV_FIXED")
			Result.force (<<"container","frame","box","border","bevel","outline","raised","lowered">>, "EV_FRAME")
			Result.force (<<"frame","bevel","outline","raised","lowered">>, "EV_FRAME_CONSTANTS")
			Result.force (<<"container","horizontal","box">>, "EV_HORIZONTAL_BOX")
			Result.force (<<>>, "EV_HORIZONTAL_SPLIT_AREA")
			Result.force (<<"menu","bar","drop down","popup">>, "EV_MENU_ITEM_LIST")
			Result.force (<<>>, "EV_NOTEBOOK")
			Result.force (<<"container","scroll","scrollbar","viewport">>, "EV_SCROLLABLE_AREA")
			Result.force (<<"container","split","devide">>, "EV_SPLIT_AREA")
			Result.force (<<>>, "EV_TABLE")
			Result.force (<<"window","title bar","title">>, "EV_TITLED_WINDOW")
			Result.force (<<"container">>, "EV_TREE_NODE_CONTAINER")
			Result.force (<<"container","box","vertical">>, "EV_VERTICAL_BOX")
			Result.force (<<>>, "EV_VERTICAL_SPLIT_AREA")
			Result.force (<<"container","virtual","display">>, "EV_VIEWPORT")
			Result.force (<<"widget list","container">>, "EV_WIDGET_LIST")
			Result.force (<<"container","widget list","cursor">>, "EV_WIDGET_LIST_CURSOR")
			Result.force (<<"toplevel","window","popup">>, "EV_WINDOW")
			Result.force (<<"press","push","label","pixmap">>, "EV_BUTTON")
			Result.force (<<"toggle","check","tick","button","box">>, "EV_CHECK_BUTTON")
			Result.force (<<"combo","box","button","option","menu">>, "EV_COMBO_BOX")
			Result.force (<<"drawable","expose","primitive","figure","draw","paint","image">>, "EV_DRAWING_AREA")
			Result.force (<<"value","step","increment","range">>, "EV_GAUGE")
			Result.force (<<"status","progress","bar","horizontal">>, "EV_HORIZONTAL_PROGRESS_BAR")
			Result.force (<<"range","slide","adjust">>, "EV_HORIZONTAL_RANGE")
			Result.force (<<"horizontal","scroll","bar","gauge">>, "EV_HORIZONTAL_SCROLL_BAR")
			Result.force (<<"seperator","horizontal","line","score">>, "EV_HORIZONTAL_SEPARATOR")
			Result.force (<<"label","text">>, "EV_LABEL")
			Result.force (<<"list","select","menu">>, "EV_LIST")
			Result.force (<<"list","list_item">>, "EV_LIST_ITEM_LIST")
			Result.force (<<"list","multi","column","row","table">>, "EV_MULTI_COLUMN_LIST")
			Result.force (<<"button","menu","option","drop down","popup">>, "EV_OPTION_BUTTON")
			Result.force (<<>>, "EV_PASSWORD_FIELD")
			Result.force (<<"widget","primitive">>, "EV_PRIMITIVE")
			Result.force (<<"status","progress","bar">>, "EV_PROGRESS_BAR")
			Result.force (<<"toggle","radio","button">>, "EV_RADIO_BUTTON")
			Result.force (<<"range","slide","adjust">>, "EV_RANGE")
			Result.force (<<"label","text","fontable","rich","bold","italic">>, "EV_RICH_LABEL")
			Result.force (<<"scroll","bar","horizontal","vertical","gauge","leap","step","page">>, "EV_SCROLL_BAR")
			Result.force (<<"state","toggle","button">>, "EV_SELECT_BUTTON")
			Result.force (<<"separator","line","score">>, "EV_SEPARATOR")
			Result.force (<<"gauge","edit","text","number","up","down">>, "EV_SPIN_BUTTON")
			Result.force (<<>>, "EV_TEXT")
			Result.force (<<>>, "EV_TEXT_COMPONENT")
			Result.force (<<"input","text","field","query">>, "EV_TEXT_FIELD")
			Result.force (<<"toggle","button">>, "EV_TOGGLE_BUTTON")
			Result.force (<<>>, "EV_TOOL_BAR")
			Result.force (<<"tree","container">>, "EV_TREE")
			Result.force (<<"status","progress","bar","vertical">>, "EV_VERTICAL_PROGRESS_BAR")
			Result.force (<<>>, "EV_VERTICAL_RANGE")
			Result.force (<<>>, "EV_VERTICAL_SCROLL_BAR")
			Result.force (<<>>, "EV_VERTICAL_SEPARATOR")
			Result.force (<<"menu","bar","drop down","popup">>, "EV_MENU")
			Result.force (<<"menu","bar","item","file","edit","help">>, "EV_MENU_BAR")
			Result.force (<<"drawable","primitives","figures","buffer","bitmap","picture">>, "EV_PIXMAP")
			Result.force (<<"screen","root","window","visual","top">>, "EV_SCREEN")
			Result.force (<<>>, "EV_STATUS_BAR")
		end

	classes_by_keyword: HASH_TABLE [LINKED_LIST [STRING], STRING] is
			-- Table of classes by keyword.
		local
			kwt: HASH_TABLE [ARRAY [STRING], STRING]
			kws: ARRAY [STRING]
			kwd: STRING
			cls: STRING
			i: INTEGER
			c: CURSOR
		once
			create Result.make(100)
			kwt := class_keywords
			c := kwt.cursor
			from
				kwt.start
			until
				kwt.after
			loop
				from
					kws := kwt.item_for_iteration
					cls := kwt.key_for_iteration
					i := 1
				until
					i > kws.count
				loop
					kwd := kws.item	(i)
					if Result.item (kwd) = Void then
						Result.put (create {LINKED_LIST [STRING]}.make, kwd)
					end
					Result.item (kwd).extend (cls)
					i := i + 1
				end
				kwt.forth
			end
			kwt.go_to (c)
		end

end -- class EV_INTERNAL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license.
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
