indexing
	description: "EiffelVision text area. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

	--| FIXME (David Solal)
	--| When selecting text using shift and page down, on the last page, the
	--| cursor does not move to the last position.

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		redefine
			interface
		end
		
	EV_TEXT_COMPONENT_IMP
		redefine
			append_text,
			interface
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
			text as wel_text,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			select_all,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			default_ex_style,
			on_en_change,
			enable,
			disable,
			line_count
		end

	WEL_EM_CONSTANTS

creation
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' empty.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0,0)
			show_vertical_scroll_bar
				-- Remove the standard upper limit on characters in
				-- `Current'. Default is 32,767.
			cwin_send_message (wel_item, Em_limittext, 0, 0)
		end

feature -- Access

	line (i: INTEGER): STRING is
			-- `Result' is content of the `i'th line.
		do
			Result := wel_line (i - 1)
		end

	text: STRING is
			-- text of `Current'.
		do
			Result := wel_text
			Result.prune_all ('%R')
			if Result.count = 0 then
				Result := Void
			end
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			exp: STRING
		do
			if a_text /= Void then
				exp := clone (a_text)
					-- Replace "%N" with "%R%N" for Windows.
				convert_string (exp)
			end
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
			-- Number of lines of text in `Current'.
		do
			Result := ({WEL_MULTIPLE_LINE_EDIT} Precursor  ) + 1
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER is	
			-- Position of the first character on the `i'-th line.
		do
			Result := wel_line_index (a_line - 1) + 1
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
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

	append_text (txt: STRING) is
			-- Append `txt' to end of `text'.
		local
			previous_caret_position: INTEGER
			a_string: STRING
		do
			a_string := clone (txt)
			previous_caret_position := caret_position
			if interface.text /= Void then
				set_caret_position (text_length + 1)
			end
				-- Replace "%N" with "%R%N" for Windows.
			convert_string (a_string)
			replace_selection (a_string)
			set_caret_position (previous_caret_position)
		end

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

	scroll_to_line (i: INTEGER) is
			-- Ensure that line `i' is visible in `Current'.
		do
			scroll (0, i - first_visible_line - 1)
		end

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
			-- `Result' is index of first occurance of `str' in
			-- `text' from position `start', or -1 if `str'
			-- not contained in `text'.
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
				-- Is the string to be searched larger than the text
				-- to be found.
				searched_for_text_count := searched_for_text.count
				positions_to_search := search_text.count -
					searched_for_text_count + 1
				from
					index_of_search := 0
					found := False
				until
					index_of_search = positions_to_search or
					found
				loop
					if (search_text.item (index_of_search+1) =
						searched_for_text.item (1)) then
						-- For improved speed, check the first character
						-- outside of the inner loop.
						if searched_for_text.count = 1 then
								found := true
						else
							from
								-- If the first character has matched and the
								-- length of the string is greater than one
								-- then loop through the remaining characters
								-- until it is known that the string is either
								-- contained or not contained.
								current_search_valid := True
								index_of_search_string := 2
							until
								not current_search_valid or
								found
							loop
								if not (search_text.item (index_of_search +
									index_of_search_string) =
									searched_for_text.item
									(index_of_search_string)) then
									current_search_valid := False
								elseif index_of_search_string =
									searched_for_text.count then
									found := True
								end
								index_of_search_string :=
									index_of_search_string + 1
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

feature {NONE} -- Implementation

	convert_string (a_string: STRING) is
			-- Replace all "%N" with "%R%N" which is the Windows new line
			-- character symbol.
		require
			a_string /= Void
		local
			index: INTEGER
		do
			index := a_string.index_of ('%N', 1)
				-- Doing the convertion this way will stop us from walking down a string
				-- twice when there is no %N nor %R%N in the string.
			if index > 0 and then (index = 1 or else a_string @ index - 1 /= '%R') then
				a_string.replace_substring_all ("%N", "%R%N")
			end
		end

feature {NONE} -- WEL Implementation
 
	default_style: INTEGER is
			-- Default windows style used to create `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_group 
					+ Ws_tabstop + Ws_border + Es_left
					+ Es_multiline + Es_wantreturn
					+ Es_autovscroll
		end

	default_ex_style: INTEGER is
			-- Extended windows style used to create `Current'.
		do
			Result := Ws_ex_clientedge
		end


	on_en_change is
			-- `Text' has been modified.
			--| We call the change_actions.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call ([])
			end
		end

	enable is
			-- Enable mouse and keyboard input.
		local
			default_colors: EV_STOCK_COLORS
		do
			create default_colors
			cwin_enable_window (wel_item, True)
			set_background_color (default_colors.Color_read_write)
		end

	disable is
			-- Disable mouse and keyboard input
		local
			default_colors: EV_STOCK_COLORS
		do
			create default_colors
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
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

