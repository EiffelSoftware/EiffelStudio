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
	start

feature

	start is
		do
			default_create
			prepare
			launch
		end

	non_widget_test_area: EV_CELL
			-- Cell that can contain {EV_TESTABLE_NON_WIDGET}.test_widget.

	prepare is
			-- Pre launch preperation.
			--  Create some procedure widgets in a notebook.
			--  Create one of each Vision widget in a notebook.
		local
			first_window: EV_TITLED_WINDOW
			box: EV_BOX
			notebook: EV_NOTEBOOK
			scroll: EV_SCROLLABLE_AREA
			menu_bar: EV_MENU_BAR
			object_menu: EV_MENU
			menu_item: EV_MENU_ITEM
			description_frame: EV_FRAME
			timer: EV_TIMEOUT
			da: EV_DRAWING_AREA
			p1, p2, p3: EV_PIXMAP
			t: EV_TIMEOUT
			ev_status_bar: EV_STATUS_BAR
		do
			create first_window.make_with_title ("Eiffel Vision Widgets")
			first_window.close_actions.extend (~destroy)
			create ev_status_bar.make_for_test
			first_window.lower_bar.extend (ev_status_bar)
			create menu_bar
			first_window.set_menu_bar (menu_bar)
			create object_menu.make_with_text ("Other objects")
			menu_bar.extend (object_menu)
			create {EV_VERTICAL_BOX} box
			first_window.extend (box)
			create notebook
			box.extend (notebook)

			create scroll
			scroll.set_minimum_size (700, 500)
			notebook.extend (scroll)
			notebook.set_item_text (scroll, "Welcome to EiffelVision")
			create da
			create p1
			create p2
			p2.set_with_named_file ("vision.png")
			da.set_minimum_size (p2.width+100, p2.height+100)
			p1.set_size (p2.width+100, p2.height+100)
			scroll.extend (da)
			create t
			t.actions.extend (~update_face (da, p1, p2))
			t.set_interval (500)

			create scroll
			scroll.set_minimum_size (700, 500)
			notebook.extend (scroll)
			notebook.set_item_text (scroll, "Widgets")
			scroll.extend (widgets_frame)

			create scroll
			scroll.set_minimum_size (700, 500)
			notebook.extend (scroll)
			notebook.set_item_text (scroll, "Other classes")
			scroll.extend (non_widgets_frame)

			create description_frame.make_with_text ("Description")
			box.extend (description_frame)
			widget_label.align_text_left
			description_frame.extend (widget_label)
			box.disable_item_expand (description_frame)
			box.extend (widget_tool)
			box.disable_item_expand (widget_tool)

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
			first_window.show
		end

	exit_zero_wrapper is do exit_zero end

	exit_zero is
		external
			"C [macro <stdio.h>]"
		alias
			"exit(0)"
		end

	widget_tool: EV_WIDGET is
			-- Tool for viewing widget properties.
		local
			main: EV_HORIZONTAL_BOX
			black_hole: EV_PIXMAP
			label: EV_LABEL
			t: EV_TIMEOUT
			p: EV_PIXMAP
		once
			create main
			main.set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			Result := main
			create pool.make
			create pool_da
			pool_da.set_minimum_size (100, 100)
			main.extend (pool_da)
			main.disable_item_expand (pool_da)
			create p; p.set_with_named_file ("pool1.png")
			pool.put_front (p)
			create p; p.set_with_named_file ("pool2.png")
			pool.put_front (p)
			create p; p.set_with_named_file ("pool3.png")
			pool.put_front (p)
			create p; p.set_with_named_file ("pool4.png")
			pool.put_front (p)
			pool.start
			create label.make_with_text ("<-- Drop stuff here to see class name.     Or try the bottomless pit. -->")
			label.set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			main.extend (label)
			pool_da.drop_actions.extend (~update_widget_tool (label, ?))
			pool_da.set_target_name ("Widget tool")
			create black_hole
			black_hole.set_with_named_file ("black.png")
			main.extend (black_hole)
			main.disable_item_expand (black_hole)
			black_hole.drop_actions.extend (~nuke)
			black_hole.set_target_name ("Black hole")
			black_hole.set_background_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))

			create t
			t.actions.extend (~update_pool)
			t.set_interval (50)
		end

	pool: LINKED_LIST [EV_PIXMAP]
	pool_da: EV_DRAWING_AREA

	update_pool is
		local
			i: INTEGER
		do
			pool_da.draw_pixmap (0, 0, pool.item)
			pool_da.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			from i := 1 until i = 10 loop
				pool_da.draw_point (43 + random_int (14), 43 + random_int (14))
				i := i + 1
			end
			from i := 1 until i = 10 loop
				pool_da.draw_point (45 + random_int (10), 45 + random_int (10))
				i := i + 1
			end
			pool_da.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 1, 0))
			from i := 1 until i = 10 loop
				pool_da.draw_point (47 + random_int (6), 47 + random_int (6))
				i := i + 1
			end
			pool.forth
			if pool.after then
				pool.start
			end
		end

	update_face (da: EV_DRAWING_AREA; p1, p2: EV_PIXMAP) is
		local
			c: EV_COLOR
		do
			create c.make_with_rgb (
				random_real (1),
				random_real (1),
				random_real (1)
			)
			p1.set_foreground_color (c)
			p1.fill_rectangle (0, 0, p1.width, p1.height)
			p1.draw_pixmap (50, 50, p2)
			da.draw_pixmap (0, 0, p1)
		end

	snow is
		local
			i: INTEGER
			scr: EV_SCREEN
			x, y: INTEGER
		do
			create scr
			scr.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			x := scr.pointer_position.x - 10 + random_int (20)
			y := scr.pointer_position.y - 10 + random_int (20)
			scr.set_pointer_position (x, y)
			scr.draw_point (x, y)
			i := i + 1
		end
	
	update_widget_tool (a_tool: EV_LABEL; a_widget: EV_WIDGET) is
			-- Update `widget_tool'.
		local
			snow_timer: EV_TIMEOUT
		do
			create snow_timer.make_with_interval (200)
			snow_timer.actions.extend (~snow)
			a_tool.set_text (a_widget.generating_type)
		end

	random: RANDOM is once create Result.make end

	random_int (max: INTEGER): INTEGER is
		do
			random.forth
			Result := (random.real_item * max).rounded
		end

	random_real (max: REAL): REAL is
		do
			random.forth
			Result := random.real_item * max
		end

	nuke (w: EV_WIDGET) is
		do
			do_once_on_idle (w~destroy)
		end

	widgets_frame: EV_FRAME is
			-- Frame containing one instance of each widget.
		once
			Result := test_frame (widgets.count, widgets~i_th, widgets~i_th)
			Result.set_text ("Widgets")
		end

	non_widgets_frame: EV_FRAME is
			-- Frame containing one instance of each non-widget.
		once
			Result := test_frame (non_widgets.count, ~non_widgets_i_th,
				non_widgets~i_th)
			Result.set_text ("Non-widgets")
		end

	non_widgets_i_th (an_index: INTEGER): EV_WIDGET is
			-- `test_widget' from `non_widgets' at `an_index'.
		local
			testable: EV_TESTABLE_NON_WIDGET
		do
			testable ?= non_widgets.i_th (an_index)
			if testable /= Void then
				Result := testable.test_widget
			end
		end

	test_frame (a_count: INTEGER;
			a_i_th: FUNCTION [ANY, TUPLE [INTEGER], EV_WIDGET]
			real_i_th: FUNCTION [ANY, TUPLE [INTEGER], ANY]): EV_FRAME is
			-- Frame containing one instance of each widget.
		local
			i, j, n: INTEGER
			test_subject: EV_WIDGET
			test_type: STRING
			vbox, wbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			l: EV_LABEL
		do
			create Result
			create vbox
			vbox.set_padding (10)
			Result.extend (vbox)
			from
				n := 1
			until
				n > a_count
			loop
				create hbox
				hbox.set_padding (10)
				hbox.enable_homogeneous
				vbox.extend (hbox)
				from i := 1 until i > 3 or n > a_count loop
					test_subject := a_i_th.item ([n])
					if test_subject /= Void then
						test_type := real_i_th.item ([n]).generating_type
						create wbox
						wbox.set_padding (3)
						hbox.extend (wbox)
						create l.make_with_text (test_type)
						l.pointer_button_press_actions.force_extend (
							widget_label~set_text (
								test_type + "%N" +
								class_descriptions.item (test_type)
							)
						)
						l.set_background_color (create {EV_COLOR}.make_with_rgb (0.7, 0.7, 1.0))
						wbox.extend (l)
						test_subject.set_minimum_size (300, 100)
						wbox.extend (test_subject)
						test_subject.set_pebble (test_subject)
						if n \\ 2 = 0 then
							test_subject.set_target_menu_mode
						end
						wbox.disable_item_expand (l)
						i := i + 1
					end
					n := n + 1
				end
			end
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
			Result.last.set_minimum_size (200,100)
			Result.extend (create {EV_HORIZONTAL_SPLIT_AREA}.make_for_test)
			Result.extend (create {EV_NOTEBOOK}.make_for_test)
			Result.extend (create {EV_SCROLLABLE_AREA}.make_for_test)
			Result.extend (create {EV_VERTICAL_BOX}.make_for_test)
			Result.extend (create {EV_VERTICAL_SPLIT_AREA}.make_for_test)
			Result.extend (create {EV_VIEWPORT}.make_for_test)
			Result.last.set_minimum_size (100,100)
			Result.extend (create {EV_BUTTON}.make_for_test)
			Result.extend (create {EV_CHECK_BUTTON}.make_for_test)
			Result.extend (create {EV_DRAWING_AREA}.make_for_test)
			Result.extend (create {EV_FIXED}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_PROGRESS_BAR}.make_for_test)
			Result.extend (create {EV_HORIZONTAL_RANGE}.make_for_test)
--|			Result.extend (create {EV_HORIZONTAL_SCROLL_BAR}.make_for_test)
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
--|			Result.extend (create {EV_VERTICAL_SCROLL_BAR}.make_for_test)
			Result.extend (create {EV_VERTICAL_SEPARATOR}.make_for_test)
			Result.extend (create {EV_PIXMAP}.make_for_test)
			Result.last.set_minimum_size (100,100)
			Result.extend (create {EV_TEXT}.make_for_test)
			Result.extend (create {EV_PASSWORD_FIELD}.make_for_test)
			Result.extend (create {EV_COMBO_BOX}.make_for_test)
			Result.extend (create {EV_TABLE}.make_for_test)
		end

	ev_windows: LINKED_LIST [EV_WINDOW] is
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
			Result.extend (create {EV_FIGURE_ARC}.make_for_test)
			Result.extend (create {EV_FIGURE_DOT}.make_for_test)
--|FIXME		Result.extend (create {EV_FIGURE_DRAWER})
			Result.extend (create {EV_FIGURE_ELLIPSE}.make_for_test)
			Result.extend (create {EV_FIGURE_EQUILATERAL}.make_for_test)
			Result.extend (create {EV_FIGURE_GROUP})
			Result.extend (create {EV_FIGURE_LINE}.make_for_test)
			Result.extend (create {EV_FIGURE_MATH})
			Result.extend (create {EV_FIGURE_PICTURE}.make_for_test)
			Result.extend (create {EV_FIGURE_PIE_SLICE}.make_for_test)
			Result.extend (create {EV_FIGURE_POLYGON}.make_for_test)
			Result.extend (create {EV_FIGURE_POLYLINE}.make_for_test)
			Result.extend (create {EV_FIGURE_RECTANGLE}.make_for_test)
			Result.extend (create {EV_FIGURE_ROUNDED_RECTANGLE}.make_for_test)
			Result.extend (create {EV_FIGURE_TEXT}.make_for_test)
			Result.extend (create {EV_FIGURE_STAR}.make_for_test)
			Result.extend (create {EV_FIGURE_WORLD})
--|FIXME		Result.extend (create {EV_PROJECTION})
--|FIXME		Result.extend (create {EV_RELATIVE_POINT})
--|FIXME		Result.extend (create {EV_STANDARD_PROJECTION})
			Result.extend (create {EV_CHECK_MENU_ITEM})
			Result.extend (create {EV_LIST_ITEM})
			Result.extend (create {EV_MENU_ITEM})
			Result.extend (create {EV_MENU_SEPARATOR})
			Result.extend (create {EV_TOOL_BAR_BUTTON})
--FIXME			Result.extend (create {EV_TOOL_BAR_SEPARATOR})
			Result.extend (create {EV_TOOL_BAR_TOGGLE_BUTTON})
			Result.extend (create {EV_TOOL_BAR_RADIO_BUTTON})
			Result.extend (create {EV_TOOL_BAR_RADIO_BUTTON})
--|FIXME			Result.extend (create {EV_ACCELERATOR})
			Result.extend (create {EV_COLOR})
			Result.extend (create {EV_COORDINATES})
			Result.extend (create {EV_CURSOR})
			Result.extend (create {EV_ENVIRONMENT})
			Result.extend (create {EV_FONT})
			Result.extend (create {EV_FONT_CONSTANTS})
			Result.extend (create {EV_RECTANGLE})
--|			Result.extend (create {EV_TIMEOUT})
			Result.extend (create {EV_DRAWABLE_CONSTANTS})
			Result.extend (create {EV_STOCK_COLORS})
			Result.extend (create {EV_MENU})
			Result.extend (create {EV_MENU_BAR})
			Result.extend (create {EV_SCREEN})
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
--| Revision 1.47  2001/06/07 23:08:56  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.45.2.16  2000/12/20 19:05:48  rogers
--| Changed EV_DEFAULT_COLORS to EV_STOCK_COLORS.
--|
--| Revision 1.45.2.15  2000/08/09 21:33:57  king
--| Made compilable with clone reversion
--|
--| Revision 1.45.2.14  2000/08/08 21:14:39  king
--| Renaming clone to defunct_clone
--|
--| Revision 1.45.2.13  2000/08/04 23:42:46  brendel
--| Added rounded rectangle and star.
--|
--| Revision 1.45.2.12  2000/07/03 17:50:27  oconnor
--| added close action
--|
--| Revision 1.45.2.11  2000/06/16 00:29:09  oconnor
--| tweak
--|
--| Revision 1.45.2.10  2000/06/15 23:41:43  oconnor
--| added toolbar :-)
--|
--| Revision 1.45.2.9  2000/06/15 23:37:45  oconnor
--| removed toolbar
--|
--| Revision 1.45.2.8  2000/06/14 18:40:31  oconnor
--| removed use of LINKED_CIRCULAR, it is horribly broken.
--| added TREE and TABLE to test.
--|
--| Revision 1.45.2.7  2000/06/14 17:56:50  oconnor
--| show first window
--|
--| Revision 1.45.2.6  2000/06/14 17:11:01  oconnor
--| show first window
--|
--| Revision 1.45.2.5  2000/06/14 17:09:17  oconnor
--| use new APP class
--|
--| Revision 1.45.2.4  2000/05/18 17:47:26  brendel
--| *** empty log message ***
--|
--| Revision 1.45.2.3  2000/05/05 23:20:01  pichery
--| We still have our bug on windows with the
--| geometry managment. This fix it.
--|
--| Revision 1.45.2.2  2000/05/03 22:23:30  pichery
--| - Removed inline creation that screw up the
--|   debugger for the moment.
--|
--|
--| Revision 1.45.2.1  2000/05/03 19:10:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.45  2000/05/03 17:00:12  oconnor
--| more tests
--|
--| Revision 1.44  2000/05/02 20:54:42  oconnor
--| more tests
--|
--| Revision 1.43  2000/05/02 15:21:39  brendel
--| Added EV_FIXED.
--|
--| Revision 1.42  2000/04/28 23:43:26  brendel
--| Corrected.
--|
--| Revision 1.41  2000/04/28 22:32:13  brendel
--| What's the point of having a status bar not at the bottom of a window?
--|
--| Revision 1.40  2000/04/28 22:23:28  brendel
--| Status bar is now a widget.
--| There is no status bar item anymore.
--|
--| Revision 1.39  2000/04/27 22:00:40  brendel
--| Arc and polyline are now made for test, too.
--|
--| Revision 1.38  2000/04/27 00:03:53  brendel
--| Corrected test_frame.
--|
--| Revision 1.37  2000/04/26 23:51:38  brendel
--| Insert notebook!
--|
--| Revision 1.36  2000/04/26 23:20:06  brendel
--| Fixed agent call.
--|
--| Revision 1.35  2000/04/26 23:11:43  brendel
--| Removed non_widgets_frame.
--| Started new implementation of non-widgets test similar to widget frame.
--|
--| Revision 1.34  2000/04/26 22:09:38  oconnor
--| Snow II, the return!
--|
--| Revision 1.29  2000/04/26 18:32:35  brendel
--| Reinserted changes.
--|
--| Revision 1.28  2000/04/26 18:22:58  oconnor
--| more tests
--|
--| Revision 1.26  2000/04/26 17:06:42  oconnor
--| removed EV_TRIANGLE
--|
--| Revision 1.25  2000/04/26 16:58:30  oconnor
--| added PND tests
--|
--| Revision 1.24  2000/04/26 16:20:54  brendel
--| Commented out splash screen experiment.
--| Non-widgets combo now only displays the ones that have a test.
--|
--| Revision 1.23  2000/04/26 00:50:01  brendel
--| Some none widgets are now created with make_for_test.
--|
--| Revision 1.22  2000/04/25 23:38:42  brendel
--| Started implementation of splash screen.
--|
--| Revision 1.21  2000/04/25 23:16:16  brendel
--| Added test area for non-widgets.
--|
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
