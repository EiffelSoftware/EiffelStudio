class
	WINTEST

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

	prepare is
		local
			main_split: EV_VERTICAL_BOX
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
			container: EV_CONTAINER
			wnotebook: EV_NOTEBOOK

			ASSIGN_ATTEMPT_OBJECT: ASSIGN_ATTEMPT [REAL]
			--EV_RADIO_GROUP_OBJECT: EV_RADIO_GROUP
			EV_PND_ACTION_SEQUENCE_OBJECT: EV_PND_ACTION_SEQUENCE
			EV_ANGLE_OBJECT: EV_ANGLE
			EV_ANGLE_ROUTINES_OBJECT: EV_ANGLE_ROUTINES
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
			--EV_TOOL_BAR_SEPARATOR_OBJECT: EV_TOOL_BAR_SEPARATOR
			--EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT: EV_TOOL_BAR_TOGGLE_BUTTON
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
			--EV_TIMEOUT_OBJECT: EV_TIMEOUT
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
			--EV_AGGREGATE_BOX_OBJECT: EV_AGGREGATE_BOX
			EV_CELL_OBJECT: EV_CELL
			EV_DIALOG_OBJECT: EV_DIALOG
			EV_FRAME_OBJECT: EV_FRAME
			EV_HORIZONTAL_BOX_OBJECT: EV_HORIZONTAL_BOX
			--EV_HORIZONTAL_SPLIT_AREA_OBJECT: EV_HORIZONTAL_SPLIT_AREA
			EV_NOTEBOOK_OBJECT: EV_NOTEBOOK
			EV_SCROLLABLE_AREA_OBJECT: EV_SCROLLABLE_AREA
			EV_TITLED_WINDOW_OBJECT: EV_TITLED_WINDOW
			EV_VERTICAL_BOX_OBJECT: EV_VERTICAL_BOX
			--EV_VERTICAL_SPLIT_AREA_OBJECT: EV_VERTICAL_SPLIT_AREA
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
			EV_OPTION_BUTTON_OBJECT: EV_OPTION_BUTTON
			--EV_SPIN_BUTTON_OBJECT: EV_SPIN_BUTTON
			EV_TEXT_FIELD_OBJECT: EV_TEXT_FIELD
			--EV_TOGGLE_BUTTON_OBJECT: EV_TOGGLE_BUTTON
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
		do
			create first_window
			create main_split
			first_window.extend (main_split)

			create frame
			frame.set_text ("Widgets:")
			main_split.extend (frame)

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

			widget_tool_box.extend (create {EV_LABEL})
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
			create ASSIGN_ATTEMPT_OBJECT
--FIMXE			create EV_RADIO_GROUP_OBJECT
			create EV_PND_ACTION_SEQUENCE_OBJECT
			create EV_ANGLE_OBJECT
			create EV_ANGLE_ROUTINES_OBJECT
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
			create EV_STATUS_BAR_ITEM_OBJECT
			create EV_TOOL_BAR_BUTTON_OBJECT
			--create EV_TOOL_BAR_SEPARATOR_OBJECT
			--create EV_TOOL_BAR_TOGGLE_BUTTON_OBJECT
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
			--create EV_TIMEOUT_OBJECT
			create EV_DRAWABLE_CONSTANTS_OBJECT
			create EV_BASIC_COLORS_OBJECT
			create EV_DEFAULT_COLORS_OBJECT
			create EV_DIRECTORY_DIALOG_OBJECT
			create EV_ERROR_DIALOG_OBJECT
			create EV_FILE_OPEN_DIALOG_OBJECT
			create EV_FILE_SAVE_DIALOG_OBJECT
			create EV_INFORMATION_DIALOG_OBJECT
			create EV_MESSAGE_DIALOG_OBJECT
			create EV_QUESTION_DIALOG_OBJECT
			create EV_WARNING_DIALOG_OBJECT
			--create EV_AGGREGATE_BOX_OBJECT
			create EV_CELL_OBJECT
			create EV_DIALOG_OBJECT
			create EV_FRAME_OBJECT
				widgets.extend (EV_FRAME_OBJECT)
			create EV_HORIZONTAL_BOX_OBJECT
				widgets.extend (EV_HORIZONTAL_BOX_OBJECT)
			--create EV_HORIZONTAL_SPLIT_AREA_OBJECT
			--	widgets.extend (EV_HORIZONTAL_SPLIT_AREA_OBJECT)
			create EV_NOTEBOOK_OBJECT
				widgets.extend (EV_NOTEBOOK_OBJECT)
--FIXME			create EV_SCROLLABLE_AREA_OBJECT
			create EV_TITLED_WINDOW_OBJECT
			create EV_VERTICAL_BOX_OBJECT
				widgets.extend (EV_VERTICAL_BOX_OBJECT)
			--create EV_VERTICAL__AREA_OBJECT
			--	widgets.extend (EV_VERTICAL_SPLIT_AREA_OBJECT)
--FIXME			create EV_VIEWPORT_OBJECT
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
			create EV_HORIZONTAL_SCROLL_BAR_OBJECT
				widgets.extend (EV_HORIZONTAL_SCROLL_BAR_OBJECT)
			create EV_HORIZONTAL_SEPARATOR_OBJECT
				widgets.extend (EV_HORIZONTAL_SEPARATOR_OBJECT)
			create EV_LABEL_OBJECT
				widgets.extend (EV_LABEL_OBJECT)
			create EV_LIST_OBJECT
--FIXME			create EV_OPTION_BUTTON_OBJECT
			--create EV_SPIN_BUTTON_OBJECT
			create EV_TEXT_FIELD_OBJECT
				widgets.extend (EV_TEXT_FIELD_OBJECT)
			--create EV_TOGGLE_BUTTON_OBJECT
			--	widgets.extend (EV_TOGGLE_BUTTON_OBJECT)
			create EV_TOOL_BAR_OBJECT
			create EV_VERTICAL_PROGRESS_BAR_OBJECT
				widgets.extend (EV_VERTICAL_PROGRESS_BAR_OBJECT)
			create EV_VERTICAL_RANGE_OBJECT
			create EV_VERTICAL_SCROLL_BAR_OBJECT
				widgets.extend (EV_VERTICAL_SCROLL_BAR_OBJECT)
			create EV_VERTICAL_SEPARATOR_OBJECT
				widgets.extend (EV_VERTICAL_SEPARATOR_OBJECT)
			create EV_MENU_BAR_OBJECT
				first_window.set_menu_bar (ev_menu_bar_object)
			create EV_MENU_OBJECT
				ev_menu_bar_object.extend (EV_MENU_OBJECT)
				ev_menu_object.set_text ("Menu 1")
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item1")
				ev_menu_object.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item2")
				ev_menu_object.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item3")
				ev_menu_object.extend (EV_MENU_ITEM_OBJECT)
			create EV_PIXMAP_OBJECT
			create EV_MENU_OBJECT
				ev_menu_bar_object.extend (EV_MENU_OBJECT)
				ev_menu_object.set_text ("Menu 2")
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item1")
				ev_menu_object.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item2")
				ev_menu_object.extend (EV_MENU_ITEM_OBJECT)
			create EV_MENU_ITEM_OBJECT
				EV_MENU_ITEM_OBJECT.set_text ("item3")
				ev_menu_object.extend (EV_MENU_ITEM_OBJECT)
			create EV_PIXMAP_OBJECT
			create EV_SCREEN_OBJECT
			create EV_STATUS_BAR_OBJECT
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
					-- Set text for textable widgets.
				textable ?= widgets.item
				if textable /= Void then
					textable.set_text (textable.generating_type)
				end
					-- Set notebook tab to widget class name.
				wnotebook.set_item_text (widgets.item, widgets.item.generating_type)
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

			ev_menu_bar_object.extend (decendants (first_window))
			ev_menu_bar_object.last.set_text ("Widgets")
			
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
			--EV_TIMEOUT_OBJECT.destroy
-- FIXME BUG			EV_DIRECTORY_DIALOG_OBJECT.destroy
			EV_ERROR_DIALOG_OBJECT.destroy
-- FIXME BUG			EV_FILE_OPEN_DIALOG_OBJECT.destroy
-- FIXME BUG			EV_FILE_SAVE_DIALOG_OBJECT.destroy
			EV_INFORMATION_DIALOG_OBJECT.destroy
			EV_MESSAGE_DIALOG_OBJECT.destroy
			EV_QUESTION_DIALOG_OBJECT.destroy
			EV_WARNING_DIALOG_OBJECT.destroy
			--EV_AGGREGATE_BOX_OBJECT.destroy
			EV_CELL_OBJECT.destroy
			EV_DIALOG_OBJECT.destroy
			EV_FRAME_OBJECT.destroy
			EV_HORIZONTAL_BOX_OBJECT.destroy
			--EV_HORIZONTAL_SPLIT_AREA_OBJECT.destroy
			EV_NOTEBOOK_OBJECT.destroy
-- FIXME BUG			EV_SCROLLABLE_AREA_OBJECT.destroy
			EV_TITLED_WINDOW_OBJECT.destroy
			EV_VERTICAL_BOX_OBJECT.destroy
			--EV_VERTICAL_SPLIT_AREA_OBJECT.destroy
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
					Result.extend (create {EV_MENU_ITEM}.make_with_text (l.item.generating_type))
                end
                l.forth
            end
        end
end
