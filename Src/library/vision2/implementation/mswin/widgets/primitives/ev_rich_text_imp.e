--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description:
		" EiffelVision text. A text area that contains%
		% a rich text."
	note: "It doesn't inherit from EV_TEXT_IMP because%
		% it is different from the WEL hierarchy."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP

inherit
	EV_RICH_TEXT_I
		undefine
			selected_text
		end

	EV_SCROLLABLE_TEXT_IMP
		rename
			wel_make as multiple_line_edit_make,
			make as scrollable_make,
			make_with_text as scrollable_make_with_text,
			make_with_properties as scrollable_make_with_properties
		export
			{NONE} 
				add_change_command, 
				remove_change_commands,
				scrollable_make,
				scrollable_make_with_text,
				scrollable_make_with_properties,
				show_vertical_scroll_bar,
				hide_vertical_scroll_bar,
				show_horizontal_scroll_bar,
				hide_horizontal_scroll_bar
		undefine
			text,
			set_text,
			class_name,
			default_style,
			default_ex_style,
			set_tab_stops,
			set_default_tab_stops,
			set_tab_stops_array,
			selected_text,
			wel_selection_end,
			wel_selection_start,
			set_selection,
			has_selection,
			set_text_limit,
			insert_text,
			process_notification_info,
			caret_position,
			wel_current_line_number,
			set_caret_position
		redefine
			search,
			set_background_color,
			set_position,
			append_text,
			prepend_text,
			on_char,
			on_key_down,
			on_key_up
		end

	WEL_RICH_EDIT_IMPROVED
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			set_background_color as wel_set_background_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as displayed,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end,
			line_number_from_position as wel_line_number_from_position,
			line as wel_line,
			line_index as wel_line_index,
			current_line_number as wel_current_line_number
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
			on_char,
			on_set_focus,
			on_kill_focus,
			on_key_up,
			on_key_down,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			on_en_change,
			enable,
			disable,
			line_count,
			show,
			hide
		redefine
			default_style,
			on_char,
			on_key_down,
			on_key_up
		end

	WEL_CLIPBOARD

creation
	make_with_properties,
	work_around_make

feature {NONE} -- Initialization

	work_around_make (par: EV_CONTAINER) is
			-- Because of a bug in the Rich Edit Control (Version 1)
			-- we need to create the control with the real parent.
		local
			ww: WEL_WINDOW
		do
			ww ?= par.implementation
			wel_make (ww, "", 0, 0, 0, 0, 0)
			set_event_mask (enm_change + enm_keyevents)
		end

	make_with_properties (txt: STRING; hscroll: BOOLEAN) is
			-- Create a rich text area with `par' as parent and
			-- `txt' as text. Vertically scrollable and
			-- if `hscroll' then horizontally scrollable.
		do
			scrollable_make_with_properties (txt, hscroll, True)
			enable_all_notifications
			set_event_mask (enm_keyevents + enm_change)
		end
	
feature -- Access

	character_format: EV_CHARACTER_FORMAT is
			-- Current character format.
		local
			wel: WEL_CHARACTER_FORMAT		
		do
			create Result.make
			wel?= Result.implementation
			wel.set_all_masks
			cwin_send_message (item, Em_getcharformat, 1,
				wel.to_integer)
		end

feature -- Status setting

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		local
			tt: EV_RICH_TEXT
		do
			tt ?= interface
			format.apply (tt)
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		local
			format: EV_CHARACTER_FORMAT
		do
			format := character_format
			set_caret_position (pos - 1)
			set_character_format (format)
		end

	format_region (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Set the format of the text between `first_pos' and `last_pos' to
			-- `format'.
		do
			select_region (first_pos, last_pos)
			set_character_format (format)
		end

feature -- Status Report

	line_number_from_position (a_pos: INTEGER): INTEGER is
		do
			Result := wel_line_number_from_position (a_pos - 1) + 1
		end

feature -- Element change

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			{EV_SCROLLABLE_TEXT_IMP} Precursor (color)
			wel_set_background_color (background_color_imp)
		end

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		local
			wel: WEL_CHARACTER_FORMAT
		do
			wel ?= format.implementation
			set_character_format_selection (wel)
		end

	append_text (txt:STRING) is
			-- append 'txt' into component
		do
			set_position (text.count + 1)
			insert_text (txt)
		end

	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		do
			set_position (1)
			insert_text (txt)
		end


	remove_text (start_pos, end_pos: INTEGER) is
			-- Remove the text between `start_pos' and `end_pos'.
		do
			hide_selection
			select_region (start_pos, end_pos)
			delete_selection
			show_selection
		end

feature -- Basic operation

	search (str: STRING; start: INTEGER): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		do
			Result := find (str, True, start) + 1
		end

	index_from_position (value_x, value_y: INTEGER): INTEGER is
			-- One-based character index of the character which is
			-- the nearest to `a_x' and `a_y' position in the client
			-- area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area. The coordinates are truncated
			-- to integer values and are in screen units relative
			-- to the upper-left corner of the client area of the
			-- control.
		do
			Result := character_index_from_position (value_x, value_y) + 1
		end

	position_from_index (value: INTEGER): EV_COORDINATES is
			-- Coordinates of a character at `value' in
			-- the client area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area.
			-- The coordinates are truncated to integer values and
			-- are in screen units relative to the upper-left
			-- corner of the client area of the control.
		local
			wel: WEL_POINT
		do
			wel := position_from_character_index (value - 1)
			create Result.set (wel.x, wel.y)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
   			-- Default style used to create the control
  		do
  			Result := ws_visible + ws_child
					+ Ws_vscroll + Ws_border
					+ Es_autovscroll
					+ Es_multiline
					+ Es_disablenoscroll
			if has_horizontal_scrolling then
				Result := Result + Es_autohscroll + Ws_hscroll
			end
		end

	on_char (character_code, key_data: INTEGER) is
		do
			{WEL_RICH_EDIT_IMPROVED} Precursor (character_code, key_data)
			{EV_SCROLLABLE_TEXT_IMP} Precursor (character_code, key_data)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Wm_keydown message
		do
			{WEL_RICH_EDIT_IMPROVED} Precursor (virtual_key, key_data)
			{EV_SCROLLABLE_TEXT_IMP} Precursor (virtual_key, key_data)
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Wm_keydown message
		do
			{WEL_RICH_EDIT_IMPROVED} Precursor (virtual_key, key_data)
			{EV_SCROLLABLE_TEXT_IMP} Precursor (virtual_key, key_data)
		end

	get_insert_character_data (chr: CHARACTER): EV_INSERT_TEXT_EVENT_DATA is
		local
			rich_text: EV_RICH_TEXT
			a_text: STRING
		do
			create Result.make
			rich_text ?= interface
			check
				valid_cast: rich_text /= Void
			end
			if
				chr = '%R'
			then
				a_text := clone ("%R%N")
			else
				a_text := chr.out
			end
			Result.implementation.set_all (rich_text, rich_text.position, a_text)
		end

	get_paste_data: EV_INSERT_TEXT_EVENT_DATA is
		require
			exists: exists
		local
			rich_text: EV_RICH_TEXT
		do
			create Result.make
			rich_text ?= interface
			check
				valid_cast: rich_text /= Void
			end
			open_clipboard (Current)

			check
				success: clipboard_open
			end
			
			retrieve_clipboard_text
			print (last_string)
			close_clipboard
			Result.implementation.set_all (rich_text, rich_text.position, last_string)
		end

	get_delete_left_character_data: EV_DELETE_TEXT_EVENT_DATA is
		require
			has_character_at_position: text.valid_index (position - 1)
		local
			rich_text: EV_RICH_TEXT
		do
			create Result.make
			rich_text ?= interface
			check
				valid_cast: rich_text /= Void
			end
			
			check
				don_t_know_yet_what_todo: rich_text.valid_position (rich_text.position - 1)
			end
			Result.implementation.set_all (rich_text, rich_text.position, rich_text.position - 1, rich_text.position - 1, rich_text.text.item (position - 1).out)
		end

	get_delete_right_character_data: EV_DELETE_TEXT_EVENT_DATA is
		require
			has_character_at_position: text.valid_index (position)
		local
			rich_text: EV_RICH_TEXT
		do
			create Result.make
			rich_text ?= interface
			check
				valid_cast: rich_text /= Void
			end
			
			check
				don_t_know_yet_what_todo: rich_text.valid_position (rich_text.position)
			end
			
			Result.implementation.set_all (rich_text, rich_text.position, rich_text.position, rich_text.position, rich_text.text.item (position).out)
		end
		

		get_delete_selection_data: EV_DELETE_TEXT_EVENT_DATA is
			local
				rich_text: EV_RICH_TEXT
			do
				create Result.make
				rich_text ?= interface
				check
					valid_cast: rich_text /= Void
				end
				
				Result.implementation.set_all (rich_text, rich_text.position, rich_text.selection_start, rich_text.selection_end, rich_text.selected_text)
			end

feature		

	on_insert_character (chr: CHARACTER) is
			-- Execute whenever the user inserts a character
			-- into the text
		local
			data: EV_INSERT_TEXT_EVENT_DATA
		do
			if 
				has_command (Cmd_insert_text) 
			then
				data := get_insert_character_data (chr)
				execute_command (Cmd_insert_text, data)
			end
		end

	on_delete_left_character is
			-- Execute whenever the user deletes the left character
		local
			data: EV_DELETE_TEXT_EVENT_DATA
		do
			if
				text.valid_index (position - 1)
			then
				if 
					has_command (Cmd_delete_text) 
				then
					data := get_delete_left_character_data
					execute_command (Cmd_delete_text, data)
				end
			end
		end

	on_delete_right_character is
			-- Execute whenever the user deletes the right character
		local
			data: EV_DELETE_TEXT_EVENT_DATA
		do
			if
				text.valid_index (position)
			then
				if 
					has_command (Cmd_delete_text) 
				then
					data := get_delete_right_character_data
					execute_command (Cmd_delete_text, data)
				end
			end
		end

	on_undo is
			-- Execute whenever the user inserts a character
			-- into the text
		do
			if 
				has_command (Cmd_undo) 
			then
				execute_command (Cmd_undo, Void)
			end
		end

	on_redo is
			-- Execute whenever the user inserts a character
			-- into the text
		do
			if 
				has_command (Cmd_redo) 
			then
				execute_command (Cmd_redo, Void)
			end
		end

	on_paste_clipboard is
			-- Execute whenever the user pastes the clipborad
			-- into the control
		local
			data: EV_INSERT_TEXT_EVENT_DATA
		do
			if 
				has_command (Cmd_insert_text) 
			then
				data := get_paste_data
				execute_command (Cmd_insert_text, data)
			end
		end


	on_delete_selection is
		local
			data: EV_DELETE_TEXT_EVENT_DATA
		do
			if
				has_selection
			then
				if 
					has_command (Cmd_delete_text) 
				then
					data := get_delete_selection_data
					execute_command (Cmd_delete_text, data)
				end
			end
		end
		
	on_cut_selection is
		do
			on_delete_selection
		end

feature -- Event - command association

	add_insert_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user inputs a text.
		do
			add_command (Cmd_insert_text, cmd, arg)
		end

	add_delete_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user deletes a text.
		do
			add_command (Cmd_delete_text, cmd, arg)
		end

	add_delete_right_character_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user deletes the right character.
		do
			add_command (Cmd_delete_right_character, cmd, arg)
		end

	add_undo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to undo a command.
		do
			add_command (Cmd_undo, cmd, arg)
		end

	add_redo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to redo a command.
		do
			add_command (Cmd_redo, cmd, arg)
		end

feature -- Event -- removing command association

	remove_insert_text_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs a text.
		do
			remove_command (cmd_insert_text)			
		end

	remove_delete_text_commands is
			-- Empty the list of commands to be executed when
			-- when the user deletes a text.
		do
			remove_command (cmd_delete_text)			
		end

	remove_delete_right_character_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to delete the left character.
		do
			remove_command (cmd_delete_right_character)			
		end

	remove_undo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to undo a command.
		do
			remove_command (cmd_undo)			
		end

	remove_redo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to redo a command.
		do
			remove_command (cmd_redo)			
		end

end -- class EV_RICH_TEXT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.22  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.19.2.2.2.2  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.19.2.2.2.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
