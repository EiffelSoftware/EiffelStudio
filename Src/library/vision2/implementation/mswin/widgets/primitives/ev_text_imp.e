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
		rename
			set_selection as text_component_imp_set_selection
		redefine
			interface,
			selected_text
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		rename
			internal_set_caret_position as wel_set_caret_position
		redefine
			append_text,
			interface,
			make,
			selection_start,
			selection_end,
			set_caret_position,
			caret_position,
			insert_text,
			on_key_down,
			select_region,
			selected_text,
			ignore_character_code,
			text_component_imp_set_selection
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

	old_make (an_interface: like interface)
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
				l_wel_string := wel_string_restricted (length)
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
			l_wel_string := wel_string_from_string_with_newline_conversion (a_text)
			{WEL_API}.send_message (wel_item, {WEL_WM_CONSTANTS}.wm_settext, {WEL_API}.lparam (0), l_wel_string.item)

				-- Explicitly fire En_change action to emulate single line behavior.
			{WEL_API}.send_message (default_parent.item, Wm_command, to_wparam (En_change |<< 16) , wel_item)
		end

	line_count: INTEGER
			-- Number of lines of text in `Current'.
		do
			Result := wel_line_count
		end

	caret_position: INTEGER
			-- Current position of caret.
		local
			new_lines_to_caret_position: INTEGER
			internal_pos: INTEGER
		do
			internal_pos := internal_caret_position
			if has_word_wrapping then
				new_lines_to_caret_position := wel_text.substring (1, internal_pos).occurrences ('%R')
				Result := internal_pos + 1 - new_lines_to_caret_position
			else
				new_lines_to_caret_position := current_line_number
				Result := internal_pos - new_lines_to_caret_position + 2
			end
		end

	insert_text (txt: READABLE_STRING_GENERAL)
			-- Insert `txt' at `caret_position'.
		local
			previous_caret_position: INTEGER
			sel_start, sel_end: INTEGER
			l_wel_string: WEL_STRING
		do
			if has_selection then
				sel_start := selection_start
				sel_end := selection_end
				set_selection (caret_position - 1, caret_position - 1)
			end
			previous_caret_position := internal_caret_position
			l_wel_string := wel_string_from_string_with_newline_conversion (txt)
			{WEL_API}.send_message (wel_item, Em_replacesel, to_wparam (0), l_wel_string.item)
			if has_selection then
				set_selection (sel_start - 1, sel_end - 1)
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

	selection_start: INTEGER
			-- Index of first character selected.
		local
			new_lines_to_start: INTEGER
		do
			new_lines_to_start := wel_text.substring (1, wel_selection_start).occurrences ('%R')
			Result := wel_selection_start + 1 - new_lines_to_start
		end

	selection_end: INTEGER
			-- Index of last character selected.
		local
			new_lines_to_end: INTEGER
		do
			new_lines_to_end := wel_text.substring (1, wel_selection_end).occurrences ('%R')
			Result := wel_selection_end - new_lines_to_end
		end

	selected_text: STRING_32
			-- Text currently selected in `Current'.
		local
			start_pos, end_pos: INTEGER
				-- starting and ending character positions of the
				-- current selection in the edit control
		do
			{WEL_API}.send_message (wel_item, Em_getsel, $start_pos, $end_pos)
				-- Eiffel Strings are indexed from 1 whereas C Strings are indexed from 0
				-- End position is returned as "position of the first nonselected character" thus it works
				-- with Eiffel strings out of the box.
			start_pos := start_pos + 1

			Result := wel_text.substring (start_pos.min (end_pos), end_pos.max (start_pos))
			Result.prune_all ('%R')
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
			previous_caret_position := internal_caret_position
			wel_set_caret_position (wel_text_length)
			create l_wel_string.make_with_newline_conversion (txt)
			{WEL_API}.send_message (wel_item, Em_replacesel, to_wparam (0), l_wel_string.item)
			wel_set_caret_position (previous_caret_position)
		end

	set_caret_position (pos: INTEGER)
			-- set current caret position.
			--| This position is used for insertions.
		do
			wel_set_caret_position (actual_position_from_caret_position (pos))
		end

	select_region (start_pos, end_pos: INTEGER)
			-- Select (hilight) text between
			-- 'start_pos' and 'end_pos'
		local
			new_lines_to_start: INTEGER
			new_lines_to_end: INTEGER
			actual_start, actual_end: INTEGER
			l_text: like text
		do
			l_text := text
			if start_pos < end_pos then
				actual_start := start_pos
				actual_end := end_pos
				new_lines_to_start := l_text.substring (1, actual_start).occurrences ('%N')
				new_lines_to_end := l_text.substring (actual_start + 1, actual_end).occurrences ('%N')
				set_selection (actual_start - 1 + new_lines_to_start, actual_end + new_lines_to_start + new_lines_to_end)
			else
				actual_start := start_pos
				actual_end := end_pos
				new_lines_to_start := l_text.substring (1, actual_end).occurrences ('%N')
				new_lines_to_end := l_text.substring (actual_end + 1, actual_start).occurrences ('%N')
				set_selection (actual_start + new_lines_to_start + new_lines_to_end, actual_end - 1 + new_lines_to_start)
			end
		end

	text_component_imp_set_selection (a_start_pos, a_end_pos: INTEGER)
			-- <Precursor>
		local
			l_new_lines_to_start: INTEGER
			l_new_lines_to_end: INTEGER
			l_text: like text
			l_text_length: INTEGER
		do
			l_text := text
			l_text_length := l_text.count
			if l_text_length > 0 then
				if a_start_pos <= a_end_pos then
					l_new_lines_to_start := l_text.substring (1, a_start_pos.min (l_text_length)).occurrences ('%N')
					l_new_lines_to_end := l_text.substring ((a_start_pos + 1).min (l_text_length), a_end_pos.min (l_text_length)).occurrences ('%N')
					set_selection (a_start_pos + l_new_lines_to_start - 1, a_end_pos + l_new_lines_to_start + l_new_lines_to_end - 1)
				else
					l_new_lines_to_end := l_text.substring (1, a_end_pos.min (l_text_length)).occurrences ('%N')
					l_new_lines_to_start := l_text.substring ((a_end_pos + 1).min (l_text_length), a_start_pos.min (l_text_length)).occurrences ('%N')
					set_selection (a_start_pos + l_new_lines_to_end + l_new_lines_to_start - 1, a_end_pos + l_new_lines_to_end - 1)
				end
			end

		end

feature -- Basic operation

	scroll_to_line (i: INTEGER)
			-- Ensure that line `i' is visible in `Current'.
		do
			scroll (0, i - first_visible_line - 1)
		end

	scroll_to_end
			-- Ensure that the last line is visible in `Current'.
		do
			scroll_to_line (line_count)
		end

feature -- Access

	internal_caret_position: INTEGER
			-- <Precursor>
		local
			l_wel_point: WEL_POINT
			sel_start, sel_end: INTEGER_32
			l_send_message_result: POINTER
			l_index_from_beginning, l_line_index: INTEGER_32
			l_success: BOOLEAN
		do
			{WEL_API}.send_message (wel_item, Em_getsel, $sel_start, $sel_end)
			Result := sel_end
			if sel_start /= sel_end then
					-- We may have a reverse selection so we need to retrieve the caret position from the control.
				create l_wel_point.make (0, 0)
				l_success := {WEL_API}.get_caret_pos (l_wel_point.item)
				if l_success then
					l_send_message_result := {WEL_API}.send_message_result (wel_item, {WEL_RICH_EDIT_MESSAGE_CONSTANTS}.Em_charfrompos, default_pointer, cwin_make_long (l_wel_point.x, l_wel_point.y))
					l_index_from_beginning := {WEL_API}.loword (l_send_message_result)
					l_line_index := {WEL_API}.hiword (l_send_message_result)
					if l_index_from_beginning = sel_start or l_index_from_beginning = sel_end then
						Result := l_index_from_beginning
					end
				end
			end
		end

feature {NONE} -- Implementation

	ignore_character_code (a_character_code: INTEGER): BOOLEAN
			-- Should default processing for `a_character_code' be ignored?
		do
			-- All characters need to be default processed.
		end

	actual_position_from_caret_position (pos: INTEGER): INTEGER
			-- Return the actual caret position from the logical character position.
		local
			new_lines: INTEGER
			counter: INTEGER
			l_r_code: NATURAL_32
			nb: INTEGER
			l_text: like wel_text
		do
				-- We cannot simply call `occurrences' on `wel_text' to determine how
				-- many new line characters there are before `pos' as each time one is
				-- found, we must increase `pos' by one. This is because from the interface,
				-- new lines are "%N" but on Windows they are "%R%N".
			from
				l_r_code := ('%R').natural_32_code
				l_text := wel_text
				counter := 1
				nb := pos - 1
			until
				counter >= nb
			loop
				if l_text.code (counter) = l_r_code then
					new_lines := new_lines + 1
					nb := nb + 1
					counter := counter + 2
				else
					counter := counter + 1
				end
			end
			Result := pos - 1 + new_lines
		end

feature {NONE} -- WEL Implementation

	background_brush: WEL_BRUSH
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
		local
			back: detachable WEL_COLOR_REF
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

	on_en_change
			-- `Text' has been modified.
			--| We call the change_actions.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call (Void)
			end
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
		local
			dialog: detachable EV_DIALOG
		do
			dialog ?= top_level_window
			if virtual_key = vk_escape and dialog /= Void then
					-- There is a bug in Windows where if you hit ESC in a multiline
					-- edit parented at some level within a dialog, it posts a WM_CLOSE
					-- to its parent in the mistaken belief that it is part of a dialog box.
					-- By redefining `on_key_down' here, we can prevent this behaviour. Julian.
					-- Search comp.os.ms-windows.programmer.controls for "hit ESC in a multiline edit".
					-- We only perform the disable if `Current' is actually parented in a dialog.
				disable_default_processing
			else
				if read_only then
					process_navigation_key (virtual_key)
				end
				Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
			end
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_TEXT_IMP
