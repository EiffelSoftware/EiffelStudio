note
	description: "EiffelVision text area. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_IMP

inherit
	EV_TEXT_I
		undefine
			text_length
		redefine
			interface,
			selected_text
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			append_text,
			interface,
			make,
			insert_text,
			on_key_down,
			selected_text,
			ignore_character_code,
			is_multiline,
			is_replacing_nl_by_crnl,
			text_length
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
			set_selection as wel_set_selection,
			line as wel_line,
			line_index as wel_line_index,
			current_line_number as wel_current_line_number,
			width as wel_width,
			height as wel_height,
			item as wel_item,
			caret_position as wel_caret_position,
			set_caret_position as wel_set_caret_position,
			enabled as is_sensitive,
			x as x_position,
			y as y_position,
			move as wel_move,
			move_and_resize as wel_move_and_resize,
			resize as wel_resize,
			set_text as wel_set_text,
			text as wel_text,
			text_substring as wel_text_substring,
			has_capture as wel_has_capture,
			text_length as wel_text_length,
			line_count as wel_line_count,
			first_visible_line as wel_first_visible_line
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
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
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

	old_make (an_interface: attached like interface)
			-- Create `Current' empty.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			initialize_text_widget
			Precursor {EV_TEXT_COMPONENT_IMP}
			enable_scroll_caret_at_selection
		end

	initialize_text_widget
			-- Initialize text widget.
		do
			wel_make (default_parent, "", 0, 0, 0, 0,0)
			show_vertical_scroll_bar
				-- Remove the standard upper limit on characters in
				-- `Current'. Default is 32,767.
			{WEL_API}.send_message (wel_item, Em_limittext, to_wparam (0), to_lparam (0))
			set_default_font
		end

feature -- Access

	has_word_wrapping: BOOLEAN
			-- Is word wrapping enabled?
			-- If enabled, lines that are too long to be displayed
			-- in `Current' will be wrapped onto new lines.
			-- If disabled, a horizontal scroll bar will be displayed
			-- and lines will not be wrapped.
		do
			Result := not flag_set (style, Ws_hscroll)
		end

	is_replacing_nl_by_crnl: BOOLEAN
		do
			Result := True
		end

	line (i: INTEGER): STRING_32
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
					Result.append_character ('%N')
				end
			elseif i < line_count then
				Result.append_character ('%N')
			end
		end

	text: STRING_32
			-- Text of `Current'.
		local
			length: INTEGER
			l_wel_string: WEL_STRING
			nb: INTEGER
		do
			length := wel_text_length
			if length > 0 then
				length := length + 1
				--| FIXME IEK Replace with reusable buffer.
--				l_wel_string := wel_string_restricted (length)
				create l_wel_string.make_empty (length)
				nb := cwin_get_window_text (wel_item, l_wel_string.item, length)
				Result := l_wel_string.string_discarding_carriage_return
			else
				create Result.make (0)
			end
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			l_wel_string: WEL_STRING
		do
--			l_wel_string := wel_string_from_string_with_newline_conversion (a_text)
			create l_wel_string.make_with_newline_conversion (a_text)
			{WEL_API}.send_message (wel_item, {WEL_WM_CONSTANTS}.wm_settext, {WEL_API}.lparam (0), l_wel_string.item)

				-- Explicitly fire En_change action to emulate single line behavior.
			{WEL_API}.send_message (default_parent.item, Wm_command, to_wparam (En_change |<< 16) , wel_item)
		end

	line_count: INTEGER
			-- Number of lines of text in `Current'.
		do
			Result := wel_line_count
		end

	first_visible_line: INTEGER
			-- <Precursor>
		do
			Result := wel_first_visible_line + 1
		end

	insert_text (txt: READABLE_STRING_GENERAL)
			-- Insert `txt' at `caret_position'.
		local
			previous_caret_position: INTEGER
			sel_start, sel_end: INTEGER
			l_wel_string: WEL_STRING
		do
			previous_caret_position := internal_wel_caret_position
			if has_selection then
				sel_start := wel_selection_start
				sel_end := wel_selection_end
				wel_set_selection (previous_caret_position, previous_caret_position)
			end
			create l_wel_string.make_with_newline_conversion (txt)
			{WEL_API}.send_message (wel_item, Em_replacesel, to_wparam (0), l_wel_string.item)
			if has_selection then
				wel_set_selection (sel_start, sel_end)
			end
			wel_set_caret_position (previous_caret_position)
		end

feature -- Status Report

	current_line_number: INTEGER
			-- Returns the number of the line the cursor currently
			-- is on.
		do
			Result := wel_current_line_number + 1
		end

	first_position_from_line_number (a_line: INTEGER): INTEGER
			-- Position of the first character on the `i'-th line.
		local
			new_lines_to_first_position: INTEGER
		do
			new_lines_to_first_position := wel_text.substring (1, wel_line_index (a_line - 1)).occurrences ('%R')
				-- We must not include the %R as the Vision2 interface does not include them.
			Result := wel_line_index (a_line - 1) + 1 - new_lines_to_first_position
		end

	last_position_from_line_number (a_line: INTEGER): INTEGER
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

	line_number_from_position (i: INTEGER): INTEGER
			-- Line containing caret position `i'.
		local
			l_actual_caret_position: INTEGER
		do
			l_actual_caret_position := actual_position_from_caret_position (i)
			Result := {WEL_API}.send_message_result_integer (wel_item, em_linefromchar,
				to_wparam (l_actual_caret_position + 1), to_lparam (0)) + 1
		end

	selected_text: STRING_32
			-- Text currently selected in `Current'.
		local
			start_pos, end_pos, nb: INTEGER
			l_wel_string: WEL_STRING
		do
				-- Selection is given in code units not in visible characters.
			{WEL_API}.send_message (wel_item, Em_getsel, $start_pos, $end_pos)
			check end_greater_than_start: start_pos <= end_pos end
				-- Create a WEL_STRING big enough to contain up to the end of the selection.
			create l_wel_string.make_empty (end_pos + 1)
			nb := cwin_get_window_text (wel_item, l_wel_string.item, end_pos + 1)
			check valid_count: nb = end_pos  end
			Result := l_wel_string.substring (start_pos + 1, end_pos)
			Result.prune_all ('%R')
		end

	text_length: INTEGER
			-- Number of characters comprising `text'. This is an optimized
			-- version, which only recomputes the length if not `text_up_to_date'.
		local
			l_length: INTEGER
		do
			if not text_up_to_date then
				Result := Precursor {EV_TEXT_COMPONENT_IMP}
				internal_text_length := Result
				text_up_to_date := True
			else
				l_length := cwin_get_window_text_length (wel_item)
				if l_length /= internal_wel_text_length then
					Result := Precursor {EV_TEXT_COMPONENT_IMP}
					internal_text_length := Result
					internal_wel_text_length := l_length
				else
					Result := internal_text_length
				end
			end
		end

feature -- Status Settings

	enable_word_wrapping
			-- Ensure `has_word_wrap' is True.
		do
			recreate_current (0)
		end

	disable_word_wrapping
			-- Ensure `has_word_wrap' is False.
		do
			recreate_current (ws_hscroll)
		end

	append_text (txt: READABLE_STRING_GENERAL)
			-- Append `txt' to end of `text'.
		local
			previous_caret_position: INTEGER
			l_wel_string: WEL_STRING
		do
			previous_caret_position := internal_wel_caret_position
			wel_set_caret_position (wel_text_length)
			create l_wel_string.make_with_newline_conversion (txt)
			{WEL_API}.send_message (wel_item, Em_replacesel, to_wparam (0), l_wel_string.item)
			wel_set_caret_position (previous_caret_position)
		end

feature -- Basic operation

	scroll_to_line (i: INTEGER)
			-- Ensure that line `i' is visible in `Current'.
		do
			scroll (0, i - wel_first_visible_line - 1)
		end

	scroll_to_end
			-- Ensure that the last line is visible in `Current'.
		do
			scroll_to_line (line_count)
		end

feature {NONE} -- Implementation

	ignore_character_code (a_character_code: INTEGER): BOOLEAN
			-- Should default processing for `a_character_code' be ignored?
		do
			-- All characters need to be default processed.
		end

	internal_text_length: INTEGER
		-- Internal length of `text' in `Current'. This is only recomputed when
		-- `text_length' is called and `text_up_to_date' is False.
		-- It is the length in number of characters.

	text_up_to_date: BOOLEAN
		-- Is `text' of `Current' up to date? Used to buffer calls to `text' and `text_length'.

	internal_wel_text_length: INTEGER
		-- The last value that windows returned as being the text length.
		-- We cannot use this directly as it includes %R%N but we can use
		-- it as a final check in `wel_text_length' to see if we must recomupte
		-- the length.
		-- It is the length in number of code units, not characters.

feature {NONE} -- WEL Implementation

	background_brush: detachable WEL_BRUSH
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
		do
				-- We always use `background_color', unless `Current' has been made
				-- non editable, and the user has not set a background color. Otherwise,
				-- we let Window erase the content itself.
			if is_editable or background_color_imp /= Void then
				if attached {EV_COLOR_IMP} background_color.implementation as l_color then
					create Result.make_solid (l_color)
				end
			end
		end

	default_style: INTEGER
			-- Default windows style used to create `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_group
					+ Ws_tabstop + Ws_border + Es_left
					+ Es_multiline + Es_wantreturn
					+ Es_autovscroll + Ws_clipchildren
					+ Ws_clipsiblings + es_nohidesel
		end

	default_ex_style: INTEGER
			-- Extended windows style used to create `Current'.
		do
			Result := Ws_ex_clientedge
		end

	is_multiline: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	on_en_change
			-- `Text' has been modified.
			--| We call the change_actions.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call (Void)
			end
				-- Force recomputation of the length for performance.
			text_up_to_date := False
		end

	enable
			-- Enable mouse and keyboard input.
		do
			cwin_enable_window (wel_item, True)
		end

	disable
			-- Disable mouse and keyboard input
		do
			cwin_enable_window (wel_item, False)
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- Executed when a key is pressed.
		do
			if virtual_key = vk_escape and then attached {EV_DIALOG} top_level_window then
					-- There is a bug in Windows where if you hit ESC in a multiline
					-- edit parented at some level within a dialog, it posts a WM_CLOSE
					-- to its parent in the mistaken belief that it is part of a dialog box.
					-- By redefining `on_key_down' here, we can prevent this behaviour. Julian.
					-- Search comp.os.ms-windows.programmer.controls for "hit ESC in a multiline edit".
					-- We only perform the disable if `Current' is actually parented in a dialog.
				disable_default_processing
			end
			if read_only then
				process_navigation_key (virtual_key)
			end
			Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
		end

	recreate_current (a_additional_style: INTEGER)
			-- Destroy the existing widget and recreate current using the new style added with `a_additional_style'.
		local
			par_imp: detachable WEL_WINDOW
			cur_x: INTEGER
			cur_y: INTEGER
			cur_width: INTEGER
			cur_height: INTEGER
			l_sensitive: like is_sensitive
			l_tooltip: like tooltip
			l_text: like text
			l_caret: like caret_position
			l_is_read_only: like read_only
		do
			l_sensitive := is_sensitive
			l_tooltip := tooltip
			l_text := text
			l_caret := caret_position
			l_is_read_only := read_only
			set_tooltip ("")

				-- We keep some useful informations that will be
				-- destroyed when calling `wel_destroy'
			par_imp ?= parent_imp
				-- `Current' may not have been actually physically parented
				-- within windows yet.
			if par_imp = Void then
				par_imp ?= default_parent
			end
			cur_x := x_position
			cur_y := y_position
			cur_width := ev_width
			cur_height := ev_height

					-- We destroy the widget
			wel_destroy

				-- We create the new combo.
			internal_window_make (par_imp, "", default_style + a_additional_style, cur_x, cur_y, cur_width, cur_height, 0, default_pointer)
			{WEL_API}.send_message (wel_item, Em_limittext, to_wparam (0), to_lparam (0))
			show_vertical_scroll_bar

				-- Restore the previous settings.
			if private_font /= Void then
				set_font (private_font)
			else
				set_default_font
			end
			if not l_sensitive then
				disable_sensitive
			end
			if foreground_color_imp /= Void then
				set_foreground_color (foreground_color)
			end
			set_tooltip (l_tooltip)
			set_text (l_text)
			set_caret_position (l_caret)
			if l_is_read_only then
				set_read_only
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
