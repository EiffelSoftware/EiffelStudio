indexing
	description:
		"Eiffel Vision test program.%N%
		%Displays one of each widget in a notbook and a number of procedure%N%
		%widgets that can be used to manipulate them."
	status: "See notice at end of class"
	keywords: "test, example"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEST

inherit
	EV_APPLICATION

	EV_INTERNAL
		undefine
			default_create
		end

create
	make_and_launch

feature

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

	prepare is
			-- Pre launch preperation.
			--  Create some procedure widgets in a notebook.
			--  Create one of each Vision widget in a notebook.
		local
			box: EV_BOX
			scroll: EV_SCROLLABLE_AREA
			menu_bar: EV_MENU_BAR
			object_menu: EV_MENU
			menu_item: EV_MENU_ITEM
			description_frame: EV_FRAME
			timer: EV_TIMEOUT
		do
			first_window.set_title ("Eiffel Vision Widgets")
			create menu_bar
			first_window.set_menu_bar (menu_bar)
			create object_menu.make_with_text ("Other objects")
			menu_bar.extend (object_menu)
			create {EV_VERTICAL_BOX} box
			first_window.extend (box)
			create scroll
			scroll.set_minimum_size (700,500)
			box.extend (scroll)
			scroll.extend (widgets_frame)
			create description_frame.make_with_text ("Description")
			box.extend (description_frame)
			widget_label.align_text_left
			description_frame.extend (widget_label)
			box.disable_item_expand (description_frame)

			menu_bar.extend (decendants (first_window))

			from
				non_widgets.start
			until
				non_widgets.after
			loop
				create menu_item.make_with_text (
					non_widgets.item.generating_type
				)
				object_menu.extend (menu_item)
				non_widgets.forth
			end
			create timer.make_with_interval (30*60*1000)
			timer.actions.extend (~exit_zero_wrapper)
		end

	exit_zero_wrapper is do exit_zero end

	exit_zero is
		external
			"C [macro <stdio.h>]"
		alias
			"exit(0)"
		end

	widgets_frame: EV_FRAME is
			-- Frame containing one instance of each widget.
		local
			i, j: INTEGER
			vbox, wbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			l: EV_LABEL
			c: CURSOR
		once
			create Result.make_with_text ("Widgets")
			create vbox
			vbox.set_padding (10)
			Result.extend (vbox)
			c := widgets.cursor
			from
				widgets.start
			until
				widgets.after
			loop
				create hbox
				hbox.set_padding (10)
				hbox.enable_homogeneous
				vbox.extend (hbox)
				from i := 1 until i > 3 or widgets.after loop
					create wbox
					wbox.set_padding (3)
					hbox.extend (wbox)
					create l.make_with_text (
						widgets.item.generating_type
					)
					l.pointer_button_press_actions.force_extend (
						widget_label~set_text (
							widgets.item.generating_type + "%N" +
							class_descriptions.item (
								widgets.item.generating_type
							)
						)
					)
					l.set_background_color (create {EV_COLOR}.make_with_rgb (0.7, 0.7, 1.0))
					wbox.extend (l)
					wbox.extend (widgets.item)
					wbox.disable_item_expand (l)
					widgets.forth
					i := i + 1
				end
			end
			widgets.go_to (c)
		end

	widget_label: EV_LABEL is
		once
			create Result.make_with_text ("Click on one of the blue labels above to see a widget description.")
		end

	widgets: LINKED_LIST [EV_WIDGET] is
			-- List of different widgets.
		once
			create Result.make
			Result.extend (create {EV_CELL}.make_for_test)
			Result.extend (create {EV_FRAME}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_BOX}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_SPLIT_AREA}.make_for_test)
			Result.extend (create {EV_NOTEBOOK}.make_for_test)
			Result.extend (create {EV_SCROLLABLE_AREA}.make_for_test)
			Result.extend (create {EV_VERTICAL_BOX}.make_for_test)
			Result.extend (create {EV_VERTICAL_SPLIT_AREA}.make_for_test)
			Result.extend (create {EV_VIEWPORT}.make_for_test)
			Result.extend (create {EV_BUTTON}.make_for_test)
			Result.extend (create {EV_CHECK_BUTTON}.make_for_test)
			Result.extend (create {EV_DRAWING_AREA}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_PROGRESS_BAR}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_RANGE}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_SCROLL_BAR}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_SEPARATOR}.make_for_test)
			Result.extend (create {EV_LABEL}.make_for_test)
			Result.extend (create {EV_LIST}.make_for_test)
			Result.extend (create {EV_MULTI_COLUMN_LIST}.make_for_test)
			Result.extend (create {EV_OPTION_BUTTON}.make_for_test)
			Result.extend (create {EV_SPIN_BUTTON}.make_for_test)
			Result.extend (create {EV_TEXT_FIELD}.make_for_test)
			Result.extend (create {EV_TOGGLE_BUTTON}.make_for_test)
			Result.extend (create {EV_TOOL_BAR}.make_for_test)
			Result.extend (create {EV_TREE}.make_for_test)
			Result.extend (create {EV_VERTICAL_PROGRESS_BAR}.make_for_test)
			Result.extend (create {EV_VERTICAL_RANGE}.make_for_test)
			Result.extend (create {EV_VERTICAL_SCROLL_BAR}.make_for_test)
			Result.extend (create {EV_VERTICAL_SEPARATOR}.make_for_test)
			Result.extend (create {EV_PIXMAP}.make_for_test)
			Result.extend (create {EV_TEXT}.make_for_test)
			Result.extend (create {EV_PASSWORD_FIELD}.make_for_test)
			Result.extend (create {EV_COMBO_BOX}.make_for_test)
		end

	windows: LINKED_LIST [EV_WINDOW] is
			-- List of different windows.
		once
			create Result.make
			Result.extend (create {EV_WINDOW})
			Result.extend (create {EV_TITLED_WINDOW})
		end

	dialogs: LINKED_LIST [EV_DIALOG] is
			-- List of different dialogs.
		once
			create Result.make
			Result.extend (create {EV_DIALOG})
--|FIXME		Result.extend (create {EV_DIRECTORY_DIALOG})
			Result.extend (create {EV_ERROR_DIALOG})
--|FIXME		Result.extend (create {EV_FILE_OPEN_DIALOG})
--|FIXME		Result.extend (create {EV_FILE_SAVE_DIALOG})
			Result.extend (create {EV_INFORMATION_DIALOG})
			Result.extend (create {EV_MESSAGE_DIALOG})
			Result.extend (create {EV_QUESTION_DIALOG})
			Result.extend (create {EV_WARNING_DIALOG})
		end

	non_widgets: LINKED_LIST [ANY] is
			-- List of other Vision objects.
		once
			create Result.make
			Result.extend (create {EV_FIGURE_ARC})
			Result.extend (create {EV_FIGURE_DOT})
--|FIXME		Result.extend (create {EV_FIGURE_DRAWER})
			Result.extend (create {EV_FIGURE_ELLIPSE})
			Result.extend (create {EV_FIGURE_EQUILATERAL})
			Result.extend (create {EV_FIGURE_GROUP})
			Result.extend (create {EV_FIGURE_LINE})
			Result.extend (create {EV_FIGURE_MATH})
			Result.extend (create {EV_FIGURE_PICTURE})
			Result.extend (create {EV_FIGURE_PIE_SLICE})
			Result.extend (create {EV_FIGURE_POLYGON})
			Result.extend (create {EV_FIGURE_POLYLINE})
			Result.extend (create {EV_FIGURE_RECTANGLE})
			Result.extend (create {EV_FIGURE_TEXT})
			Result.extend (create {EV_FIGURE_TRIANGLE})
			Result.extend (create {EV_FIGURE_WORLD})
--|FIXME		Result.extend (create {EV_PROJECTION})
--|FIXME		Result.extend (create {EV_RELATIVE_POINT})
--|FIXME		Result.extend (create {EV_STANDARD_PROJECTION})
			Result.extend (create {EV_CHECK_MENU_ITEM})
			Result.extend (create {EV_LIST_ITEM})
			Result.extend (create {EV_MENU_ITEM})
			Result.extend (create {EV_MENU_SEPARATOR})
			Result.extend (create {EV_STATUS_BAR_ITEM})
			Result.extend (create {EV_TOOL_BAR_BUTTON})
--FIXME			Result.extend (create {EV_TOOL_BAR_SEPARATOR})
			Result.extend (create {EV_TOOL_BAR_TOGGLE_BUTTON})
			Result.extend (create {EV_TOOL_BAR_RADIO_BUTTON})
			Result.extend (create {EV_TOOL_BAR_RADIO_BUTTON})
--FXIME			Result.extend (create {EV_ACCELERATOR})
			Result.extend (create {EV_COLOR})
			Result.extend (create {EV_COORDINATES})
			Result.extend (create {EV_CURSOR})
--|FIXME		Result.extend (create {EV_CURSOR_CODE})
			Result.extend (create {EV_ENVIRONMENT})
			Result.extend (create {EV_FONT})
			Result.extend (create {EV_FONT_CONSTANTS})
			Result.extend (create {EV_RECTANGLE})
			Result.extend (create {EV_TIMEOUT})
			Result.extend (create {EV_DRAWABLE_CONSTANTS})
			Result.extend (create {EV_DEFAULT_COLORS})
			Result.extend (create {EV_MENU})
			Result.extend (create {EV_MENU_BAR})
			Result.extend (create {EV_SCREEN})
			Result.extend (create {EV_STATUS_BAR})
		end

--|	features: LINKED_LIST [EV_PROCEDURE_WIDGET [ANY, TUPLE]] is
--|			-- Assorted Vision feature as procedure widgets.
--|		once
--|			create Result.make
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_TEXTABLE, TUPLE [EV_TEXTABLE, STRING]]}.make ( {EV_TEXTABLE}~set_text, "set_text", <<"textable", "text">> ))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_WIDGET]]}.make ( {EV_CONTAINER}~extend, "extend", <<"container", "widget">> ))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ( {EV_WIDGET}~destroy, "destroy", <<"widget">> ))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER]]}.make ({EV_CONTAINER}~compare_objects, "compare_objects", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER]]}.make ({EV_CONTAINER}~compare_references, "compare_references", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~disable_capture, "disable_capture", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~disable_sensitive, "disable_sensitive", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~enable_capture, "enable_capture", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~enable_sensitive, "enable_sensitive", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~hide, "hide", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~remove_pebble, "remove_pebble", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, EV_CURSOR]]}.make ({EV_WIDGET}~set_accept_cursor, "set_accept_cursor", <<"target", "a_cursor">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~set_default_colors, "set_default_colors", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, EV_CURSOR]]}.make ({EV_WIDGET}~set_deny_cursor, "set_deny_cursor", <<"target", "a_cursor">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~set_drag_and_drop_mode, "set_drag_and_drop_mode", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~set_focus, "set_focus", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, ANY]]}.make ({EV_WIDGET}~set_pebble, "set_pebble", <<"target", "a_pebble">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, INTEGER,  INTEGER]]}.make ({EV_WIDGET}~set_pebble_position, "set_pebble_position", <<"target", "a_x", "a_y">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~set_pick_and_drop_mode, "set_pick_and_drop_mode", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~show, "show", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_WIDGET]]}.make ({EV_CONTAINER}~extend, "extend", <<"target", "v">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, CONTAINER [EV_WIDGET]]]}.make ({EV_CONTAINER}~fill, "fill", <<"target", "other">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_WIDGET]]}.make ({EV_CONTAINER}~put, "put", <<"target", "v">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER]]}.make ({EV_CONTAINER}~remove_tooltip, "remove_tooltip", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_COLOR]]}.make ({EV_CONTAINER}~set_background_color, "set_background_color", <<"target", "a_color">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_COLOR]]}.make ({EV_CONTAINER}~set_foreground_color, "set_foreground_color", <<"target", "a_color">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, INTEGER]]}.make ({EV_WIDGET}~set_minimum_height, "set_minimum_height", <<"target", "a_minimum_height">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET,INTEGER,  INTEGER]]}.make ({EV_WIDGET}~set_minimum_size, "set_minimum_size", <<"target", "a_minimum_width", "a_minimum_height">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, INTEGER]]}.make ({EV_WIDGET}~set_minimum_width, "set_minimum_width", <<"target", "a_minimum_width">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET, STRING]]}.make ({EV_WIDGET}~set_tooltip, "set_tooltip", <<"target", "a_text">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_WIDGET]]}.make ({EV_CONTAINER}~prune, "prune", <<"target", "v">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER, EV_WIDGET]]}.make ({EV_CONTAINER}~prune_all, "prune_all", <<"target", "v">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER]]}.make ({EV_CONTAINER}~wipe_out, "wipe_out", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER]]}.make ({EV_CONTAINER}~propagate_background_color, "propagate_background_color", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_CONTAINER, TUPLE [EV_CONTAINER]]}.make ({EV_CONTAINER}~propagate_foreground_color, "propagate_foreground_color", <<"target">>))
--|			Result.extend (create {EV_PROCEDURE_WIDGET [EV_WIDGET, TUPLE [EV_WIDGET]]}.make ({EV_WIDGET}~destroy, "destroy", <<"target">>))
--|		end

	decendants (a_container: EV_CONTAINER): EV_MENU is
			-- Children of `a_container
		local
			c: EV_CONTAINER
			l: LINEAR [EV_WIDGET]
			m: EV_MENU
			t: EV_TEXTABLE
			s: STRING
		do
			create Result.make_with_text ("Widget packing hierarchy")
			l := a_container.linear_representation
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.20  2000/04/20 18:16:21  oconnor
--| made self destruct delay longer
--|
--| Revision 1.19  2000/04/19 16:17:49  brendel
--| Spelling.
--| Changed MENU to MENU ITEM for non-widgets.
--|
--| Revision 1.18  2000/04/17 17:50:16  brendel
--| Added EV_COMBO_BOX.
--|
--| Revision 1.17  2000/04/14 22:29:08  oconnor
--| ced out da SPIN thang
--|
--| Revision 1.16  2000/04/14 16:54:11  brendel
--| Added EV_TEXT and EV_PASSWORD_FIELD.
--|
--| Revision 1.15  2000/04/13 19:37:00  oconnor
--| more tests
--|
--| Revision 1.14  2000/03/29 01:23:00  brendel
--| Commented out EV_SPIN_BUTTON.
--|
--| Revision 1.13  2000/03/22 00:39:46  oconnor
--| more tests
--|
--| Revision 1.12  2000/03/07 22:09:24  oconnor
--| Commented out feature that do not yet work on windows
--|
--| Revision 1.11  2000/03/07 18:27:40  oconnor
--| removed scrolling area pending implementation in WEL
--|
--| Revision 1.10  2000/03/02 18:37:34  oconnor
--| added tree
--|
--| Revision 1.9  2000/03/01 03:06:13  oconnor
--| revised tests
--|
--| Revision 1.8  2000/02/22 18:39:53  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/18 23:18:51  oconnor
--| removed ANGLE* and BASIC_COLORS
--|
--| Revision 1.6  2000/02/17 01:09:04  oconnor
--| more tests
--|
--| Revision 1.5  2000/02/15 19:50:41  oconnor
--| more tests
--|
--| Revision 1.4  2000/02/15 19:27:56  oconnor
--| more tests
--|
--| Revision 1.3  2000/02/14 12:11:41  oconnor
--| moved test2 to test
--|
--| Revision 1.2  2000/02/14 12:05:15  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/02/14 11:41:54  oconnor
--| more tests
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
