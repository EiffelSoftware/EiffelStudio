indexing
	description: "This class represents a MS_WINDOWS multi-line text editor without scrollbar";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TEXT_WINDOWS

inherit
	PRIMITIVE_WINDOWS
		rename
			on_right_button_down as widget_on_right_button_down,
			on_right_button_up as widget_on_right_button_up,
			set_cursor_position as wel_set_cursor_position
		redefine
			set_background_color,
			realize,
			unrealize
		end

	PRIMITIVE_WINDOWS
		rename
			set_cursor_position as wel_set_cursor_position
		redefine
			set_background_color,
			on_right_button_down,
			on_right_button_up,
			realize,
			unrealize
		select
			on_right_button_down,
			on_right_button_up
		end

	TEXT_I

	WEL_RICH_EDIT
		rename
			make as wel_make,
			move as wel_move,
			item as wel_item,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture, 
			release_capture as wel_release_capture,
			parent as wel_parent,
			text as wel_text,
			set_background_color as wel_set_background_color,
			text_length as wel_text_length,
			set_text as wel_set_text,
			clear as wel_clear,
			set_selection as wel_set_selection,
			font as wel_font,
			set_font as wel_set_font,
			clear_selection as wel_clear_selection,
			set_read_only as wel_set_read_only,
			set_read_write as wel_set_read_write,
			table_size as wel_table_size,
			style as wel_style
		undefine
			on_show,
			on_hide,
			on_size,
			on_move,
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_set_cursor,
			on_key_up,
			on_key_down
		redefine
			default_style,
			on_en_change,
			on_char
		end

	SIZEABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_text: TEXT; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create the text_windows
		do
			!! private_text.make (0)
			!! private_attributes;
			init_common_controls_dll
			init_rich_edit_dll
			a_text.set_font_imp (Current)
			parent ?= oui_parent.implementation
			managed := man
			is_multi_line_mode := true
		end

	init_rich_edit_dll is
			-- Load the rich edit control DLL.
		local
			rich_edit_dll: WEL_RICH_EDIT_DLL
		once
			!! rich_edit_dll.make
			rich_edit_dll.set_shared
		end

	realize is
			-- Realize current widget
		local
			fw: FONT_WINDOWS
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				resize_for_shell
				wc ?= parent
				wel_make (wc, text, x, y, width, height, id_default)
				enable_standard_notifications
				if private_background_color /= Void then
					set_background_color (private_background_color)
				end
				if private_font /= Void then
					set_font (private_font)
				end
				if private_attributes.height = 0 then
					fw ?= font.implementation
					set_height (fw.string_height (Current, "I") * 7 // 4)
				end
				if private_attributes.width = 0 then
					set_width (200)
				end
				set_text (private_text)
				if maximum_size > 0 then
					set_maximum_size (maximum_size)
				end
				set_cursor_position (private_cursor_position)
				if margin_width + margin_height > 0 then
					set_margins (margin_width, margin_height)
				end
				if is_multi_line_mode then
					set_top_character_position (private_top_character_position)
				end
			end
		end

feature -- Access

	margin_height : INTEGER
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.

	margin_width: INTEGER
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.

	maximum_size: INTEGER
			-- Maximum number of characters in current
			-- text field

	rows: INTEGER is
			-- Height of Current widget measured in character heights.
		local
			fw: FONT_WINDOWS
		do
			if height /= 0 then
				fw ?= font.implementation
				Result := height // fw.string_height (Current, "I")
			end
		end

	tab_length: INTEGER is
			-- Tab length of text
			-- (Default is 8)
		do	
			Result := 8
		end
 
feature -- Status report

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current highlighted selection
		do
			if exists then
				Result := windows_position_to_eiffel (selection_start)
			else
				Result := private_begin_selection
			end
		end

	count: INTEGER is
			-- Number of characters in current text area
		do
			Result := text.count
		end

	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		do
			if exists then
				Result := windows_position_to_eiffel (caret_position)
			else
				Result := private_cursor_position
			end
		end

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		do
			if exists then
				Result := windows_position_to_eiffel (selection_end)
			else
				Result := private_end_selection
			end
		end

	horizontal_position: INTEGER is
			-- Offset in pixels of horizontal scrollbar
		do
		end

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		do
			Result := is_height_resizable and is_width_resizable
		end

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		do
			Result := private_is_height_resizable
		end

	is_in_a_verification_callback: BOOLEAN is
			-- Is the program in a `motion' or `modify' action ?
		do
		end

	is_bell_enabled: BOOLEAN is
			-- Is the bell enabled when an action is forbidden
		do
		end

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		do
			Result := private_is_read_only
		end

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		do
			Result := has_selection
		end

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		do
			Result := private_is_width_resizable
		end

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		do
			Result := private_is_word_wrap_mode
		end

	text: STRING is
			-- Value of current text field
		local
			ext_text: ANY
			size: INTEGER
		do
			if exists then
				Result := wel_text
					-- Remove the garbage characters added by the edit control
				if Result.valid_index (Result.count) and then
					Result.item (Result.count).code = 0 then
					Result.remove (Result.count)
				end
				if not is_multi_line_mode then
					from
					until
						Result.empty or Result.item (Result.count).code >= 32 
					loop
						Result.remove (Result.count)
					end
				end
				if text_translated then
					Result.prune_all ('%R')
				elseif special_translation then
					Result.replace_substring_all ("%R%N", "%N")
					Result.prune_all ('%R')
					Result.replace_substring_all ("%N", "%R%N")
				end
			else
				Result := private_text
			end
		end

	coordinate (char_pos: INTEGER): COORD_XY is
			-- Coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		local
			win_point: WEL_POINT
		do
			win_point := position_from_character_index (char_pos)
			!! Result
			Result.set (win_point.x, win_point.y)
		end

	x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to upper left corner
			-- of current text widget at character position `char_pos'
		do
			if exists then
				Result := position_from_character_index (char_pos).x
			end
		end

	y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to upper left corner
			-- of current text widget at character position `char_pos'
		do
			if exists then
				Result := position_from_character_index (char_pos).y
			end
		end

	character_position (cx, cy : INTEGER) : INTEGER is
			-- character position at position `cx' and `cy'.
		do
			if exists then
				Result := windows_position_to_eiffel
					(character_index_from_position (cx, cy))
			end
		end

	top_character_position: INTEGER is
			-- Character position of first character displayed
		local
			win_pos: INTEGER
		do
			if exists then
				win_pos := line_index (first_visible_line)
				Result := windows_position_to_eiffel (win_pos)
			end
		end

	is_multi_line_mode: BOOLEAN
			-- Is Current editing a multiline text?

	is_cursor_position_visible: BOOLEAN is
			-- Is the insert cursor position marked
			-- by a blinking text cursor?
		do
		end

feature -- Status setting

	set_background_color (a_color: COLOR) is
			-- Set the background color to `a_color'
			-- We may need a call to UpdateWindow
		local
			win_color: WEL_COLOR_REF
		do
			private_background_color := a_color
			if exists then
				win_color ?= a_color.implementation
				wel_set_background_color (win_color)
			end
		end

	unrealize is
			-- Unrealize current widget
		do
			private_text := text
			wel_destroy
		end

	set_margins (a_width, a_height: INTEGER) is
			-- Set margins for text.
		do
		end

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		do
		end

	clear is
			-- Clear current text field.
		do
                        set_text ("")
		end

	clear_selection is
			-- Clear a selection
		do
			private_begin_selection := 0
			private_end_selection := 0
			if exists then
				unselect
			end
		end

	disable_resize is
			-- Disable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			private_is_width_resizable := False
			private_is_height_resizable := False
		end

	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		do
			private_is_height_resizable := False
		end

	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		do
			private_is_width_resizable := False
		end

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		do
		end

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			private_is_width_resizable := True
			private_is_height_resizable := True
		end

	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		do
			private_is_height_resizable := True
		end

	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		do
			private_is_width_resizable := True
		end

	enable_verify_bell is
			-- Enable the bell when an action is forbidden
		do
		end

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		do
		end

	set_cursor_position (pos: INTEGER) is
			-- Set cursor_position to pos.
			--| Will unselect any active selection
			--| since the cursor is always at the end
			--| of a selection under Windows
		do
			if exists then
				set_caret_position (eiffel_position_to_windows (pos))
			else
				private_cursor_position := pos
			end
		end

	set_editable is
			-- Set the text in editable mode
		do
			if is_read_only then
				if exists then
					wel_set_read_write
				end
				private_is_read_only := False
			end
		ensure then
			not is_read_only
		end

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		do
			if exists then
				set_margins (margin_width, new_height)
			end
			margin_height := new_height
		end

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		do
			if exists then
				set_margins (new_width, margin_height)
			end
			margin_width := new_width
		end

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		local
			nb_cr: INTEGER
		do
			maximum_size := a_max
			if exists then
				if text_translated then
					nb_cr := private_text.occurrences ('%N')
				end
				set_text_limit (a_max + nb_cr)
			end
		end

	set_read_only is
			-- Set the text in read_only mode
		do
			if exists then
				wel_set_read_only
			end 
			private_is_read_only := True
		ensure then
			is_read_only: is_read_only
		end

	set_selection (first, last: INTEGER) is
			-- Highlight the substring between `first' and `last' positions
			-- leave the caret at `first'
		local
			top_pos: INTEGER
		do
			private_begin_selection := first
			private_end_selection := last
			if exists then
				top_pos := top_character_position
				wel_set_selection (eiffel_position_to_windows
					(first), eiffel_position_to_windows (last))
				set_top_character_position (top_pos)
			end
		end

	set_text (a_text: STRING) is
			-- Set window text to `a_text'
		local
			local_text : STRING
		do
			update_private_text (a_text)
			if exists then
				local_text := clone (a_text)
				if not a_text.empty then
					if text_translated then
						local_text.replace_substring_all ("%N", "%R%N")
					elseif special_translation then
						local_text.replace_substring_all ("%R%N", "%N")
						local_text.replace_substring_all ("%N", "%R%N")
					end
				end
				wel_set_text (local_text)
			end
		end

	set_top_character_position (char_pos: INTEGER) is
			-- Set first character displayed to `char_pos'.
		do
			private_top_character_position := char_pos
			if exists then
				scroll (0, line_from_char (eiffel_position_to_windows
					(char_pos)) - first_visible_line)
			end
		end

	set_single_line_mode is
			-- Set editing for single line text.
		do
			is_multi_line_mode := false
		end

	set_rows (i: INTEGER) is
			-- Set the character height of Current widget to `i'.
		local
			f: FONT
		do
			f := font
			set_height (i * (f.font_ascent + f.font_descent))
		end

	set_cursor_position_visible (flag: BOOLEAN) is
			-- Set is_cursor_position_visible to flag.
		do
		end

	set_multi_line_mode is
			-- Set editing for multiline text.
		do
			is_multi_line_mode := true
		end
 
feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
                        -- Add `a_command' to the list of action to be executed when
			-- an activate event occurs.
                        -- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			activate_actions.add (Current, a_command, argument)
		end

	add_modify_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		do
			modify_actions.add (Current, a_command, arg)
		end

	add_motion_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute before insert
			-- cursor is moved to a new position.
		do
			motion_actions.add (Current, a_command, arg)
		end

	append (s: STRING) is
                        -- Append `s' at the end of current text.
		local
			a_text: STRING
		do
			a_text := clone (text)
			a_text.append (s)
			update_private_text (a_text)
			if exists then
				if has_selection then
					unselect
				end
				set_caret_position (eiffel_position_to_windows (text.count))
				replace_selection (s)
			end
		end

	insert (s: STRING; a_position: INTEGER) is
                        -- Insert `s' in current text field at `a_position'.
                        -- Same as `replace (a_position, a_position, s)'.
		local
			a_text: STRING
		do
			a_text := clone (text)
			if a_position = a_text.count then
				a_text.append (s)
			else
				a_text.insert (s, a_position + 1)
			end
			update_private_text (a_text)
			if exists then
				if has_selection then
					unselect
				end
				set_caret_position (eiffel_position_to_windows (a_position))
				replace_selection (s)
			end
		end

	replace (from_position, to_position: INTEGER; s: STRING) is
                        -- Replace text from `from_position' to `to_position' by `s'.
		local
			a_text: STRING
		do
			a_text := clone (text)
			if from_position = to_position then
				a_text.insert (s, from_position + 1)
			else
				a_text.replace_substring (s, from_position + 1, to_position)
			end
			update_private_text (a_text)
			if exists then
				if has_selection then
					unselect
				end
				if from_position = to_position then
					set_caret_position (eiffel_position_to_windows (from_position))
					replace_selection (s)
				else
					set_selection (from_position, to_position)
					replace_selection (s)
				end
			end
		end

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
                        -- Remove `a_command' from the list of action to execute when the
			-- an activate event occurs.
		do
			activate_actions.remove (Current, a_command, argument)
		end

	remove_modify_action (a_command: COMMAND; arg : ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		do
			modify_actions.remove (Current, a_command, arg)
		end

	remove_motion_action (a_command: COMMAND; arg : ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- insert cursor is moved to a new position.
		do
			motion_actions.remove (Current, a_command, arg)
		end

feature {NONE} -- Notifications

	on_en_change is
		do
			modify_actions.execute (Current, Void)
		end

	on_char (virtual_key, key_data: INTEGER) is
			-- Wm_char message
		local
			kw: KEYBOARD_WINDOWS
			kpd: KYPRESS_DATA
		do
			!! kw.make_from_key_state
			!! kpd.make (owner, virtual_key, virtual_keys @ virtual_key, kw) 
			if virtual_key = vk_return or virtual_key = vk_tab then
				activate_actions.execute (Current, kpd)
			end
		end

	on_right_button_down (keys, a_x, a_y: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			widget_on_right_button_down (keys, a_x, a_y)
			disable_default_processing
		end

	on_right_button_up (keys, a_x, a_y: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			widget_on_right_button_up (keys, a_x, a_y)
			disable_default_processing
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style for window control;
		do
			Result := Ws_child + Ws_visible + Ws_border
				   + Es_nohidesel + Es_left
				   + Es_multiline + Es_autovscroll
			if not is_word_wrap_mode then
				Result := Result + Es_autohscroll
			end
			if is_read_only then
				Result := Result + Es_readonly
			end
		end

	windows_position_to_eiffel (pos: INTEGER) : INTEGER is
			-- Translate a position in a string with %R%N as delimiters 
			-- to a position in a string with %R as delimiter.
		local
			a_text : STRING
			i : INTEGER
		do
			Result := pos
			if Result > 1 and then text_translated then
				a_text := clone (text)
				if not a_text.empty and text_translated then
					a_text.replace_substring_all ("%N", "%R%N")
				end
				a_text := a_text.substring (1, Result)
				Result := Result - a_text.occurrences ('%R')
			elseif special_translation then
				from
					i := 1
				until
					i > translation_table.count or else 
					translation_table.item(i) + i > pos
				loop
					i := i + 1
				end
				Result := result - i + 1
			end
		end

	eiffel_position_to_windows (pos: INTEGER) : INTEGER is
			-- Translate a position in a string with %R as delimiters 
			-- to a position in a string with %R%N as delimiter.
		local
			a_text: STRING
			i : INTEGER
		do
			Result := pos
			if pos > 1 and then text_translated then
				a_text := text.substring (1, pos)
				Result := Result + a_text.occurrences ('%N')
			elseif special_translation then
				from
					i := 1
				until
					i > translation_table.count or else 
					translation_table.item(i) > pos
				loop
					i := i + 1
				end
				Result := result + i - 1
			end
		end

	update_private_text (a_text: STRING) is
			-- Update the private text and rebuild the
			-- `translation_table' if necessary.
		do
			private_text := clone (a_text)
			special_translation := false
			if a_text.count > 0 and then a_text.substring_index ("%R%N",1) = 0 then
				text_translated := true
			else
				text_translated := false
				if a_text.occurrences ('%N') /= a_text.occurrences ('%R') then
					special_translation := true
					build_translation_table (a_text)
				end
			end
		end

	build_translation_table (a_text: STRING) is
			-- Build table to remember position of %N
		local
			table_size : INTEGER
			i, pos : INTEGER
		do
			table_size := a_text.occurrences ('%N') - a_text.occurrences ('%R')
			if table_size < 0 then
				table_size := 0
			end
			!! translation_table.make (1, table_size)
			from
				i := 1
				pos := a_text.index_of ('%N', 1)
				if pos > 1 then
					if a_text.item (pos-1) /= '%R' then
						translation_table.force (pos, 1)
						i := 2
					end
				elseif pos = 1 then
					translation_table.force (1, 1) 
					i := 2
				end
			until
				i > table_size
			loop
				pos := a_text.index_of ('%N', pos+1)
				if a_text.item (pos -1) /= '%R' then
					translation_table.force (pos,i) 
					i := i + 1
				end
			end
		end

	special_translation: BOOLEAN
			-- Is this text delimited by a mixture of %R%N and %N.
			-- This means that counts must lookup using the translation_table

	translation_table: ARRAY [INTEGER] 
			-- Each %N in the original text is placed in this array at its 
			-- occurrence.  This way we can use it for looking up counts

	text_translated: BOOLEAN
			-- Is this text translated so that "%R%N" are inserted instead of
			-- just a "%N".  This affects counts etc.

	private_top_character_position: INTEGER
			-- Fist visible line containing character position.

	private_begin_selection: INTEGER
			-- Current place selection is to start

	private_cursor_position: INTEGER
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)

	private_end_selection: INTEGER
			-- Current place selection ends

	private_is_height_resizable: BOOLEAN
			-- Is height of current text resizable?

	private_is_read_only: BOOLEAN
			-- Is current text in read only mode?

	private_is_width_resizable: BOOLEAN
			-- Is width of current text resizable?

	private_is_word_wrap_mode: BOOLEAN
			-- Is specified that lines are to be broken at word breaks?

	private_text: STRING
			-- Value of current text field

invariant
	translation_property: special_translation implies translation_table /= Void

end -- class TEXT_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

