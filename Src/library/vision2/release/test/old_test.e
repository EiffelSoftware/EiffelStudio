class
	OLD_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature
	
	make_and_launch is
		do
			default_create
			prepare
			launch
		end

	first_window: EV_TITLED_WINDOW

	test_cb is
		do
			if EV_TREE_OBJECT.selected_item /= Void then
				print (EV_TREE_OBJECT.selected_item.text +"%N")
			else
				print ("Selected item is void")
			end
		end

			EV_TREE_OBJECT: EV_TREE

	prepare is
		local
			main_split: EV_VERTICAL_SPLIT_AREA
			notebook: EV_NOTEBOOK
			widget_tool_box: EV_VERTICAL_BOX
			textable_tool_box: EV_VERTICAL_BOX
			tree_tool: EV_LABEL
			hb: EV_HORIZONTAL_BOX
			label, label2: EV_LABEL
			button: EV_BUTTON
			frame: EV_FRAME
			i: INTEGER
			widgets: LINKED_LIST [EV_WIDGET]
			textable: EV_TEXTABLE
			pixmapable: EV_PIXMAPABLE
			container: EV_CONTAINER
			wnotebook: EV_NOTEBOOK
			box: EV_HORIZONTAL_BOX
			proc_box: EV_VERTICAL_BOX
			ev_proc: EV_PROCEDURE_WIDGET [OLD_TEST, TUPLE [EV_LABEL, EV_WIDGET]]

			EV_GDK_FONT_OBJECT: EV_GDK_FONT
			ASSIGN_ATTEMPT_OBJECT: ASSIGN_ATTEMPT [REAL]
			EV_C_EXTERNALS_OBJECT: EV_C_EXTERNALS
			EV_C_GTK_OBJECT: EV_C_GTK
			EV_GDK_FONT_EXTERNALS_OBJECT: EV_GDK_FONT_EXTERNALS
			EV_GLIB_EXTERNALS_OBJECT: EV_GLIB_EXTERNALS
			EV_GTK_BUTTONS_EXTERNALS_OBJECT: EV_GTK_BUTTONS_EXTERNALS
			EV_GTK_CALLBACK_MARSHAL_OBJECT: EV_GTK_CALLBACK_MARSHAL
			EV_GTK_CONTAINERS_EXTERNALS_OBJECT: EV_GTK_CONTAINERS_EXTERNALS
			EV_GTK_DRAWABLE_EXTERNALS_OBJECT: EV_GTK_DRAWABLE_EXTERNALS
			EV_GTK_GENERAL_EXTERNALS_OBJECT: EV_GTK_GENERAL_EXTERNALS
			EV_GTK_ITEMS_EXTERNALS_OBJECT: EV_GTK_ITEMS_EXTERNALS
			EV_GTK_TYPES_EXTERNALS_OBJECT: EV_GTK_TYPES_EXTERNALS
			EV_GTK_WIDGETS_EXTERNALS_OBJECT: EV_GTK_WIDGETS_EXTERNALS
			EV_RADIO_GROUP_OBJECT: EV_RADIO_GROUP
			EV_PND_ACTION_SEQUENCE_OBJECT: EV_PND_ACTION_SEQUENCE

	
			EV_FIGURE_ARC_OBJECT: EV_FIGURE_ARC
			EV_FIGURE_DOT_OBJECT: EV_FIGURE_DOT
			EV_FIGURE_DRAWER_OBJECT: EV_FIGURE_DRAWER
			EV_FIGURE_ELLIPSE_OBJECT: EV_FIGURE_ELLIPSE
			EV_FIGURE_EQUILATERAL_OBJECT: EV_FIGURE_EQUILATERAL
			EV_FIGURE_GROUP_OBJECT: EV_FIGURE_GROUP
			EV_FIGURE_LINE_OBJECT: EV_FIGURE_LINE
			EV_FIGURE_MATH_OBJECT: EV_FIGURE_MATH
			EV_FIGURE_PICTURE_OBJECT: EV_FIGURE_PICTURE
			EV_FIGURE_PIE_SLICE_OBJECT: EV_FIGURE_PIE_SLICE
			EV_FIGURE_POLYGON_OBJECT: EV_FIGURE_POLYGON
			EV_FIGURE_POLYLINE_OBJECT: EV_FIGURE_POLYLINE
			EV_FIGURE_RECTANGLE_OBJECT: EV_FIGURE_RECTANGLE
			EV_FIGURE_TEXT_OBJECT: EV_FIGURE_TEXT
			EV_FIGURE_TRIANGLE_OBJECT: EV_FIGURE_TRIANGLE
			EV_FIGURE_WORLD_OBJECT: EV_FIGURE_WORLD
			EV_PROJECTION_OBJECT: EV_PROJECTION
			EV_RELATIVE_POINT_OBJECT: EV_RELATIVE_POINT
			EV_STANDARD_PROJECTION_OBJECT: EV_STANDARD_PROJECTION
			EV_CHECK_MENU_ITEM_OBJECT: EV_CHECK_MENU_ITEM
			EV_LIST_ITEM_OBJECT: EV_LIST_ITEM
			EV_MENU_ITEM_OBJECT: EV_MENU_ITEM
			EV_MENU_SEPARATOR_OBJECT: EV_MENU_SEPARATOR
			EV_STATUS_BAR_ITEM_OBJECT: EV_STATUS_BAR_ITEM
			EV_TOOL_BAR_BUTTON_OBJECT: EV_TOOL_BAR_BUTTON
			EV_TOOL_BAR_SEPARATOR_OBJECT: EV_TOOL_BAR_SEPARATOR
			EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT: EV_TOOL_BAR_TOGGLE_BUTTON
			EV_TOOL_BAR_RADIO_BUTTON_OBJECT1: EV_TOOL_BAR_RADIO_BUTTON
			EV_TOOL_BAR_RADIO_BUTTON_OBJECT2: EV_TOOL_BAR_RADIO_BUTTON
			EV_ACCELERATOR_OBJECT: EV_ACCELERATOR
			EV_COLOR_OBJECT: EV_COLOR
			EV_COORDINATES_OBJECT: EV_COORDINATES
			EV_CURSOR_OBJECT: EV_CURSOR
			EV_CURSOR_CODE_OBJECT: EV_CURSOR_CODE
			EV_ENVIRONMENT_OBJECT: EV_ENVIRONMENT
			EV_FONT_OBJECT: EV_FONT
			EV_FONT_CONSTANTS_OBJECT: EV_FONT_CONSTANTS
			EV_KEY_CODE_OBJECT: EV_KEY_CODE
			EV_RECTANGLE_OBJECT: EV_RECTANGLE
			EV_TIMEOUT_OBJECT: EV_TIMEOUT
			EV_DRAWABLE_CONSTANTS_OBJECT: EV_DRAWABLE_CONSTANTS
			EV_BASIC_COLORS_OBJECT: EV_BASIC_COLORS
			EV_DEFAULT_COLORS_OBJECT: EV_DEFAULT_COLORS
			EV_DIRECTORY_DIALOG_OBJECT: EV_DIRECTORY_DIALOG
			EV_ERROR_DIALOG_OBJECT: EV_ERROR_DIALOG
			EV_FILE_OPEN_DIALOG_OBJECT: EV_FILE_OPEN_DIALOG
			EV_FILE_SAVE_DIALOG_OBJECT: EV_FILE_SAVE_DIALOG
			EV_INFORMATION_DIALOG_OBJECT: EV_INFORMATION_DIALOG
			EV_MESSAGE_DIALOG_OBJECT: EV_MESSAGE_DIALOG
			EV_QUESTION_DIALOG_OBJECT: EV_QUESTION_DIALOG
			EV_WARNING_DIALOG_OBJECT: EV_WARNING_DIALOG
			EV_AGGREGATE_BOX_OBJECT: EV_AGGREGATE_BOX
			EV_CELL_OBJECT: EV_CELL
			EV_DIALOG_OBJECT: EV_DIALOG
			EV_FRAME_OBJECT: EV_FRAME
			EV_HORIZONTAL_BOX_OBJECT: EV_HORIZONTAL_BOX
			EV_HORIZONTAL_SPLIT_AREA_OBJECT: EV_HORIZONTAL_SPLIT_AREA
			EV_NOTEBOOK_OBJECT: EV_NOTEBOOK
			EV_SCROLLABLE_AREA_OBJECT: EV_SCROLLABLE_AREA
			EV_TITLED_WINDOW_OBJECT: EV_TITLED_WINDOW
			EV_VERTICAL_BOX_OBJECT: EV_VERTICAL_BOX
			EV_VERTICAL_SPLIT_AREA_OBJECT: EV_VERTICAL_SPLIT_AREA
			EV_VIEWPORT_OBJECT: EV_VIEWPORT
			EV_WIDGET_LIST_CURSOR_OBJECT: EV_WIDGET_LIST_CURSOR
			EV_WINDOW_OBJECT: EV_WINDOW
			EV_BUTTON_OBJECT: EV_BUTTON
			EV_CHECK_BUTTON_OBJECT: EV_CHECK_BUTTON
			EV_DRAWING_AREA_OBJECT: EV_DRAWING_AREA
			EV_HORIZONTAL_PROGRESS_BAR_OBJECT: EV_HORIZONTAL_PROGRESS_BAR
			EV_HORIZONTAL_RANGE_OBJECT: EV_HORIZONTAL_RANGE
			EV_HORIZONTAL_SCROLL_BAR_OBJECT: EV_HORIZONTAL_SCROLL_BAR
			EV_HORIZONTAL_SEPARATOR_OBJECT: EV_HORIZONTAL_SEPARATOR
			EV_LABEL_OBJECT: EV_LABEL
			EV_LIST_OBJECT: EV_LIST
			--EV_OPTION_BUTTON_OBJECT: EV_OPTION_BUTTON
			EV_SPIN_BUTTON_OBJECT: EV_SPIN_BUTTON
			EV_TEXT_FIELD_OBJECT: EV_TEXT_FIELD
			EV_TOGGLE_BUTTON_OBJECT: EV_TOGGLE_BUTTON
			EV_TOOL_BAR_OBJECT: EV_TOOL_BAR
			EV_VERTICAL_PROGRESS_BAR_OBJECT: EV_VERTICAL_PROGRESS_BAR
			EV_VERTICAL_RANGE_OBJECT: EV_VERTICAL_RANGE
			EV_VERTICAL_SCROLL_BAR_OBJECT: EV_VERTICAL_SCROLL_BAR
			EV_VERTICAL_SEPARATOR_OBJECT: EV_VERTICAL_SEPARATOR
			EV_MENU_OBJECT: EV_MENU
			EV_MENU_BAR_OBJECT: EV_MENU_BAR
			EV_PIXMAP_OBJECT: EV_PIXMAP
			EV_SCREEN_OBJECT: EV_SCREEN
			EV_STATUS_BAR_OBJECT: EV_STATUS_BAR
			EV_C_UTIL_OBJECT: EV_C_UTIL
			EV_GDK_EXTERNALS_OBJECT: EV_GDK_EXTERNALS
			EV_GDK_KEYSYMS_EXTERNALS_OBJECT: EV_GDK_KEYSYMS_EXTERNALS
			EV_GTK_CONSTANTS_OBJECT: EV_GTK_CONSTANTS
			EV_GTK_EXTERNALS_OBJECT: EV_GTK_EXTERNALS
			EV_NOTIFY_ACTION_SEQUENCE_OBJECT: EV_NOTIFY_ACTION_SEQUENCE
			EV_POINTER_BUTTON_ACTION_SEQUENCE_OBJECT: EV_POINTER_BUTTON_ACTION_SEQUENCE
			EV_POINTER_BUTTON_LEFT_PRESS_ACTION_SEQUENCE_OBJECT: EV_POINTER_BUTTON_LEFT_PRESS_ACTION_SEQUENCE
			EV_POINTER_MOTION_ACTION_SEQUENCE_OBJECT: EV_POINTER_MOTION_ACTION_SEQUENCE
			EV_PROXIMITY_ACTION_SEQUENCE_OBJECT: EV_PROXIMITY_ACTION_SEQUENCE
			EV_ACCELERATOR_ACTION_SEQUENCE_OBJECT: EV_ACCELERATOR_ACTION_SEQUENCE
			EV_KEY_ACTION_SEQUENCE_OBJECT: EV_KEY_ACTION_SEQUENCE
			EV_GEOMETRY_ACTION_SEQUENCE_OBJECT: EV_GEOMETRY_ACTION_SEQUENCE
			EV_PND_START_ACTION_SEQUENCE_OBJECT: EV_PND_START_ACTION_SEQUENCE
			EV_ITEM_SELECT_ACTION_SEQUENCE_OBJECT: EV_ITEM_SELECT_ACTION_SEQUENCE
			EV_FOCUS_ACTION_SEQUENCE_OBJECT: EV_FOCUS_ACTION_SEQUENCE
			pixfile: RAW_FILE
			EV_COMBO_BOX_OBJECT: EV_COMBO_BOX
			counter: INTEGER
			EV_MULTI_COLUMN_LIST_OBJECT: EV_MULTI_COLUMN_LIST
			EV_MULTI_COLUMN_LIST_ROW_OBJECT: EV_MULTI_COLUMN_LIST_ROW
			EV_TREE_ITEM_OBJECT: EV_TREE_ITEM
			EV_TREE_ITEM_OBJECT2: EV_TREE_ITEM

		do
			create first_window
			create main_split
			first_window.extend (main_split)

			create EV_SCROLLABLE_AREA_OBJECT
			EV_SCROLLABLE_AREA_OBJECT.set_vertical_step (50)
			EV_SCROLLABLE_AREA_OBJECT.set_horizontal_step (50)
			print ("Vertical step = " + EV_SCROLLABLE_AREA_OBJECT.vertical_step.out+"%N")
			create frame
			frame.set_text ("Eiffel Vision Widgets")

			EV_SCROLLABLE_AREA_OBJECT.extend (frame)
			main_split.extend (EV_SCROLLABLE_AREA_OBJECT)

			create wnotebook
			frame.extend  (wnotebook)

			create notebook
			main_split.extend (notebook)

			create widget_tool_box
			notebook.extend (widget_tool_box)
			notebook.set_item_text (widget_tool_box, "Widget tool")

			create textable_tool_box
			notebook.extend (textable_tool_box)
			notebook.set_item_text (notebook.last, "Textable widget tool")

			create box

			notebook.extend (box)
			notebook.set_item_text (box, "Box in a box in a box ...")

			create proc_box
			notebook.extend (proc_box)
			notebook.set_item_text (proc_box, "Procedure widgets")
			create ev_proc.make (
				~widget_tool_update,
				"widget_tool_update",
				<<"lab", "w">>
			)
			proc_box.extend (ev_proc)
			proc_box.extend (create {EV_PROCEDURE_WIDGET [EV_TEXTABLE, TUPLE [EV_TEXTABLE, STRING]]}.make (
				{EV_TEXTABLE}~set_text,
				"set_text",
				<<"textable", "text">>
			))
			proc_box.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_WIDGET]]}.make (
				{EV_CONTAINER}~extend,
				"extend",
				<<"container", "widget">>
			))
			proc_box.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make (
				{EV_WIDGET}~destroy,
				"destroy",
				<<"widget">>
			))
			proc_box.extend (create {EV_HORIZONTAL_SPLIT_AREA})
			proc_box.last.set_pebble (proc_box.last)

			widget_tool_box.extend (create {EV_LABEL}.make_with_text ("Drop here!"))
			label ?= widget_tool_box.last
			widget_tool_box.extend (create {EV_LABEL})
			label2 ?= widget_tool_box.last

			label2.align_text_left
			widget_tool_box.disable_child_expand (label)
			widget_tool_box.disable_child_expand (label2)
			label.drop_actions.extend (~widget_tool_update (label2, ?))

			textable_tool_box.extend (create {EV_LABEL}.make_with_text ("Drop here!"))
			label ?= textable_tool_box.last
			textable_tool_box.extend (create {EV_LABEL})
			label2 ?= textable_tool_box.last

			textable_tool_box.disable_child_expand (label)
			label.drop_actions.extend (~textable_tool_update (label2, ?))
			label.drop_actions.extend (~text_field_tool_update (label2, ?))

			create widgets.make
			create EV_PIXMAP_OBJECT
				create pixfile.make_open_read ("/var/sw/Eiffel46/bench/bitmaps/xpm/open.xpm")
				EV_PIXMAP_OBJECT.set_with_file (pixfile)
				widgets.extend (EV_PIXMAP_OBJECT)


	
			create EV_TREE_OBJECT

			create EV_TREE_ITEM_OBJECT
			EV_TREE_ITEM_OBJECT.set_text ("Tree item 1")
			EV_TREE_ITEM_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
			EV_TREE_OBJECT.extend (EV_TREE_ITEM_OBJECT)
			
			EV_TREE_OBJECT.start
			EV_TREE_OBJECT.item.expand_actions.extend (~print ("Item expanded%N"))
			
			from counter := 1
			EV_TREE_OBJECT.start
			until counter > 10
			loop
				create EV_TREE_ITEM_OBJECT
				EV_TREE_ITEM_OBJECT.set_text ("Sub Tree item "+counter.out)
				EV_TREE_ITEM_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
				EV_TREE_OBJECT.item.extend (EV_TREE_ITEM_OBJECT)
				counter := counter + 1
			end
			
			create EV_TREE_ITEM_OBJECT
			EV_TREE_ITEM_OBJECT.set_text ("IEK")
			EV_TREE_OBJECT.extend (EV_TREE_ITEM_OBJECT)
			create EV_TREE_ITEM_OBJECT2
			EV_TREE_ITEM_OBJECT2.set_text ("IEK Sub item")
			EV_TREE_ITEM_OBJECT.extend (EV_TREE_ITEM_OBJECT2)
			EV_TREE_ITEM_OBJECT.expand
	
			widgets.extend (EV_TREE_OBJECT)


			create EV_MULTI_COLUMN_LIST_OBJECT
				widgets.extend (EV_MULTI_COLUMN_LIST_OBJECT)

			from
				counter := 1
			until
				counter > 100
			loop
				create EV_MULTI_COLUMN_LIST_ROW_OBJECT
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.select_actions.extend (~test_cb)
EV_MULTI_COLUMN_LIST_ROW_OBJECT.deselect_actions.extend (~print ("Item "+counter.out+ " deselected%N"))
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_columns (10)
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_pixmap (1, EV_PIXMAP_OBJECT)
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (1, counter.out +" Multi")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (2, "Column")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (3, "List")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (4, "appears")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (5, "to")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (6, "be")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (7, "bloody")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (8, "working")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (9, "at")
				EV_MULTI_COLUMN_LIST_ROW_OBJECT.set_cell_text (10, "last")
				EV_MULTI_COLUMN_LIST_OBJECT.extend (EV_MULTI_COLUMN_LIST_ROW_OBJECT)
				counter := counter + 1
			end

			from EV_MULTI_COLUMN_LIST_OBJECT.start
			until EV_MULTI_COLUMN_LIST_OBJECT.after
			loop
				EV_MULTI_COLUMN_LIST_OBJECT.item.set_cell_text (7, "nearly")
				EV_MULTI_COLUMN_LIST_OBJECT.forth
			end

			from counter := 1
			until counter > 10
			loop
				EV_MULTI_COLUMN_LIST_OBJECT.set_column_title (("Column "+counter.out), counter)
				counter := counter + 1
			end

			EV_MULTI_COLUMN_LIST_OBJECT.column_click_actions.extend (~print ("Column clicked%N"))

			create EV_STATUS_BAR_OBJECT
			first_window.set_status_bar (EV_STATUS_BAR_OBJECT)
			first_window.set_title ("EiffelVision Widget Test")

			create EV_STATUS_BAR_ITEM_OBJECT
			EV_STATUS_BAR_ITEM_OBJECT.set_text ("EV_STATUS_BAR_ITEM 1")
			EV_STATUS_BAR_ITEM_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
			EV_STATUS_BAR_OBJECT.extend (EV_STATUS_BAR_ITEM_OBJECT)

			create EV_STATUS_BAR_ITEM_OBJECT
			EV_STATUS_BAR_ITEM_OBJECT.set_text ("EV_STATUS_BAR_ITEM 2")
			EV_STATUS_BAR_ITEM_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
			EV_STATUS_BAR_OBJECT.extend (EV_STATUS_BAR_ITEM_OBJECT)

			create ASSIGN_ATTEMPT_OBJECT
			create EV_C_EXTERNALS_OBJECT
			create EV_C_GTK_OBJECT
			create EV_GDK_FONT_EXTERNALS_OBJECT
			create EV_GLIB_EXTERNALS_OBJECT
			create EV_GTK_BUTTONS_EXTERNALS_OBJECT
			create EV_GTK_CALLBACK_MARSHAL_OBJECT
			create EV_GTK_CONTAINERS_EXTERNALS_OBJECT
			create EV_GTK_DRAWABLE_EXTERNALS_OBJECT
			create EV_GTK_GENERAL_EXTERNALS_OBJECT
			create EV_GTK_ITEMS_EXTERNALS_OBJECT
			create EV_GTK_TYPES_EXTERNALS_OBJECT
			create EV_GTK_WIDGETS_EXTERNALS_OBJECT
--FIMXE			create EV_RADIO_GROUP_OBJECT
			create EV_PND_ACTION_SEQUENCE_OBJECT


			create EV_FIGURE_ARC_OBJECT
			create EV_FIGURE_DOT_OBJECT
--FIMXE			create EV_FIGURE_DRAWER_OBJECT
			create EV_FIGURE_ELLIPSE_OBJECT
			create EV_FIGURE_EQUILATERAL_OBJECT
			create EV_FIGURE_GROUP_OBJECT
			create EV_FIGURE_LINE_OBJECT
			create EV_FIGURE_MATH_OBJECT
--FIXME BUG			create EV_FIGURE_PICTURE_OBJECT
			create EV_FIGURE_PIE_SLICE_OBJECT
			create EV_FIGURE_POLYGON_OBJECT
			create EV_FIGURE_POLYLINE_OBJECT
			create EV_FIGURE_RECTANGLE_OBJECT
			create EV_FIGURE_TEXT_OBJECT
			create EV_FIGURE_TRIANGLE_OBJECT
			create EV_FIGURE_WORLD_OBJECT
--FIMXE			create EV_PROJECTION_OBJECT
			create EV_RELATIVE_POINT_OBJECT
--FIMXE			create EV_STANDARD_PROJECTION_OBJECT
			create EV_CHECK_MENU_ITEM_OBJECT
			create EV_LIST_ITEM_OBJECT
			create EV_MENU_ITEM_OBJECT
			create EV_MENU_SEPARATOR_OBJECT

			create EV_TOOL_BAR_OBJECT
				--widgets.extend (EV_TOOL_BAR_OBJECT)
			create EV_SCROLLABLE_AREA_OBJECT
				EV_SCROLLABLE_AREA_OBJECT.extend (EV_TOOL_BAR_OBJECT)
				EV_SCROLLABLE_AREA_OBJECT.hide_vertical_scrollbar
			widgets.extend (EV_SCROLLABLE_AREA_OBJECT)

			create EV_TOOL_BAR_BUTTON_OBJECT
			EV_TOOL_BAR_BUTTON_OBJECT.set_text ("TOOL BAR%NBUTTON")
			EV_TOOL_BAR_BUTTON_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
			EV_TOOL_BAR_OBJECT.extend (EV_TOOL_BAR_BUTTON_OBJECT)

			create EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT
			EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT.set_text ("TOOL BAR%NTOGGLE%NBUTTON")
			EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
			EV_TOOL_BAR_OBJECT.extend (EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT)

			create EV_TOOL_BAR_SEPARATOR_OBJECT
			EV_TOOL_BAR_OBJECT.extend (EV_TOOL_BAR_SEPARATOR_OBJECT)

			create EV_TOOL_BAR_RADIO_BUTTON_OBJECT1
			EV_TOOL_BAR_RADIO_BUTTON_OBJECT1.set_text ("TOOL BAR%NRADIO%NBUTTON")
			EV_TOOL_BAR_RADIO_BUTTON_OBJECT1.set_pixmap (EV_PIXMAP_OBJECT)
			EV_TOOL_BAR_OBJECT.extend (EV_TOOL_BAR_RADIO_BUTTON_OBJECT1)
			
			create EV_TOOL_BAR_RADIO_BUTTON_OBJECT2
			--EV_TOOL_BAR_RADIO_BUTTON_OBJECT1.set_peer (EV_TOOL_BAR_RADIO_BUTTON_OBJECT2)
			EV_TOOL_BAR_OBJECT.extend (EV_TOOL_BAR_RADIO_BUTTON_OBJECT2)
			EV_TOOL_BAR_RADIO_BUTTON_OBJECT2.set_text ("TOOL BAR%NRADIO%NBUTTON")
			EV_TOOL_BAR_RADIO_BUTTON_OBJECT2.set_pixmap (EV_PIXMAP_OBJECT)


--FIXME BUG			create EV_ACCELERATOR_OBJECT
			create EV_COLOR_OBJECT
			create EV_COORDINATES_OBJECT
			create EV_CURSOR_OBJECT
--FIMXE			create EV_CURSOR_CODE_OBJECT
			create EV_ENVIRONMENT_OBJECT
			create EV_FONT_OBJECT
			create EV_FONT_CONSTANTS_OBJECT
--FIXME			create EV_KEY_CODE_OBJECT
			create EV_RECTANGLE_OBJECT
			create EV_TIMEOUT_OBJECT
			create EV_DRAWABLE_CONSTANTS_OBJECT
			create EV_BASIC_COLORS_OBJECT
			create EV_DEFAULT_COLORS_OBJECT
			create EV_DIRECTORY_DIALOG_OBJECT
			create EV_ERROR_DIALOG_OBJECT
			create EV_FILE_OPEN_DIALOG_OBJECT
			create EV_FILE_SAVE_DIALOG_OBJECT
			create EV_INFORMATION_DIALOG_OBJECT
				widgets.extend (create {EV_BUTTON}.make_with_text_and_action (
						"EV_INFORMATION_DIALOG", EV_INFORMATION_DIALOG_OBJECT~show ))
			create EV_MESSAGE_DIALOG_OBJECT
				widgets.extend (create {EV_BUTTON}.make_with_text_and_action (
						"EV_MESSAGE_DIALOG", EV_MESSAGE_DIALOG_OBJECT~show ))
			create EV_QUESTION_DIALOG_OBJECT
				widgets.extend (create {EV_BUTTON}.make_with_text_and_action (
						"EV_QUESTION_DIALOG", EV_QUESTION_DIALOG_OBJECT~show))
			create EV_WARNING_DIALOG_OBJECT
				widgets.extend (create {EV_BUTTON}.make_with_text_and_action (
						"EV_WARNING_DIALOG", EV_WARNING_DIALOG_OBJECT~show))
			create EV_AGGREGATE_BOX_OBJECT
			create EV_DIALOG_OBJECT
				widgets.extend (create {EV_BUTTON}.make_with_text_and_action (
						"EV_DIALOG", EV_DIALOG_OBJECT~show ))
			create EV_CELL_OBJECT
				widgets.extend (EV_CELL_OBJECT)
			create EV_COMBO_BOX_OBJECT
				widgets.extend (EV_COMBO_BOX_OBJECT)
				EV_COMBO_BOX_OBJECT.return_actions.extend (~print ("Item selected" + "%N"))
				EV_COMBO_BOX_OBJECT.change_actions.extend (~print ("Text changed" + "%N"))

			from
				counter := 1
			until
				counter > 10
			loop
				create EV_LIST_ITEM_OBJECT
				EV_LIST_ITEM_OBJECT.set_text ("Combo box list item " + counter.out)
				EV_LIST_ITEM_OBJECT.align_text_left
				EV_LIST_ITEM_OBJECT.set_pixmap (EV_PIXMAP_OBJECT)
				EV_COMBO_BOX_OBJECT.extend (EV_LIST_ITEM_OBJECT)
				EV_LIST_ITEM_OBJECT.select_actions.extend (~print (EV_LIST_ITEM_OBJECT.text.out+" selected%N"))
				EV_LIST_ITEM_OBJECT.deselect_actions.extend (~print (EV_LIST_ITEM_OBJECT.text.out+" deselected%N"))
				counter := counter + 1
			end

--| FIXME IEK Replace fails on post-condition

	--		create EV_LIST_ITEM_OBJECT
	--		EV_LIST_ITEM_OBJECT.set_text ("Replaced at 1")
	--		EV_COMBO_BOX_OBJECT.start
	--		EV_COMBO_BOX_OBJECT.replace (EV_LIST_ITEM_OBJECT)

			create EV_FRAME_OBJECT
				widgets.extend (EV_FRAME_OBJECT)
			create EV_HORIZONTAL_BOX_OBJECT
				widgets.extend (EV_HORIZONTAL_BOX_OBJECT)
			create EV_HORIZONTAL_SPLIT_AREA_OBJECT
				widgets.extend (EV_HORIZONTAL_SPLIT_AREA_OBJECT)
			create EV_NOTEBOOK_OBJECT
				widgets.extend (EV_NOTEBOOK_OBJECT)
			create EV_TITLED_WINDOW_OBJECT
			create EV_VERTICAL_BOX_OBJECT
				widgets.extend (EV_VERTICAL_BOX_OBJECT)
			create EV_VERTICAL_SPLIT_AREA_OBJECT
				widgets.extend (EV_VERTICAL_SPLIT_AREA_OBJECT)
--FIXME			create EV_WIDGET_LIST_CURSOR_OBJECT
			create EV_WINDOW_OBJECT
			create EV_BUTTON_OBJECT
				widgets.extend (EV_BUTTON_OBJECT)
			create EV_CHECK_BUTTON_OBJECT
				widgets.extend (EV_CHECK_BUTTON_OBJECT)
			create EV_DRAWING_AREA_OBJECT
				widgets.extend (EV_DRAWING_AREA_OBJECT)
			create EV_HORIZONTAL_PROGRESS_BAR_OBJECT
				widgets.extend (EV_HORIZONTAL_PROGRESS_BAR_OBJECT)
			create EV_HORIZONTAL_RANGE_OBJECT
				widgets.extend (EV_HORIZONTAL_RANGE_OBJECT)
			create EV_HORIZONTAL_SCROLL_BAR_OBJECT
				widgets.extend (EV_HORIZONTAL_SCROLL_BAR_OBJECT)
			create EV_HORIZONTAL_SEPARATOR_OBJECT
				widgets.extend (EV_HORIZONTAL_SEPARATOR_OBJECT)
			create EV_LABEL_OBJECT
				widgets.extend (EV_LABEL_OBJECT)
			create EV_LIST_OBJECT
				widgets.extend (EV_LIST_OBJECT)
				EV_LIST_OBJECT.extend (create {EV_LIST_ITEM}.make_with_text ("item1"))
				EV_LIST_OBJECT.extend (create {EV_LIST_ITEM}.make_with_text ("item2"))
				EV_LIST_OBJECT.extend (create {EV_LIST_ITEM}.make_with_text ("item3"))
				EV_LIST_OBJECT.extend (create {EV_LIST_ITEM}.make_with_text ("item4"))
				EV_LIST_OBJECT.extend (create {EV_LIST_ITEM}.make_with_text ("item5"))

			from
				EV_LIST_OBJECT.start
			until
				EV_LIST_OBJECT.off
			loop
				EV_LIST_OBJECT.item.set_pixmap (EV_PIXMAP_OBJECT)
				EV_LIST_OBJECT.forth
			end
				
--FIXME			create EV_OPTION_BUTTON_OBJECT
			create EV_SPIN_BUTTON_OBJECT
				widgets.extend (EV_SPIN_BUTTON_OBJECT)
			create EV_TEXT_FIELD_OBJECT
				widgets.extend (EV_TEXT_FIELD_OBJECT)
			create EV_TOGGLE_BUTTON_OBJECT
				widgets.extend (EV_TOGGLE_BUTTON_OBJECT)

			create EV_VERTICAL_PROGRESS_BAR_OBJECT
				widgets.extend (EV_VERTICAL_PROGRESS_BAR_OBJECT)
			create EV_VERTICAL_RANGE_OBJECT
				widgets.extend (EV_VERTICAL_RANGE_OBJECT)
			create EV_VERTICAL_SCROLL_BAR_OBJECT
				widgets.extend (EV_VERTICAL_SCROLL_BAR_OBJECT)
			create EV_VERTICAL_SEPARATOR_OBJECT
				widgets.extend (EV_VERTICAL_SEPARATOR_OBJECT)
			create EV_MENU_BAR_OBJECT
				--first_window.set_menu_bar (ev_menu_bar_OBJECT)
			create EV_MENU_OBJECT
				ev_menu_bar_OBJECT.extend (EV_MENU_OBJECT)
				ev_menu_OBJECT.set_text ("Menu 1")
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item1")
				ev_menu_OBJECT.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item2")
				ev_menu_OBJECT.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item3")
				ev_menu_OBJECT.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_OBJECT
				ev_menu_bar_OBJECT.extend (EV_MENU_OBJECT)
				ev_menu_OBJECT.set_text ("Menu 2")
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item1")
				ev_menu_OBJECT.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item2")
				ev_menu_OBJECT.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item3")
				ev_menu_OBJECT.extend (EV_MENU_ITEM_OBJECT)
			create EV_SCREEN_OBJECT
			create EV_STATUS_BAR_OBJECT
			create EV_C_UTIL_OBJECT
			create EV_GDK_EXTERNALS_OBJECT
			create EV_GDK_KEYSYMS_EXTERNALS_OBJECT
			create EV_GTK_CONSTANTS_OBJECT
			create EV_GTK_EXTERNALS_OBJECT
			create EV_NOTIFY_ACTION_SEQUENCE_OBJECT
			create EV_POINTER_BUTTON_ACTION_SEQUENCE_OBJECT
--FIXME			create EV_POINTER_BUTTON_LEFT_PRESS_ACTION_SEQUENCE_OBJECT
			create EV_POINTER_MOTION_ACTION_SEQUENCE_OBJECT
			create EV_PROXIMITY_ACTION_SEQUENCE_OBJECT
			create EV_ACCELERATOR_ACTION_SEQUENCE_OBJECT
			create EV_KEY_ACTION_SEQUENCE_OBJECT
			create EV_GEOMETRY_ACTION_SEQUENCE_OBJECT
			create EV_PND_START_ACTION_SEQUENCE_OBJECT
			create EV_ITEM_SELECT_ACTION_SEQUENCE_OBJECT
			create EV_FOCUS_ACTION_SEQUENCE_OBJECT
			wnotebook.position_tabs_left
			wnotebook.fill (widgets)
			from
				widgets.start
			until
				widgets.after
			loop
				textable ?= widgets.item
					-- Set notebook tab to widget class name.
				if textable /= Void then
					if textable.text /= Void then
						wnotebook.set_item_text (widgets.item, textable.text)
					else
						textable.set_text ("I'm an " + textable.generating_type)
					end
				end
			
				pixmapable ?= widgets.item
				if pixmapable /= Void then
					pixmapable.set_pixmap (EV_PIXMAP_OBJECT)
				end
				if wnotebook.item_text (widgets.item).count = 0 then
					wnotebook.set_item_text (widgets.item, widgets.item.generating_type)
				end
		
					-- Put some children in containers.
				container ?= widgets.item
				if container /= Void then
					from
						i := 1
					until
						i = 6 or container.full
					loop
						create button.make_with_text ("item " + i.out)
						container.extend (button)
						inspect i
						when 1 then
							button.set_background_color (create {EV_COLOR}.make_with_rgb (0.7,0.2,0.2))
						when 2 then
							button.set_background_color (create {EV_COLOR}.make_with_rgb (0.7,0.7,0.2))
						when 3 then
							button.set_background_color (create {EV_COLOR}.make_with_rgb (0.2,0.7,0.2))
						when 4 then
							button.set_background_color (create {EV_COLOR}.make_with_rgb (0.2,0.7,0.7))
						when 5 then
							button.set_background_color (create {EV_COLOR}.make_with_rgb (0.2,0.2,0.7))
						end
							
						i := i + 1
					end
				end
					-- Set a pebble.
				widgets.item.set_pebble (widgets.item)
				widgets.forth
			end

			from
				i := 1
			until
				i > 10
			loop
				box.extend (create {EV_HORIZONTAL_BOX})
				box ?= box.last
				i := i + 1
			end
			box.extend (create {EV_BUTTON}.make_with_text ("I'm in 10 nested boxes!"))

			ev_menu_bar_OBJECT.extend (decendants (first_window))
			ev_menu_bar_OBJECT.last.set_text ("Widgets in a menu")
			
			if False then
-- FIXME BUG			EV_CHECK_MENU_ITEM_OBJECT.destroy
-- FIXME BUG			EV_LIST_ITEM_OBJECT.destroy
-- FIXME BUG			EV_MENU_ITEM_OBJECT.destroy
-- FIXME BUG			EV_MENU_SEPARATOR_OBJECT.destroy
-- FIXME BUG			EV_STATUS_BAR_ITEM_OBJECT.destroy
-- FIXME BUG			EV_TOOL_BAR_BUTTON_OBJECT.destroy
-- FIXME BUG			EV_TOOL_BAR_SEPARATOR_OBJECT.destroy
-- FIXME BUG			EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT.destroy
-- FIXME BUG			EV_ACCELERATOR_OBJECT.destroy
			EV_COLOR_OBJECT.destroy
--			EV_COORDINATES_OBJECT.destroy
-- FIXME BUG			EV_CURSOR_OBJECT.destroy
--			EV_CURSOR_CODE_OBJECT.destroy
			EV_ENVIRONMENT_OBJECT.destroy
-- FIXME BUG			EV_FONT_OBJECT.destroy
			EV_TIMEOUT_OBJECT.destroy
-- FIXME BUG			EV_DIRECTORY_DIALOG_OBJECT.destroy
			EV_ERROR_DIALOG_OBJECT.destroy
-- FIXME BUG			EV_FILE_OPEN_DIALOG_OBJECT.destroy
-- FIXME BUG			EV_FILE_SAVE_DIALOG_OBJECT.destroy
			EV_INFORMATION_DIALOG_OBJECT.destroy
			EV_MESSAGE_DIALOG_OBJECT.destroy
			EV_QUESTION_DIALOG_OBJECT.destroy
			EV_WARNING_DIALOG_OBJECT.destroy
			EV_AGGREGATE_BOX_OBJECT.destroy
			EV_CELL_OBJECT.destroy
			EV_DIALOG_OBJECT.destroy
			EV_FRAME_OBJECT.destroy
			EV_HORIZONTAL_BOX_OBJECT.destroy
			EV_HORIZONTAL_SPLIT_AREA_OBJECT.destroy
			EV_NOTEBOOK_OBJECT.destroy
-- FIXME BUG			EV_SCROLLABLE_AREA_OBJECT.destroy
			EV_TITLED_WINDOW_OBJECT.destroy
			EV_VERTICAL_BOX_OBJECT.destroy
			EV_VERTICAL_SPLIT_AREA_OBJECT.destroy
-- FIXME BUG			EV_VIEWPORT_OBJECT.destroy
			EV_WINDOW_OBJECT.destroy
-- FIXME BUG			EV_BUTTON_OBJECT.destroy
-- FIXME BUG			EV_CHECK_BUTTON_OBJECT.destroy
			EV_DRAWING_AREA_OBJECT.destroy
			EV_HORIZONTAL_PROGRESS_BAR_OBJECT.destroy
			EV_HORIZONTAL_RANGE_OBJECT.destroy
			EV_HORIZONTAL_SCROLL_BAR_OBJECT.destroy
			EV_HORIZONTAL_SEPARATOR_OBJECT.destroy
			EV_LABEL_OBJECT.destroy
			EV_LIST_OBJECT.destroy
-- FIXME BUG			EV_OPTION_BUTTON_OBJECT.destroy
-- FIXME BUG			EV_SPIN_BUTTON_OBJECT.destroy
-- FIXME BUG			EV_TEXT_FIELD_OBJECT.destroy
-- FIXME BUG			EV_TOGGLE_BUTTON_OBJECT.destroy
			EV_TOOL_BAR_OBJECT.destroy
			EV_VERTICAL_PROGRESS_BAR_OBJECT.destroy
			EV_VERTICAL_RANGE_OBJECT.destroy
			EV_VERTICAL_SCROLL_BAR_OBJECT.destroy
			EV_VERTICAL_SEPARATOR_OBJECT.destroy
			EV_MENU_OBJECT.destroy
			EV_MENU_BAR_OBJECT.destroy
			EV_PIXMAP_OBJECT.destroy
			EV_SCREEN_OBJECT.destroy
			EV_STATUS_BAR_OBJECT.destroy
			end
		end

	widget_tool_update (lab: EV_LABEL; w: EV_WIDGET) is
		do
			lab.set_text (
				w.generating_type + "%N" +
				"width: " + w.width.out + "%N" +
				"height: " + w.height.out + "%N" +
				"screen_x: " + w.screen_x.out + "%N" +
				"screen_y: " + w.screen_y.out + "%N" +
				"minimum_width: " + w.minimum_width.out + "%N" +
				"minimum_height: " + w.minimum_height.out
			)
		end

	textable_tool_update (lab: EV_LABEL; w: EV_TEXTABLE) is
		do
			lab.set_text ("The text is:%N" + w.text)
		end

	text_field_tool_update (lab: EV_LABEL; w: EV_TEXT_FIELD) is
		do
			lab.set_text ("The text is:%N" + w.text)
		end

    decendants (cont: EV_CONTAINER): EV_MENU is
        local
            c: EV_CONTAINER
            l: LINEAR [EV_WIDGET]
            m: EV_MENU
			t: EV_TEXTABLE
			s: STRING
        do
			create Result
            l := cont.linear_representation
            from l.start until l.after loop
                c ?= l.item
                if c /= Void then
			m := decendants (c)
			m.set_text (l.item.generating_type)
                    	Result.extend (m)
		else
			if l.item /= Void then
				s := l.item.generating_type
				t ?= l.item
				if t /= Void then
					if t.text /= Void then
						s.append (" (" + t.text + ")")
					end
				end
				Result.extend (create {EV_MENU_ITEM}.make_with_text (s))
			end
		end
                l.forth
            end
        end
end
