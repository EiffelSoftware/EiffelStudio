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
		
	EV_FONTABLE_IMP
		redefine
			interface
		end
		
	EV_TEXT_COMPONENT_IMP
		redefine
			append_text,
			interface,
			initialize,
			selection_start,
			selection_end,
			set_caret_position,
			caret_position,
			insert_text
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
			has_capture as wel_has_capture,
			text_length as wel_text_length,
			line_count as wel_line_count
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
			on_mouse_wheel,
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
			background_brush
		end

	WEL_EM_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_LOCK
		export
			{NONE} all
		end

create
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
		
	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

feature -- Access

	has_word_wrapping: BOOLEAN is
			-- Is word wrapping enabled?
			-- If enabled, lines that are too long to be displayed
			-- in `Current' will be wrapped onto new lines.
			-- If disabled, a horizontal scroll bar will be displayed
			-- and lines will not be wrapped.
		do
			Result := not flag_set (style, Ws_hscroll)
		end

	line (i: INTEGER): STRING is
			-- `Result' is content of the `i'th line.
		do
			Result := wel_line (i - 1)
				-- `wel_line' does not include the new line characters, so must add a
				-- new line character if necessary. As word wrapping may be enabled, we must
				-- only add the new line character if enabled, and the line really should
				-- have a new character, for example, if the line was wrapped, then we must not append.
				-- This is calculated by comparing the length of the line with the start offset and
				-- the start offset of the next line, to determine if the new line character is missing.
			if has_word_wrapping then
				if i < line_count and then wel_line_index (i) > Result.count + wel_line_index (i - 1) then
					Result.append ("%N")
				end
			elseif i < line_count then
				Result.append ("%N")
			end
		end

	text: STRING is
			-- text of `Current'.
		do
			Result := wel_text
			Result.prune_all ('%R')
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			exp: STRING
		do
			if a_text /= Void then
				exp := a_text.twin
					-- Replace "%N" with "%R%N" for Windows.
				convert_string (exp)
			end
			wel_set_text (exp)
		end
		
	line_count: INTEGER is
			-- Number of lines of text in `Current'.
		do
			Result := wel_line_count
		end
		
	caret_position: INTEGER is
			-- Current position of caret.
		local
			new_lines_to_caret_position: INTEGER
		do
			new_lines_to_caret_position := wel_text.substring (1, internal_caret_position).occurrences ('%R')
			Result := internal_caret_position + 1 - new_lines_to_caret_position
		end
		
	insert_text (txt: STRING) is
			-- Insert `txt' at `caret_position'.
		local
			previous_caret_position: INTEGER
			a_string: STRING
			sel_start, sel_end: INTEGER
		do
			if has_selection then
				sel_start := selection_start
				sel_end := selection_end
				set_selection (caret_position - 1, caret_position - 1)
			end
			previous_caret_position := internal_caret_position
			a_string := txt
			convert_string (a_string)
			replace_selection (a_string)
			if has_selection then
				set_selection (sel_start - 1, sel_end - 1)
			end
			internal_set_caret_position (previous_caret_position)
		end

feature -- Status Report

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		do
			Result := wel_current_line_number + 1
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER is	
			-- Position of the first character on the `i'-th line.
		local
			new_lines_to_first_position: INTEGER
		do
			new_lines_to_first_position := wel_text.substring (1, wel_line_index (a_line - 1)).occurrences ('%R')
				-- We must not include the %R as the Vision2 interface does not include them.
			Result := wel_line_index (a_line - 1) + 1 - new_lines_to_first_position
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		local
			new_lines_to_first_position: INTEGER
		do
			if
				valid_line_index (a_line + 1)
			then
				Result := first_position_from_line_number (a_line + 1) - 1
			else
				new_lines_to_first_position := wel_text.substring (1, wel_line_index (a_line - 1)).occurrences ('%R')
				Result := wel_text_length - new_lines_to_first_position			
			end
		end
		
	line_number_from_position (i: INTEGER): INTEGER is
			-- Line containing caret position `i'.
		do
			Result := cwin_send_message_result (wel_item, em_linefromchar, i + 1, 0) + 1
		end
		
	selection_start: INTEGER is
			-- Index of first character selected.
		local
			new_lines_to_start: INTEGER
			
		do
			new_lines_to_start := wel_text.substring (1, wel_selection_start).occurrences ('%R')
			Result := wel_selection_start + 1 - new_lines_to_start
		end

	selection_end: INTEGER is
			-- Index of last character selected.
		local
			new_lines_to_end: INTEGER
		do
			new_lines_to_end := wel_text.substring (1, wel_selection_end).occurrences ('%R')
			Result := wel_selection_end - new_lines_to_end
		end
	
feature -- Status Settings

	enable_word_wrapping is
			-- Ensure `has_word_wrap' is True.
		local
			old_text: STRING
		do
			old_text := text
			wel_destroy
			internal_window_make (wel_parent, "", default_style, 0, 0, 0, 0, 0, default_pointer)
			set_default_font
			set_text (old_text)
			cwin_send_message (wel_item, Em_limittext, 0, 0)
			show_vertical_scroll_bar
			if parent_imp /= Void then
				parent_imp.notify_change (2 + 1, Current)
			end
		end
		
	disable_word_wrapping is
			-- Ensure `has_word_wrap' is False.
		local
			old_text: STRING
		do
			old_text := text
			wel_destroy
			internal_window_make (wel_parent, "", default_style + Ws_hscroll, 0, 0, 0, 0, 0, default_pointer)
			set_default_font
			set_text (old_text)
			cwin_send_message (wel_item, Em_limittext, 0, 0)
			show_vertical_scroll_bar
			if parent_imp /= Void then
				parent_imp.notify_change (2 + 1, Current)
			end
		end

	append_text (txt: STRING) is
			-- Append `txt' to end of `text'.
		local
			previous_caret_position: INTEGER
			a_string: STRING
		do
			a_string := txt.twin
			previous_caret_position := internal_caret_position
			internal_set_caret_position (wel_text_length)
				-- Replace "%N" with "%R%N" for Windows.
			convert_string (a_string)
			replace_selection (a_string)
			internal_set_caret_position (previous_caret_position)
		end
		
	set_caret_position (pos: INTEGER) is
			-- set current caret position.
			--| This position is used for insertions.
		local
			new_lines: INTEGER
			a: SPECIAL [CHARACTER]
			counter: INTEGER
			nb: INTEGER
		do
				-- We cannot simply call `occurrances' on `wel_text' to determine how
				-- many new line characters there are before `pos' as each time one is
				-- found, we must increase `pos' by one. This is because from the interface,
				-- new lines are "%N" but on Windows they are "%R%N".
			a := wel_text.area
			from
				counter := 0
				nb := pos - 1
			until
				counter > nb
			loop
				if a.item (counter) = '%R' then
					new_lines := new_lines + 1
					nb := nb + 1
				end
				counter := counter + 1
			end
				-- We store `pos' so caret position can be restored
				-- after operations that should not move caret, but do.
			internal_set_caret_position (pos - 1 + new_lines)
		end

feature -- Basic operation

	scroll_to_line (i: INTEGER) is
			-- Ensure that line `i' is visible in `Current'.
		do
			scroll (0, i - first_visible_line - 1)
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
			if index > 0 and then (index = 1 or else a_string.item (index - 1) /= '%R') then
				a_string.replace_substring_all ("%N", "%R%N")
			end
		end

feature {NONE} -- WEL Implementation

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
		local
			back: WEL_COLOR_REF
		do
				-- We always use the background color, unless `Current' has been made
				-- non editable, and the user has not set a background color.
			if (not is_editable and background_color_imp /= Void) or is_editable then
				back ?= background_color.implementation
			else
				create back.make_system (Color_btnface)
			end
			check
				background_color_not_void: back /= Void
			end
			create Result.make_solid (back)
		end
 
	default_style: INTEGER is
			-- Default windows style used to create `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_group 
					+ Ws_tabstop + Ws_border + Es_left
					+ Es_multiline + Es_wantreturn
					+ Es_autovscroll + Ws_clipchildren
					+ Ws_clipsiblings
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
				change_actions_internal.call (Void)
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

