--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision text area. %
				  %Mswindows implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

	--| FIXME (David Solal)
	--| When selecting text using shift and page down, on the last page, the
	--| cursor does not move to the last position.

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		rename
			interface as ev_text_i_interface
		end
		
	EV_TEXT_COMPONENT_IMP
		rename
			interface as ev_text_component_imp_interface
		select
			ev_text_component_imp_interface
		end

	WEL_MULTIPLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as is_displayed,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end,
			line as wel_line,
			line_index as wel_line_index,
			current_line_number as wel_current_line_number,
			width as wel_width,
			height as wel_height,
			item as wel_item,
			caret_position as internal_caret_position,
			set_caret_position as internal_set_caret_position,
			enabled as is_sensitive,
			x as x_position,
			y as y_position,
			move as wel_move,
			move_and_resize as wel_move_and_resize,
			resize as wel_resize,
			set_text as wel_set_text,
			text as wel_text
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			show,
			hide,
			on_size
		redefine
			default_style,
			default_ex_style,
			on_en_change,
			enable,
			disable,
			line_count
		end

creation
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create an empty text area.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0,0)
			show_vertical_scroll_bar
		end

feature -- Access

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		do
			Result := wel_line (i - 1)
		end

	text: STRING is
			-- Edited by user.
		do
			Result := wel_text
			Result.prune_all ('%R')
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			exp: STRING
		do
			exp := clone (a_text)
			exp.replace_substring_all ("%N", "%R%N")
			wel_set_text (exp)
		end

feature -- Status Report

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		do
			Result := wel_current_line_number + 1
		end
	
	line_count: INTEGER is
		do
			Result := ({WEL_MULTIPLE_LINE_EDIT} Precursor  ) + 1
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER is	
		do
			Result := wel_line_index (a_line - 1) + 1
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER is	
		do
			if
				valid_line_index (a_line + 1)
			then
				Result := first_position_from_line_number (a_line + 1) - 1
			else
				Result := text_length
			end
		end

	has_system_frozen_widget: BOOLEAN is
			-- Is there any widget frozen?
			-- If a widget is frozen any updates made to it
			-- will not be shown until the widget is
			-- thawn again.
		do
			Result := has_system_window_locked
		end
	
feature -- Status Settings

	freeze is
			-- Freeze this widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- thawn again.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
			lock_window_update
		end

	thaw is
			-- Thaw a frozen widget.
		do
			unlock_window_update
		end


feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		do
			if caret_position = text.count+1 then
				append_text ("%R%N")
			else
				insert_text ("%R%N")
			end
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `-1'				
		local
			search_text: STRING
				-- The text to be searched.
			searched_for_text: STRING
				-- The string to be search for.
			searched_for_text_count: INTEGER
				-- The length of the string to be searched for.
			index_of_search: INTEGER
				-- The current index of the search.
			index_of_search_string: INTEGER
				-- The current index within the string that
				-- is being searched for.
			current_search_valid: BOOLEAN
				-- Is the current search position still valid?
			found: BOOLEAN
				-- Has the search text been found?
			positions_to_search: INTEGER
				-- The number of positions that must be searched.
		do
				-- calculate sums wherever possible outside the loops.
			search_text := text
			searched_for_text := str
			if searched_for_text.count <= search_text.count then
				-- Is the string to be searched larger than the text to be found.
				searched_for_text_count := searched_for_text.count
				positions_to_search := search_text.count - searched_for_text_count + 1
				from
					index_of_search := 0
					found := False
				until
					index_of_search = positions_to_search or
					found
				loop
					if (search_text.item (index_of_search+1) = searched_for_text.item (1)) then
						-- For improved speed, check the first character outside of the inner loop.
						if searched_for_text.count = 1 then
								found := true
						else
							from
								-- If the first character has matched and the length of the string is
								-- greater than one then loop through the remaining characters until
								-- it is known that the string is either contained or not contained.
								current_search_valid := True
								index_of_search_string := 2
							until
								not current_search_valid or
								found
							loop
								if not (search_text.item (index_of_search + index_of_search_string) =
								searched_for_text.item (index_of_search_string)) then
									current_search_valid := False
								elseif index_of_search_string = searched_for_text.count then
									found := True
								end
								index_of_search_string := index_of_search_string + 1
							end	
						end
					end
					index_of_search := index_of_search + 1
				end
			end
			if found then
				Result := index_of_search
			else
				Result := -1
			end
		end

feature -- Assertion

	last_line_not_empty: BOOLEAN is
			-- Has the last line at least one character?
		local
			str: STRING
			int: INTEGER
		do
			str := text
			int := str.count
			Result := not (str @ (int - 1 ) = '%R' and str @ int = '%N')
		end

feature {NONE} -- WEL Implementation
 
	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_child + Ws_visible + Ws_group 
					+ Ws_tabstop + Ws_border + Es_left
					+ Es_multiline + Es_wantreturn
					+ Es_autovscroll
		end

	default_ex_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_ex_clientedge
		end


	on_en_change is
			-- The user has taken an action
			-- that may have altered the text.
		do
			--|FIXME
			--execute_command (Cmd_change, Void)
		end

	enable is
			-- Enable mouse and keyboard input.
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			cwin_enable_window (wel_item, True)
			set_background_color (default_colors.Color_read_write)
		end

	disable is
			-- Disable mouse and keyboard input
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			cwin_enable_window (wel_item, False)
			set_background_color (default_colors.Color_read_only)
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {NONE} -- interface

	interface: EV_TEXT

end -- class EV_TEXT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2000/06/07 17:28:01  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.31.2.3  2000/05/08 22:14:29  brendel
--| Added FIXME.
--|
--| Revision 1.31.2.2  2000/05/03 22:35:05  brendel
--|
--| Revision 1.37  2000/05/03 20:13:27  brendel
--| Fixed resize_actions.
--|
--| Revision 1.36  2000/04/20 01:15:39  brendel
--| Redefined text and set_text to strip out/add CR's to text.
--|
--| Revision 1.35  2000/04/14 20:40:10  brendel
--| Is now vertically scrollable.
--|
--| Revision 1.34  2000/04/13 23:07:05  brendel
--| Unreleased.
--|
--| Revision 1.33  2000/04/04 17:50:37  rogers
--| renamed
--| 	x -> x_position,
--| 	y -> y_position,
--| 	move -> wel_move,
--| 	move_and_resize -> wel_move_and_resize,
--| 	resize -> wel_resize.
--| Removed undefinition of set_default_minimum_size.
--| Commented out body of on_en_change with a fixme.
--|
--| Revision 1.32  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.31.4.3  2000/01/27 19:30:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.31.4.2  1999/12/30 02:01:16  rogers
--| Changes to fit in with the new work.
--|
--| Revision 1.31.4.1  1999/11/24 17:30:34  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.30.2.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
