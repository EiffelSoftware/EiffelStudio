indexing
	description: "EiffelVision text area. %
				  %Mswindows implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		
	EV_TEXT_COMPONENT_IMP
		undefine
			set_default_options
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
			shown as displayed,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end,
			line as wel_line,
			line_index as wel_line_index
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
			hide
		redefine
			default_style,
			default_ex_style,
			on_en_change,
			enable,
			disable,
			line_count
		end

creation
	make,
	make_with_text

feature -- Initialization

	make is
			-- Create an empty text area.
		do
			make_with_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create a text area with `txt' as label.
		do
			wel_make (default_parent, txt, 0, 0, 0, 0, 0)
		end

feature -- Access

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		do
			Result := wel_line (i - 1)
		end


feature -- Status Report
	
	line_count: INTEGER is
		do
			Result := ({WEL_MULTIPLE_LINE_EDIT} Precursor  ) + 1
		end

	first_character_from_line_number (a_line: INTEGER): INTEGER is	
		do
			Result := wel_line_index (a_line - 1) + 1
		end

	last_character_from_line_number (a_line: INTEGER): INTEGER is	
		do
			if
				valid_line_index (a_line + 1)
			then
				Result := first_character_from_line_number (a_line + 1) - 1
			else
				Result := text_length
			end
		end
	
feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		do
			if position = text.count+1 then
				append_text ("%R%N")
			else
				insert_text ("%R%N")
			end
		end

	search (str: STRING): INTEGER is
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
			if found then
				Result := index_of_search
			else
				Result := -1
			end
		end

feature {NONE} -- WEL Implementation
 
	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_child + Ws_visible + Ws_group 
					+ Ws_tabstop + Ws_border + Es_left
					+ Es_autohscroll + Es_autovscroll
					+ Ws_vscroll + Ws_hscroll + Es_multiline
					+ Es_wantreturn
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
			execute_command (Cmd_change, Void)
		end

	enable is
			-- Enable mouse and keyboard input.
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			cwin_enable_window (item, True)
			set_background_color (default_colors.Color_read_write)
		end

	disable is
			-- Disable mouse and keyboard input
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			cwin_enable_window (item, False)
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
