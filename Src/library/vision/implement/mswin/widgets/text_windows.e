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
			set_cursor_position as wel_set_cursor_position
		redefine
			realize,
			unrealize
		end

	TEXT_I

	WEL_MULTIPLE_LINE_EDIT
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
			parent ?= oui_parent.implementation
			!! private_text.make (0)
			managed := man
			a_text.set_font_imp (Current)
			is_multi_line_mode := true
			!! private_attributes
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
			-- Offset in pixels of horizonatl scrollbar
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

	x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to upper left corner
			-- of current text widget at character position `char_pos'
		local
			hp, nb_cr : INTEGER
			client_dc: WEL_CLIENT_DC
			local_string: STRING
			local_char_index, local_line_index: INTEGER
			tm: WEL_TEXT_METRIC
		do
			if exists then
				nb_cr := eiffel_position_to_windows (char_pos)
				!! client_dc.make (Current)
				client_dc.get
				client_dc.select_font (wel_font)
				local_line_index := line_from_char (nb_cr)
				local_char_index := line_index (local_line_index)
				local_string := line (local_line_index)
				local_string.head (nb_cr - local_char_index)
				hp := horizontal_position
				if hp > 0 then
					!! tm.make (client_dc)
					hp := tm.average_character_width * hp
				end
				Result := client_dc.tabbed_text_size (local_string).width + formatting_rect.left - hp
				client_dc.release
			end
		end

	y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to upper left corner
			-- of current text widget at character position `char_pos'
		local
			nb_cr : INTEGER
			text_metric: WEL_TEXT_METRIC
			client_dc: WEL_CLIENT_DC
		do
			if exists then
				nb_cr := eiffel_position_to_windows (char_pos)
				!! client_dc.make (Current)
				client_dc.get
				client_dc.select_font (wel_font)
				!! text_metric.make (client_dc)
				Result := (text_metric.height *
					(line_from_char (nb_cr) - first_visible_line) + 
					formatting_rect.top + 
					text_metric.height // 2)
				client_dc.release
			end
		end

	character_position (cx, cy : INTEGER) : INTEGER is
			-- character position at cursor position `cx' and `cy'.
		local
			nb_cr, local_cx : INTEGER
			client_dc: WEL_CLIENT_DC
			text_metric: WEL_TEXT_METRIC
			local_char_index, local_line_index, i: INTEGER
			local_string: STRING
		do
			if exists then
				!! client_dc.make (Current)
				client_dc.get
				client_dc.select_font (wel_font)
				!! text_metric.make (client_dc)
				local_cx := cx + horizontal_position * text_metric.average_character_width
				local_line_index := first_visible_line + (cy - formatting_rect.top) // text_metric.height
				if local_line_index >= line_count then
					local_line_index := line_count - 1
				end
				local_string := line (local_line_index)
				local_char_index := line_index (local_line_index)
				if local_cx > client_dc.tabbed_text_size (local_string).width then
					Result := local_char_index + line_length (local_line_index)
				else
					Result := local_char_index + 1
					from
						i := local_string.count
					variant
						i
					until
						i < 1 or else
							(client_dc.tabbed_text_size (local_string).width < local_cx)
					loop
						local_string.head (i)
						Result := local_char_index + i + 1
						i := i - 1
					end
				end
				client_dc.release
				Result := windows_position_to_eiffel (Result)
			end
		end

	top_character_position: INTEGER is
			-- Character position of first character displayed
		do
			if exists then
				Result := windows_position_to_eiffel (line_index (first_visible_line))
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

	unrealize is
			-- Unrealize current widget
		do
			private_text := text
			wel_destroy
		end

	set_margins (a_width, a_height: INTEGER) is
		do
			if exists then
			end
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
			if exists then
				unselect
			end
			private_begin_selection := 0
			private_end_selection := 0
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
		local
			a_text: STRING
			nb_cr: INTEGER
			start_sel, end_sel : INTEGER
		do
			if exists then
				nb_cr := eiffel_position_to_windows (pos)
				if is_selection_active then 
					start_sel := selection_start
					end_sel := selection_end
					enable_scroll_caret_at_selection
					set_caret_position (nb_cr)
					disable_scroll_caret_at_selection
					wel_set_selection (start_sel, end_sel)
				else
					enable_scroll_caret_at_selection
					set_caret_position (nb_cr)
					disable_scroll_caret_at_selection
				end
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
			nb_cr_first, nb_cr_last: INTEGER
		do
			nb_cr_first := eiffel_position_to_windows (first)
			nb_cr_last := eiffel_position_to_windows (last)
			if exists then
				enable_scroll_caret_at_selection
				set_caret_position (nb_cr_first)				
				disable_scroll_caret_at_selection
				wel_set_selection (nb_cr_first, nb_cr_last)
			end
			private_begin_selection := first
			private_end_selection := last
		end

	set_text (a_text: STRING) is
			-- Set window text to `a_text'
		local
			ext_text: ANY
			local_text : STRING
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

	set_top_character_position (char_pos : INTEGER) is
			-- Set first character displayed to `char_pos'.
		local
			nb_cr, top_line: INTEGER
			start_sel, end_sel : INTEGER
		do
			if exists then
				nb_cr := eiffel_position_to_windows (char_pos)
				top_line := line_from_char (nb_cr)
				nb_cr := line_index (top_line)
				if is_selection_active then 
					start_sel := selection_start
					end_sel := selection_end
					enable_scroll_caret_at_selection
					set_caret_position (nb_cr)
					disable_scroll_caret_at_selection
					wel_set_selection (start_sel, end_sel)
				else
					enable_scroll_caret_at_selection
					set_caret_position (nb_cr)
					disable_scroll_caret_at_selection
				end
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
			w: WIDGET
		do
			f := font
			w := widget_oui
			set_height (i * (f.ascent (w) + f.descent (w)))
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
			set_text (a_text)
		end

	insert (s: STRING; a_position : INTEGER) is
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
			set_text (a_text)
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
			set_text (a_text)
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

feature {NONE} -- Implementation

	on_en_change is
		do
			modify_actions.execute (Current, Void)
		end

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

	windows_position_to_eiffel (pos: INTEGER) : INTEGER is
			-- Translate a position in a string with %R%N as delimiters 
			-- to a position in a string with %R as delimiter.
		local
			a_text : STRING
			nb_cr : INTEGER
			i : INTEGER
		do
			Result := pos
			if Result > 1 and then text_translated then
				a_text := clone (text)
				if not a_text.empty and text_translated then
					a_text.replace_substring_all ("%N", "%R%N")
				end
				a_text := a_text.substring (1, Result)
				nb_cr := a_text.occurrences ('%R')
				Result := Result - nb_cr
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

