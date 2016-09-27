note
	description: "EiffelVision text component. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_COMPONENT_IMP

inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface,
			text_length
		end

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size,
			interface,
			make,
			wel_background_color,
			wel_foreground_color,
			background_color_internal,
			default_process_message,
			tab_action
		end

	WEL_SHARED_TEMPORARY_OBJECTS

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			wel_set_font ((create {WEL_SHARED_FONTS}).gui_font)
			Precursor {EV_PRIMITIVE_IMP}
		end

	set_default_minimum_size
			-- Called after creation. Set current size and
			-- notify parent.
		do
			ev_set_minimum_size (
				maximum_character_width * 4, internal_font_height +
				total_vertical_padding, False)
		end

	total_vertical_padding: INTEGER = 9
		-- Number of pixels to be added to height of font used internally,
		-- to give us minimum height of `Current'.

	internal_font_height: INTEGER
			-- `Result' is height of font used by `Current'.
		deferred
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is text editable?
		do
			Result := not read_only
		end

	is_replacing_nl_by_crnl: BOOLEAN
			-- Does current text control converts %N into %R%N?
		do
			Result := False
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	caret_position: INTEGER
			-- Current position of caret.
		local
			l_wel_string: WEL_STRING
		do
				-- Caret position is given in code units not in visible characters.			
			l_wel_string := wel_text_substring (internal_wel_caret_position)
			Result := l_wel_string.unicode_character_count + 1
				-- Offset start position of selection to take into account
				-- the conversion of %R%N into %N.
			if is_replacing_nl_by_crnl then
					-- Selection is given in code units not in visible characters.
				Result := Result - l_wel_string.occurrences ('%R')
			end
		end

	start_selection: INTEGER
			-- <Precursor>
		local
			l_wel_string: WEL_STRING
		do
				-- Selection is given in code units not in visible characters.
			l_wel_string := wel_text_substring (wel_selection_start)
			Result := l_wel_string.unicode_character_count + 1
				-- Offset start position of selection to take into account
				-- the conversion of %R%N into %N.
			if is_replacing_nl_by_crnl then
					-- Selection is given in code units not in visible characters.
				Result := Result - l_wel_string.occurrences ('%R')
			end
		end

	end_selection: INTEGER
			-- <Precursor>
		local
			l_wel_string: WEL_STRING
		do
				-- Selection is given in code units not in visible characters.
			l_wel_string := wel_text_substring (wel_selection_end)
			Result := l_wel_string.unicode_character_count + 1
				-- Offset start position of selection to take into account
				-- the conversion of %R%N into %N.
			if is_replacing_nl_by_crnl then
					-- Selection is given in code units not in visible characters.
				Result := Result - l_wel_string.occurrences ('%R')
			end
		end

feature -- Access

	text_length: INTEGER
			-- <Precursor>
		local
			l_wel_string: WEL_STRING
		do
				-- Most efficient solution, we only count the number of Unicode characters.
			l_wel_string := wel_text_substring (wel_text_length)
			Result := l_wel_string.unicode_character_count
			if is_replacing_nl_by_crnl then
					-- We have to remove from the count the extra `%R' that Windows insert.
				Result := Result - l_wel_string.occurrences ('%R')
			end
		end

feature {EV_ANY_I}-- Status setting

	set_editable (flag: BOOLEAN)
			-- If `flag' then make `Current' editable else
			-- make `Current' component read-only.
		do
			if flag then
				set_read_write
			else
				set_read_only
			end
		end

	set_caret_position (pos: INTEGER)
			-- set current caret position.
			--| This position is used for insertions.
		do
			wel_set_caret_position (actual_position_from_caret_position (pos))
		end

	actual_position_from_caret_position (pos: INTEGER): INTEGER
			-- Return the actual WEL caret position from the logical caret position.
		require
			pos_positive: pos > 0
		local
			l_text_length: INTEGER
			l_wel_string: WEL_STRING
			m: MANAGED_POINTER
			l_pos, i: INTEGER
			l_ignore_cr: BOOLEAN
			c: NATURAL_32
		do
			l_text_length := wel_text_length
			if l_text_length > 0 then
				from
					l_wel_string := wel_text_substring (wel_text_length)
					m := l_wel_string.managed_data
					l_ignore_cr := is_replacing_nl_by_crnl
				until
					i > l_text_length
				loop
					c := m.read_natural_16 (i * 2)
					i := i + 1
					if c < 0xD800 or c >= 0xE000 then
							-- Codepoint from Basic Multilingual Plane: one 16-bit code unit.
						if c /= ('%N').natural_32_code or else not l_ignore_cr then
							l_pos := l_pos + 1
							if l_pos = pos then
									-- Get proper result and jump out of the loop
								Result := i - 1
								i := l_text_length + 1
							end
						else
							check
								new_line: c = ('%N').natural_32_code
								not_first_character: i - 2 >= 0
								is_cr: m.read_natural_16 ((i - 2) * 2) = ('%R').natural_32_code
							end
						end
					else
								-- Supplementary Planes: surrogate pair with lead and trail surrogates.						
						if i <= l_text_length then
							i := i + 1
							l_pos := l_pos + 1
							if l_pos = pos then
									-- Get proper result and jump out of the loop
								Result := i - 2
								i := l_text_length + 1
							end
						end
					end
				end
			end
		end

	occurrences_of_char_in_substring (a_text: STRING_32; c: CHARACTER_32; start_pos, end_pos: INTEGER_32): INTEGER_32
			-- Number of occurrences of `c' in `a_text' between characters `start_pos' to `end_pos'.
		require
			valid_start: start_pos >= 1
			valid_end: end_pos <= a_text.count
		local
			l_area: SPECIAL [CHARACTER_32]
			i, n: INTEGER
		do
			from
				l_area := a_text.area
				i := end_pos - 1
				n := start_pos - 1
			until
				i < n
			loop
				if l_area.item (i) = c then
					Result := Result + 1
				end
				i := i - 1
			end
		end

	set_capacity (value: INTEGER)
			-- Make `value' new maximal length in characters of text.
		do
			set_text_limit (value)
		end

	capacity: INTEGER
			-- Return maximum number of characters `Current' may hold.
		do
			Result := get_text_limit
		end

feature {EV_ANY_I}-- element change

	insert_text (txt: READABLE_STRING_GENERAL)
			-- Insert `txt' at `caret_position'.
		local
			temp_text: STRING_32
			previous_caret_position: INTEGER
		do
			previous_caret_position := internal_wel_caret_position
			temp_text := text
			if caret_position > temp_text.count then
				temp_text.append (txt.as_string_32)
			else
				temp_text.insert_string (txt.as_string_32, caret_position)
			end
			set_text (temp_text)
			wel_set_caret_position (previous_caret_position)
		end

	append_text (txt:READABLE_STRING_GENERAL)
			-- Append 'txt' to text of `Current'.
		local
			temp_text: STRING_32
			previous_caret_position: INTEGER
		do
			previous_caret_position := internal_wel_caret_position
			temp_text := text
			temp_text.append_string_general (txt)
			set_text (temp_text)
			wel_set_caret_position (previous_caret_position)
		end

	prepend_text (txt: READABLE_STRING_GENERAL)
			-- Prepend 'txt' to text of `Current'.
		local
			temp_text: STRING_32
			previous_caret_position: INTEGER
		do
			previous_caret_position := internal_wel_caret_position
			temp_text :=  text
			temp_text.prepend_string_general (txt)
			set_text (temp_text)
			wel_set_caret_position (previous_caret_position)
		end

	maximum_character_width: INTEGER
			-- `Result' is width of widest character (W), when displayed.
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font ((create {WEL_SHARED_FONTS}).gui_font)
			extent := screen_dc.string_size ("W")
			screen_dc.unselect_font
			screen_dc.quick_release
			Result := extent.width
		end

feature {EV_ANY_I} -- Resizing

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make a minimum of `nb' characters visible on one line.
		do
			set_minimum_width (nb * maximum_character_width)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER)
			-- Select (hilight) text between
			-- 'start_pos' and 'end_pos'
		do
				-- Selection is using caret position whereas region is just using
				-- character indexes, thus the + 1 for the end position.
			set_selection (start_pos, end_pos + 1)
		end

	set_selection (a_start_pos, a_end_pos: INTEGER)
			-- <Precursor>
		local
			l_start_position, l_end_position: INTEGER
		do
			l_start_position := actual_position_from_caret_position (a_start_pos)
			l_end_position := actual_position_from_caret_position (a_end_pos)
			wel_set_selection (l_start_position, l_end_position)
		end

	paste (index: INTEGER)
			-- Insert string which is in Clipboard at
			-- `index' postion in text.
			-- If Clipboard is empty, it does nothing.
		local
			pos: INTEGER
		do
			pos := caret_position
			set_caret_position (index)
			clip_paste
			if pos <= index then
				set_caret_position (pos)
			else
				set_caret_position (pos + clipboard_content.count)
			end
		end

	wel_set_font (a_wel_font: WEL_FONT)
			-- Assign `a_wel_font' to font of `Current'.
		deferred
		end

feature {NONE} -- Deferred features

	wel_text_item: POINTER
			-- Actual HWND of the text part of the text component.
			--| Useful for comboboxes where the main HWND is not a text.
		do
			Result := wel_item
		end

	internal_wel_caret_position: INTEGER
			-- Caret position in WEL units.
		local
			l_wel_point: WEL_POINT
			sel_start, sel_end: INTEGER_32
			l_send_message_result: POINTER
			l_success: BOOLEAN
		do
			{WEL_API}.send_message (wel_text_item, {WEL_EM_CONSTANTS}.em_getsel, $sel_start, $sel_end)
			Result := sel_end
			if sel_start /= sel_end then
					-- We may have a reverse selection so we need to retrieve the caret position from the control.
				create l_wel_point.make (0, 0)
				l_success := {WEL_API}.get_caret_pos (l_wel_point.item)
				if l_success then
					if attached {WEL_RICH_EDIT} Current then
						Result := {WEL_API}.send_message_result_integer (wel_item, {WEL_RICH_EDIT_MESSAGE_CONSTANTS}.Em_charfrompos, default_pointer, l_wel_point.item)
					else
						l_send_message_result := {WEL_API}.send_message_result (wel_text_item,
							{WEL_RICH_EDIT_MESSAGE_CONSTANTS}.Em_charfrompos, default_pointer,
							cwin_make_long (l_wel_point.x, l_wel_point.y))
						Result := {WEL_API}.loword (l_send_message_result)
					end
				end
			end
		end

	wel_set_caret_position (a_position: INTEGER)
			-- Set caret position with `a_position'.
		deferred
		end

	wel_set_selection (start_position, end_position: INTEGER)
			-- Set selection between `start_position' and `end_position' expressed
			-- in UTF-16 code units.
		require
			exists: exists
			selection_in_lower_bound: start_position >= 0 and end_position >= 0
			selection_in_upper_bound: start_position <= wel_text_length and end_position <= wel_text_length
		deferred
		end

	set_text_limit (value: INTEGER)
			-- Make `value' new maximal length of text.
		deferred
		end

	get_text_limit: INTEGER
			-- Result is maximum text length.
		deferred
		end

	read_only: BOOLEAN
			-- Is `current' edit control read-only?
		deferred
		end

	set_read_only
			-- Set `Current' read only.
		deferred
		end

	set_read_write
			-- Set `Current' read/write.
		deferred
		end

	clip_paste
			-- Paste at current caret position
			-- content of clipboard.
		deferred
		end

	wel_font: WEL_FONT
			-- Font of `Current'.
		deferred
		end

	wel_selection_start: INTEGER
		require
			exists: exists
		deferred
		end

	wel_selection_end: INTEGER
		require
			exists: exists
		deferred
		end

	wel_text_length: INTEGER
		require
			exists: exists
		deferred
		end

	wel_text_substring (nb: INTEGER): WEL_STRING
		require
			exists: exists
		deferred
		end

	wel_background_color: WEL_COLOR_REF
		do
			if attached background_color_imp as l_background_color_imp then
				Result := l_background_color_imp
			else
				create Result.make_rgb (255, 255, 255)
			end
		end

	wel_foreground_color: WEL_COLOR_REF
		do
			if attached foreground_color_imp as l_foreground_color_imp then
				Result := l_foreground_color_imp
			else
				create Result.make_rgb (0, 0, 0)
			end
		end

	background_color_internal: EV_COLOR
			-- Color used for the background of `Current'.
			-- This has been redefined as the background color of
			-- text components is white, or `Color_read_write' by default.
		do
			if attached background_color_imp as l_background_color_imp then
				Result := l_background_color_imp.attached_interface
			else
				if is_sensitive then
					Result := (create {EV_STOCK_COLORS}).Color_read_write
				else
					Result := (create {EV_STOCK_COLORS}).color_read_only
				end
			end
		end

feature {EV_PICK_AND_DROPABLE_IMP, EV_INTERNAL_COMBO_FIELD_IMP} -- Implementation

	override_context_menu: BOOLEAN
		-- Should the context menu be overridden, so
		-- it is not displayed?

	disable_context_menu
			-- Assign `True' to `override_context_menu'.
			-- This will stop the context menu appearing, the
			-- next time that `allow_pick_and_drop' is executed.
		do
			override_context_menu := True
		end

	enable_context_menu
			-- Assign `False' to `override_context_menu'.
		do
			override_context_menu := False
		end

feature {EV_DIALOG_IMP_COMMON} -- Implementation

	tab_action (a_direction: BOOLEAN)
			-- <Precursor>
		do
			if application_imp.ctrl_pressed then
					-- Ignore tab navigation handling if control is pressed.
				if not is_multiline then
						-- For single line controls this prevents superflous tabs being inserted during tab navigation.
					disable_default_processing
				end
			else
				Precursor (a_direction)
			end
		end

feature {NONE} -- Implementation

	is_multiline: BOOLEAN
			-- Is `Current' multi-line control?
		do
			Result := False
		end

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do

			if msg = ({WEL_WINDOW_CONSTANTS}.Wm_contextmenu) then
				allow_pick_and_drop
			else
				Precursor {EV_PRIMITIVE_IMP} (msg, wparam, lparam)
			end
		end

	allow_pick_and_drop
			-- Override context menu on `Current' if pick and drop
			-- should be handled instead. We must handle two cases :-
			-- 1. We are attempting to pick from `Current'.
			-- 2. We are attempting to drop from `Current'.
		do
			if application_imp.pick_and_drop_source /= Void then
				disable_default_processing
			elseif pebble /= Void then
				disable_default_processing
			elseif override_context_menu then
				disable_default_processing
			end
			enable_context_menu
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		local
			edit_control: WEL_MULTIPLE_LINE_EDIT
		do
			create edit_control.make (Default_parent, "", 0, 0, 0, 0, 0)
			edit_control.clip_paste
			Result := edit_control.text
				-- The multiline edit control gives us %R%N which we need to replace
				-- by just %N.
			Result.replace_substring_all ("%R%N", "%N")
			edit_control.destroy
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT_COMPONENT note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TEXT_COMPONENT_IMP
