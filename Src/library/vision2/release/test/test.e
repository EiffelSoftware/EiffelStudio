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
			frame: EV_FRAME
			scroll: EV_SCROLLABLE_AREA
			notebook: EV_NOTEBOOK
			box: EV_BOX
			label: EV_LABEL
			i: INTEGER
			textable: EV_TEXTABLE
			pixmapable: EV_PIXMAPABLE
			container: EV_CONTAINER
			menu_bar: EV_MENU_BAR
			object_menu: EV_MENU
			button: EV_BUTTON
			event_test_frame: EV_FRAME
		do
			create scroll
			create notebook
			notebook.position_tabs_left
			create frame.make_with_text ("Eiffel Vision Widgets")
			create menu_bar
			create object_menu.make_with_text ("Other objects")
			create {EV_VERTICAL_BOX} box

			first_window.set_menu_bar (menu_bar)
			menu_bar.extend (object_menu)

			first_window.set_title ("Eiffel Vision Widgets")
			first_window.extend (box)
			box.extend (frame)
			frame.extend (scroll)
			scroll.extend  (notebook)

			create label.make_with_text ("Drop here!")
			create button.make_with_text ("Destroy widget")
			create event_test_frame.make_with_text ("Event test, triggering an event will remove it from list")
			box.extend (label)
			box.set_minimum_width (800)
			box.set_minimum_height (600)
			box.disable_child_expand (label)
			label.drop_actions.extend (~update_widget_label (label, event_test_frame, ?))
			button.press_actions.extend (~destroy_current_widget)
			box.extend (button)
			box.disable_child_expand (button)
			--box.extend (event_test_frame)
			--box.disable_child_expand (event_test_frame)
			
			notebook.fill (widgets)
			
			from
				notebook.start
			until
				notebook.after
			loop
				textable ?= notebook.item
				if textable /= Void then
					textable.set_text ("some text")
				end
			
--|				pixmapable ?= notebook.item
--|				if pixmapable /= Void then
--|					pixmapable.set_pixmap (EV_PIXMAP_OBJECT)
--|				end

				container ?= notebook.item
				if container /= Void then
					notebook.remove
					create {EV_VERTICAL_BOX} box
					box.extend (create {EV_LABEL}.make_with_text (container.generating_type))
					box.last.set_pebble (container)
					box.disable_child_expand (box.last)
					box.extend (container)
					notebook.put_left (box)
					notebook.set_item_text (box, container.generating_type)
					from
						i := 1
					until
						i = 6 or container.full
					loop
						create label.make_with_text ("item " + i.out)
						container.extend (label)
						label.set_pebble (label)
						inspect i
						when 1 then label.set_background_color (create {EV_COLOR}.make_with_rgb (0.7,0.2,0.2))
						when 2 then label.set_background_color (create {EV_COLOR}.make_with_rgb (0.7,0.7,0.2))
						when 3 then label.set_background_color (create {EV_COLOR}.make_with_rgb (0.2,0.7,0.2))
						when 4 then label.set_background_color (create {EV_COLOR}.make_with_rgb (0.2,0.7,0.7))
						when 5 then label.set_background_color (create {EV_COLOR}.make_with_rgb (0.2,0.2,0.7))
						end
						i := i + 1
					end
				else
					notebook.set_item_text (notebook.item, notebook.item.generating_type)
					notebook.item.set_pebble (notebook.item)
					notebook.forth
				end
			end
			menu_bar.extend (decendants (first_window))

			from
				non_widgets.start
			until
				non_widgets.after
			loop
				print ("H")
				object_menu.extend (
					create {EV_MENU_ITEM}.make_with_text (
						non_widgets.item.generating_type
					)
				)
				non_widgets.forth
			end
		end

	widgets: LINKED_LIST [EV_WIDGET] is
			-- List of different widgets.
		once
			create Result.make
			Result.extend (create {EV_CELL})
			Result.extend (create {EV_FRAME})
			Result.extend (create {EV_HORIZONTAL_BOX})
			Result.extend (create {EV_HORIZONTAL_SPLIT_AREA})
			Result.extend (create {EV_NOTEBOOK})
			Result.extend (create {EV_SCROLLABLE_AREA})
			Result.extend (create {EV_VERTICAL_BOX})
			Result.extend (create {EV_VERTICAL_SPLIT_AREA})
			Result.extend (create {EV_VIEWPORT})
			Result.extend (create {EV_BUTTON})
			Result.extend (create {EV_CHECK_BUTTON})
			Result.extend (create {EV_DRAWING_AREA})
			Result.extend (create {EV_HORIZONTAL_PROGRESS_BAR})
			Result.extend (create {EV_HORIZONTAL_RANGE})
			Result.extend (create {EV_HORIZONTAL_SCROLL_BAR})
			Result.extend (create {EV_HORIZONTAL_SEPARATOR})
			Result.extend (create {EV_LABEL})
			Result.extend (create {EV_LIST})
--|FIXME		Result.extend (create {EV_OPTION_BUTTON})
			Result.extend (create {EV_SPIN_BUTTON})
			Result.extend (create {EV_TEXT_FIELD})
			Result.extend (create {EV_TOGGLE_BUTTON})
			Result.extend (create {EV_TOOL_BAR})
			Result.extend (create {EV_VERTICAL_PROGRESS_BAR})
			Result.extend (create {EV_VERTICAL_RANGE})
			Result.extend (create {EV_VERTICAL_SCROLL_BAR})
			Result.extend (create {EV_VERTICAL_SEPARATOR})
			Result.extend (create {EV_PIXMAP})
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
			Result.extend (create {EV_ANGLE})
			Result.extend (create {EV_ANGLE_ROUTINES})
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
			Result.extend (create {EV_TOOL_BAR_SEPARATOR})
			Result.extend (create {EV_TOOL_BAR_TOGGLE_BUTTON})
			Result.extend (create {EV_TOOL_BAR_RADIO_BUTTON})
			Result.extend (create {EV_TOOL_BAR_RADIO_BUTTON})
			Result.extend (create {EV_ACCELERATOR})
			Result.extend (create {EV_COLOR})
			Result.extend (create {EV_COORDINATES})
			Result.extend (create {EV_CURSOR})
--|FIXME		Result.extend (create {EV_CURSOR_CODE})
			Result.extend (create {EV_ENVIRONMENT})
			Result.extend (create {EV_FONT})
			Result.extend (create {EV_FONT_CONSTANTS})
--|FIXME		Result.extend (create {EV_KEY_CODE})
			Result.extend (create {EV_RECTANGLE})
			Result.extend (create {EV_TIMEOUT})
			Result.extend (create {EV_DRAWABLE_CONSTANTS})
			Result.extend (create {EV_BASIC_COLORS})
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
			create Result.make_with_text ("Widget packing heirachy")
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

	update_widget_label (a_label: EV_LABEL; a_cell: EV_CELL; a_widget: EV_WIDGET) is
			-- Update `a_lable' with information about `a_widget'.
		local
			t: EV_TEXTABLE
			s: STRING
		do
--			a_cell.wipe_out
--			a_cell.extend (a_widget.action_sequence_test_widget)
			current_widget := a_widget
			s := "type   = " + a_widget.generating_type + "%N"
			s.append ("width  = " + a_widget.width.out + "%N")
			s.append ("height = " + a_widget.height.out + "%N")
			t ?= a_widget
			if t /= Void then
				s.append ("text   = " + t.text + "%N")
			end
			a_label.set_text (s)
		end

	destroy_current_widget is
		do
			if current_widget /= Void then
				current_widget.destroy
				current_widget := Void
			end
		end

	current_widget: EV_WIDGET

end

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
