indexing
	description: "[
		EiffelVision2 rich text. Windows implementation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP

inherit
	EV_RICH_TEXT_I
		rename
			last_load_successful as implementation_last_load_successful
		redefine
			interface,
			text_length
		end

	EV_TEXT_IMP
		undefine
			default_ex_style,
			default_style,
			class_name,
			internal_caret_position,
			internal_set_caret_position,
			text,
			wel_text,
			process_notification_info,
			set_tab_stops_array,
			set_default_tab_stops,
			set_tab_stops,
			set_text,
			wel_set_text,
			destroy,
			has_selection,
			selection_start,
			selection_end,
			wel_selection_start,
			wel_selection_end,
			set_selection
		redefine
			interface,
			make,
			enable_word_wrapping,
			disable_word_wrapping,
			first_position_from_line_number,
			last_position_from_line_number,
			caret_position,
			set_caret_position,
			select_region,
			selection_start,
			selection_end,
			on_erase_background,
			line_number_from_position,
			enable_redraw,
			on_en_change,
			text_length,
			wel_text_length,
			set_background_color
		select
			wel_line_index,
			wel_current_line_number,
			wel_line_count,
			deselect_all,
			copy_selection,
			cut_selection,
			wel_destroy,
			wel_resize,
			wel_move,
			wel_make,
			is_sensitive,
			is_displayed,
			wel_has_capture,
			x_position,
			y_position,
			wel_move_and_resize
		end

	WEL_RICH_EDIT
		rename
			parent as wel_parent,
			height as wel_height,
			width as wel_width,
			set_font as wel_set_font,
			set_background_color as wel_set_background_color,
			foreground_color as wel_foreground_color,
			background_color as wel_background_color,
			font as wel_font,
			set_parent as wel_set_parent,
			make as wel_make,
			caret_position as internal_caret_position,
			set_caret_position as internal_set_caret_position,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			line as wel_line,
			line_number_from_position as wel_line_number_from_position,
			item as wel_item,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end
		undefine
			hide,
			line_count,
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
			has_capture,
			set_height,
			set_width,
			insert_text,
			selected_text,
			current_line_number,
			on_en_change,
			set_text_limit,
			select_all,
			default_process_message,
			on_desactivate,
			on_sys_key_up,
			on_sys_key_down,
			on_mouse_wheel,
			on_middle_button_double_click,
			on_middle_button_up,
			on_middle_button_down,
			on_size,
			disable,
			enable,
			background_brush,
			wel_text_length,
			wel_foreground_color,
			wel_background_color,
			class_name,
			show,
			destroy,
			wel_make,
			on_getdlgcode
		redefine
			default_style,
			default_ex_style,
			class_name,
			text_stream_in,
			insert_rtf_stream_in,
			rtf_stream_in,
			on_erase_background,
			enable_redraw,
			on_en_change
		end

	WEL_CFM_CONSTANTS
		export
			{NONE} all
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		end

	WEL_UNIT_CONVERSION
		export
			{NONE} all
		end

	WEL_PFM_CONSTANTS
		export
			{NONE} all
		end

	WEL_PFA_CONSTANTS
		export
			{NONE} all
		end

	WEL_CFE_CONSTANTS
		export
			{NONE} all
		end

	EV_RICH_TEXT_ACTION_SEQUENCES_IMP
		export
			{NONE} all
		end

	EV_RICH_TEXT_BUFFERING_STRUCTURES_I
		export
			{NONE} all
		redefine
			initialize_for_saving
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		local
			screen_dc: WEL_SCREEN_DC
			logical_pixels: INTEGER
		do
			base_make (an_interface)
				-- Associate `Current' as `rich_text' inherited from EV_RICH_TEXT_BUFFERING_STRUCTURES_I
				-- This is because instances of EV_RICH_TEXT_BUFFERING_STRUCTURES need access to
				-- a rich text implementation object and they may be created independently.
			set_rich_text (Current)

			multiple_line_edit_make (default_parent, "", 0, 0, 0, 0, -1)
			show_vertical_scroll_bar
			set_text_limit (2560000)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
			enable_all_notifications
			cwin_send_message (wel_item, Em_settypographyoptions,
				to_wparam (to_advancedtypography), to_lparam (to_advancedtypography))

				-- Connect events to `tab_positions' to update `Current' as values
				-- change.
			create tab_positions
			tab_positions.internal_add_actions.extend (agent update_tab_positions)
			tab_positions.internal_remove_actions.extend (agent update_tab_positions)

				-- Calculate the default tab space. In a rich edit control, it is
				-- Half an Inch, so query the horizontal resolution and divide by 2.
			create screen_dc
			screen_dc.get
			logical_pixels := get_device_caps (screen_dc.item, logical_pixels_x)
			screen_dc.release
			tab_width := logical_pixels // 2

				-- Ensure all structures for buffering are set to defaults.
			clear_structures
		end

	default_style: INTEGER is
			-- Default style used to create the control
			-- (from WEL_RICH_EDIT)
			-- (export status {NONE})
		once
			Result := Ws_visible + Ws_child + Ws_border + Ws_vscroll + Es_savesel +
				Es_disablenoscroll + Es_multiline + es_autovscroll + Es_Wantreturn + ws_tabstop
		end

	default_ex_style: INTEGER is
			-- Extended windows style used to create `Current'.
		do
			Result := Ws_ex_clientedge
		end

feature -- Status report

	text: STRING_32 is
			-- text of `Current'.
		do
			Result := wel_text
			Result.prune_all ('%R')
		end

	character_format (caret_index: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format at caret position `caret_index'
		local
			already_set: BOOLEAN
		do
			if not has_selection and caret_position = caret_index then
				already_set := True
			else
				disable_redraw
				safe_store_caret
				set_selection (caret_index - 1, caret_index - 1)
			end
			Result := internal_selected_character_format
			if not already_set then
				safe_restore_caret
				enable_redraw
			end
		end

	selected_character_format: EV_CHARACTER_FORMAT is
			-- `Result' is character format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		do
			Result := internal_selected_character_format
		end

	internal_selected_character_format: EV_CHARACTER_FORMAT is
			-- Implementation for `selected_character_format'. No preconditions permit
			-- calling even when there is no selection as required by some implementation
			-- features.
		local
			char_imp: EV_CHARACTER_FORMAT_IMP
		do
			create Result
			char_imp ?= Result.implementation
			cwin_send_message (wel_item, em_getcharformat, to_wparam (1), char_imp.item)
		ensure
			result_not_void: Result /= Void
		end

	internal_selected_character_format_i: EV_CHARACTER_FORMAT_IMP is
			-- Implementation for `selected_character_format'. No preconditions permit
			-- calling even when there is no selection as required by some implementation
			-- features.
		local
			char_format: EV_CHARACTER_FORMAT
		do
			create char_format
			Result ?= char_format.implementation
			cwin_send_message (wel_item, em_getcharformat, to_wparam (1), Result.item)
		ensure
			result_not_void: Result /= Void
		end

	paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph_format at caret position `caret_index'.
		local
			already_set: BOOLEAN
		do
			if not has_selection and caret_position = caret_index then
				already_set := True
			else
				disable_redraw
				safe_store_caret
				set_selection (caret_index - 1, caret_index - 1)
			end
			Result := internal_selected_paragraph_format
			if not already_set then
				safe_restore_caret
				enable_redraw
			end
		end

	internal_paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph_format at caret position `caret_index'.
		do
			set_selection (caret_index - 1, caret_index - 1)
			Result := internal_selected_paragraph_format
		end

	selected_paragraph_format: EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		do
			Result := internal_selected_paragraph_format
		end

	internal_selected_paragraph_format: EV_PARAGRAPH_FORMAT is
			-- Implementation for `selected_paragraph_format'. No preconditions permit
			-- calling even when there is no selection as required by some implementation
			-- features.
		local
			imp: EV_PARAGRAPH_FORMAT_IMP
		do
			create Result
			imp ?= Result.implementation
			cwin_send_message (wel_item, em_getparaformat, to_wparam (0), imp.item)
		ensure
			result_not_void: Result /= Void
		end

	character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		local
			mask: INTEGER
			wel_character_format: WEL_CHARACTER_FORMAT2
			range_already_selected: BOOLEAN
			current_selection: WEL_CHARACTER_RANGE
		do
			disable_redraw
			current_selection := selection
			if current_selection.minimum /= current_selection.maximum and
				start_index = current_selection.minimum + 1 and
				end_index = current_selection.maximum + 1
			then
				range_already_selected := True
			else
				safe_store_caret
				set_selection (start_index, end_index - 1)
			end
			create wel_character_format.make
			cwin_send_message (wel_item, em_getcharformat, to_wparam (1), wel_character_format.item)
			mask := wel_character_format.mask
			Result := flag_set (mask, cfm_color | cfm_bold | cfm_face | cfm_size | cfm_strikeout | cfm_underline | cfm_italic | cfm_offset | cfm_backcolor)
			if not range_already_selected then
				safe_restore_caret
			end
			enable_redraw
		end

	internal_character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
			-- Internal version which permits optimizations as caret position and selection
			-- does not need to be restored.
		local
			wel_character_format: WEL_CHARACTER_FORMAT2
			mask: INTEGER
		do
			set_selection (start_index - 1, end_index - 1)
			create wel_character_format.make
			cwin_send_message (wel_item, em_getcharformat, to_wparam (1), wel_character_format.item)
			mask := wel_character_format.mask
			Result := flag_set (mask, cfm_color | cfm_bold | cfm_face | cfm_size | cfm_strikeout | cfm_underline | cfm_italic | cfm_offset | cfm_backcolor)
		end

	internal_character_format (pos: INTEGER): EV_CHARACTER_FORMAT_I is
			-- `Result' is character format at position `pos'. On some platforms
			-- this may be optimized to take the selected character format and therefore
			-- should only be used by `next_change_of_character'.
		do
			set_selection (pos - 1, pos - 1)
			Result := internal_selected_character_format_i
		end

	initialize_for_saving is
			-- Initialize `Current' for save operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		do
			Precursor {EV_RICH_TEXT_BUFFERING_STRUCTURES_I}
			safe_store_caret
			internal_actions_blocked := True
			disable_redraw
			if selection_change_actions_internal /= Void then
				selection_change_actions_internal.block
			end
			if caret_move_actions_internal /= Void then
				caret_move_actions_internal.block
			end
		end

	complete_saving is
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_saving'.
		do
			if selection_change_actions_internal /= Void then
				selection_change_actions_internal.resume
			end
			if caret_move_actions_internal /= Void then
				caret_move_actions_internal.resume
			end
			internal_actions_blocked := False
			safe_restore_caret
			enable_redraw
		end

	initialize_for_loading is
			-- Initialize `Current' for load operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		do
			internal_actions_blocked := True
			disable_redraw
			if selection_change_actions_internal /= Void then
				selection_change_actions_internal.block
			end
			if caret_move_actions_internal /= Void then
				caret_move_actions_internal.block
			end
		end

	complete_loading is
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_loading'.
		do
			if selection_change_actions_internal /= Void then
				selection_change_actions_internal.resume
			end
			if caret_move_actions_internal /= Void then
				caret_move_actions_internal.resume
			end
			internal_actions_blocked := False
			enable_redraw
		end

	paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN is
			-- Is paragraph formatting from caret_position `start_position' to `end_position' contiguous?
		local
			current_selection: WEL_CHARACTER_RANGE
			range_already_selected: BOOLEAN
			wel_paragraph_format: WEL_PARAGRAPH_FORMAT2
			mask: INTEGER
		do
			disable_redraw
			current_selection := selection
			if current_selection.minimum /= current_selection.maximum and
				start_position = current_selection.minimum + 1 and
				end_position = current_selection.maximum + 1
			then
				range_already_selected := True
			else
				safe_store_caret
				set_selection (start_position - 1, end_position - 1)
			end
			create wel_paragraph_format.make
			cwin_send_message (wel_item, em_getparaformat, to_wparam (0), wel_paragraph_format.item)
			mask := wel_paragraph_format.mask
			Result := flag_set (mask, Pfm_alignment | pfm_startindent| pfm_rightindent | pfm_spacebefore | pfm_spaceafter)
			if not range_already_selected then
				safe_restore_caret
			end
			enable_redraw
		end

	internal_paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN is
			-- Is paragraph formatting from caret_position `start_position' to `end_position' contiguous?
		local
			wel_paragraph_format: WEL_PARAGRAPH_FORMAT2
			mask: INTEGER
		do
			set_selection (start_position - 1, end_position - 1)
			create wel_paragraph_format.make
			cwin_send_message (wel_item, em_getparaformat, to_wparam (0), wel_paragraph_format.item)
			mask := wel_paragraph_format.mask
			Result := flag_set (mask, Pfm_alignment | pfm_startindent| pfm_rightindent | pfm_spacebefore | pfm_spaceafter)
		end

	character_format_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		local
			mask: INTEGER
			wel_character_format: WEL_CHARACTER_FORMAT2
			range_already_selected: BOOLEAN
			flags: INTEGER
		do
			if start_index = wel_selection_start + 1 and end_index = wel_selection_end + 1 then
				range_already_selected := True
			else
				disable_redraw
				safe_store_caret
				set_selection (start_index - 1, end_index - 1)
			end
			create wel_character_format.make
			cwin_send_message (wel_item, em_getcharformat, to_wparam (1), wel_character_format.item)
			mask := wel_character_format.mask
			if flag_set (mask, cfm_face) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_family
			end
			if flag_set (mask, cfm_bold) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_weight
			end
			if flag_set (mask, cfm_italic) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_shape
			end
			if flag_set (mask, cfm_size) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_height
			end
			if flag_set (mask, cfm_color) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.color
			end
			if flag_set (mask, cfm_backcolor) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.background_color
			end
			if flag_set (mask, cfm_strikeout) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out
			end
			if flag_set (mask, cfm_underline) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined
			end
			if flag_set (mask, cfm_offset) then
				flags := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset
			end

			create Result.make_with_flags (flags)
			if not range_already_selected then
				safe_restore_caret
				enable_redraw
			end
		end

	paragraph_format_range_information (start_position, end_position: INTEGER): EV_PARAGRAPH_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_position' to `end_position'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_position' to
			--`end_position' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		local
			current_selection: WEL_CHARACTER_RANGE
			range_already_selected: BOOLEAN
			wel_paragraph_format: WEL_PARAGRAPH_FORMAT2
			flags, mask: INTEGER
		do
			current_selection := selection
			if current_selection.minimum /= current_selection.maximum and
				start_position = current_selection.minimum + 1 and
				end_position = current_selection.maximum + 1
			then
				range_already_selected := True
			else
				disable_redraw
				safe_store_caret
				set_selection (start_position - 1, end_position - 1)
			end
			create wel_paragraph_format.make
			cwin_send_message (wel_item, em_getparaformat, to_wparam (0), wel_paragraph_format.item)

			mask := wel_paragraph_format.mask
			if flag_set (mask, pfm_alignment) then
				flags := flags | {EV_PARAGRAPH_CONSTANTS}.alignment
			end
			if flag_set (mask, pfm_startindent) then
				flags := flags | {EV_PARAGRAPH_CONSTANTS}.left_margin
			end
			if flag_set (mask, pfm_rightindent) then
				flags := flags | {EV_PARAGRAPH_CONSTANTS}.right_margin
			end
			if flag_set (mask, pfm_spacebefore) then
				flags := flags | {EV_PARAGRAPH_CONSTANTS}.top_spacing
			end
			if flag_set (mask, pfm_spaceafter) then
				flags := flags | {EV_PARAGRAPH_CONSTANTS}.bottom_spacing
			end
			create Result.make_with_flags (flags)
			if not range_already_selected then
				safe_restore_caret
				enable_redraw
			end
		end

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		do
			Result := character_index_from_position (an_x_position, a_y_position) + 1
		end

	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		do
			Result := internal_position_from_index (an_index)
		end

	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		local
			pos: EV_COORDINATE
		do
			pos := internal_position_from_index (an_index)
			Result := pos.x >= 0 and pos.x <= width and
				pos.y >= 0 and pos.y <= height
		end

	tab_width: INTEGER
			-- Default width in pixels of each tab in `Current'.

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
				Result := text.count
			end
		end

	line_number_from_position (i: INTEGER): INTEGER is
			-- Line containing caret position `i'.
		do
			Result := wel_line_number_from_position (i) + 1
				-- Windows returns the next line if the final line selected
				-- is a new line character of the final character before word wrapping.
				-- In this case, we subtract one from the line to find the previous line and check our
				-- index is not the final character of this line. If it is, we subtract one from the result.
				-- If the result is already correct, then the match never succeeds, and the values are correct.
			if (Result - 1) > 0 then
				if last_position_from_line_number (Result - 1) = i then
					Result := Result - 1
				end
			end
		end

	caret_position: INTEGER is
			-- Current position of caret.
		do
			Result := (internal_caret_position + 1).min (text_length + 1)
		end

	set_caret_position (pos: INTEGER) is
			-- set current caret position.
			--| This position is used for insertions.
		do
			internal_set_caret_position (pos - 1)
		end

	selection_start: INTEGER is
			-- Index of first character selected.
		do
			Result := (wel_selection_start + 1).min (text_length)
		end

	selection_end: INTEGER is
			-- Index of last character selected.
		do
			Result := wel_selection_end.min (text_length)
		end

	wel_text_length, text_length: INTEGER is
			-- Number of characters comprising `text'. This is an optimized
			-- version, which only recomputes the length if not `text_up_to_date'.
		local
			l_length: INTEGER
		do
			if has_word_wrapping then
				l_length := cwin_get_window_text_length (wel_item)
				if not text_up_to_date or l_length /= private_windows_text_length then
					private_windows_text_length := l_length
					internal_text_length := text.count
					Result := internal_text_length
					text_up_to_date := True
				else
					Result := internal_text_length
				end
			else
				-- If no wrapping we can calculate this the quick way.
				Result := cwin_get_window_text_length (wel_item) - line_count + 1
			end
		end

feature -- Status setting

	set_text (a_text: STRING_GENERAL) is
			-- Set `text' with `a_text'.
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
			l_text: STRING_32
		do
			if not a_text.is_empty then
					-- Replace "%N" with "%R%N" for Windows.
				create stream.make (convert_string (a_text))
			else
				create stream.make (a_text)
			end
			stream.set_is_unicode_data (True)
			text_stream_in (stream)
			stream.release_stream
		end

	format_region (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately.
		local
			wel_character_format: WEL_CHARACTER_FORMAT2
		do
			safe_store_caret
			set_selection (first_pos - 1, last_pos - 1)
			wel_character_format ?= format.implementation
			check
				wel_character_format_not_void: wel_character_format /= Void
			end
			set_character_format_selection (wel_character_format)
			safe_restore_caret
		end

	format_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT) is
			-- Apply paragraph formatting `format' to caret positions `start_position', `end_position' inclusive.
			-- Formatting applies to complete lines as seperated by new line characters that `start_position' and
			-- `end_position' fall on.
		do
			format_paragraph_internal (start_position, end_position, format, pfm_alignment | pfm_startindent | pfm_rightindent | pfm_spacebefore | pfm_spaceafter | pfm_linespacing)
		end

	modify_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION) is
			-- Modify formatting from `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others.
		local
			wel_character_format: WEL_CHARACTER_FORMAT2
			mask: INTEGER
		do
			disable_redraw
			safe_store_caret
			set_selection (start_position - 1, end_position - 1)
			wel_character_format ?= format.implementation
			check
				wel_character_format_not_void: wel_character_format /= Void
			end
			if applicable_attributes.font_shape = True then
				mask := mask | cfm_italic
			end
			if applicable_attributes.color then
				mask := mask | cfm_color
			end
			if applicable_attributes.background_color then
				mask := mask | cfm_backcolor
			end
			if applicable_attributes.effects_striked_out then
				mask := mask | cfm_strikeout
			end
			if applicable_attributes.effects_underlined then
				mask := mask | cfm_underline
			end
			if applicable_attributes.effects_vertical_offset then
				mask := mask | cfm_offset
			end
			if applicable_attributes.font_family then
				mask := mask | cfm_face
				mask := mask | cfm_charset
			end
			if applicable_attributes.font_weight then
				mask := mask | cfm_bold
			end
			if applicable_attributes.font_height then
				mask := mask | cfm_size
			end
			wel_character_format.set_mask (mask)
			set_character_format_selection (wel_character_format)
			safe_restore_caret
			enable_redraw
		end

	modify_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION) is
			-- Modify paragraph formatting `format' from caret positions `start_position' to `end_position' inclusive.
			-- Formatting applies to complete lines as seperated by new line characters that `start_position' and
			-- `end_position' fall on. All attributes of `format' that are set to `True' within `applicable_attributes' are applied.
		local
			mask: INTEGER
		do
			if applicable_attributes.alignment then
				mask := mask | pfm_alignment
			end
			if applicable_attributes.left_margin then
				mask := mask | pfm_startindent
			end
			if applicable_attributes.right_margin then
				mask := mask | pfm_rightindent
			end
			if applicable_attributes.top_spacing then
				mask := mask | pfm_spacebefore
			end
			if applicable_attributes.bottom_spacing then
				mask := mask | pfm_spaceafter
			end
			format_paragraph_internal (start_position, end_position, format, mask)
		end

	buffered_format (start_pos, end_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_buffer' to apply buffered contents to `Current'.
			-- `format' is not cloned internally and when buffer is flushed, its reference is
			-- used. Therefore, you must not modify `format' externally after passing to
			-- this procedure, otherwise all buffered appends that referenced the same `format' object
			-- will use its current value.
		local
			format_out: STRING
		do
			if not buffer_locked_in_format_mode then
					clear_structures
					buffer_locked_in_format_mode := True
					lowest_buffered_value := start_pos
					highest_buffered_value := end_pos
			else
				lowest_buffered_value := lowest_buffered_value.min (start_pos)
				highest_buffered_value := highest_buffered_value.max (end_pos)
			end
			if not formats.has (format) then
				formats.extend (format)
				heights.extend (format.font.height * 2)
			end
			format_out := format.hash_value
			formats_index.put (formats.index_of (format, 1), start_pos)
			start_formats.put (format_out, start_pos)
			end_formats.put (format_out, end_pos)
		end

	buffered_append (a_text: STRING_GENERAL; format: EV_CHARACTER_FORMAT) is
			-- Append `a_text' with format `format' to append buffer.
			-- To render buffer to `Current', call `flush_buffer' which replaces current content,
			-- or `flush_buffer_to' which inserts the formatted text.
			-- `format' is not cloned internally and when buffer is flushed, its reference is
			-- used. Therefore, you must not modify `format' externally after passing to
			-- this procedure, otherwise all buffered appends that referenced the same `format' object
			-- will use its current value.
		do
			if not buffer_locked_in_append_mode then
					-- If we are not already locked in append mode then
					-- we must be the first buffer, so we reset the structures
					-- for a new buffering and lock into append mode.
				clear_structures
				buffer_locked_in_append_mode := True
			end
			append_text_for_rtf (a_text, format.implementation)
		end

	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
			original_position: INTEGER
		do
				-- Store original caret position.
			original_position := caret_position

				-- If `start_position' and `end_position' are equal, the
				-- text must be inserted. If not, the appropriate area is
				-- selected, and will be replaced.
			if start_position = end_position then
				set_caret_position (start_position)
			else
					-- We use `end_position' less one, as `select_region' uses
					-- character positions, and not caret positions.
				set_selection (start_position - 1, end_position)
			end
			generate_complete_rtf_from_buffering
			text_up_to_date := False
			create stream.make (internal_text)
			insert_rtf_stream_in (stream)
			stream.release_stream
			buffer_locked_in_append_mode := False

				-- Ensure there is no selection, and the caret is restored.
			if has_selection then
				unselect
			end
				-- Protect the restoration of the caret position as the old position
				-- may no longer be valid.
			set_caret_position (original_position.min (text_length + 1))
		end

	flush_buffer is
			-- Flush any buffered operations.
		local
			last_end_value, counter, format_index, original_position, vertical_offset: INTEGER
			stream: WEL_RICH_EDIT_BUFFER_LOADER
			temp_string, default_font_format: STRING_32
			format_underlined, format_striked, format_bold, format_italic: BOOLEAN
			screen_dc: WEL_SCREEN_DC
			character_format_i: EV_CHARACTER_FORMAT_I
			current_character: WIDE_CHARACTER
		do
				-- Store original caret position.
			original_position := caret_position

				-- Do nothing if buffer is not is format mode or append mode,
				-- as there is nothing to flush. A user may call them however, as there
				-- is no need to restrict against such calls.
			if buffer_locked_in_format_mode then
					-- Create a screen DC for access to metrics
				create screen_dc
				screen_dc.get

				buffered_text := text.twin
					-- Generate an insertion string to use for default font
				default_font_format := default_font
				default_font_format.append ((font.height * 2).out)
				default_font_format.append (space_string)

					-- Generate FRT Header corresponding to all fonts used in formatting.			
					--{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 MS Shell Dlg;}{\f1\fswiss\fcharset0 Arial;}}
				font_text := font_table_start.twin

					-- Add the default font of `Current' as the first in the font table.
				font_text.append (generate_font_heading (font, 0))

					-- Now add all fonts used in formatting.
				from
					formats.start
				until
					formats.off
				loop
					character_format_i ?= formats.item.implementation
					build_font_from_format (character_format_i)
					formats.forth
				end
				font_text.append ("}")

					-- Generate RTF Header corresponding to all colors used in formatting.
					--	{\colortbl ;\red255\green0\blue0;\red0\green255\blue0;}
				color_text := color_table_start.twin

					-- Now perform buffering of colors.
				from
					formats.start
				until
					formats.off
				loop
					build_color_from_format (formats.item.implementation)
					formats.forth
				end

				color_text.append ("}")

				internal_text := font_text.twin
				internal_text.append ("%R%N")
				internal_text.append (color_text)
				internal_text.append ("%R%N")
				internal_text.append (view_text)
				last_end_value := 1
				internal_text.resize (default_string_size)
				from
					counter := lowest_buffered_value
				until
					counter > highest_buffered_value - 1
				loop
					if start_formats.item (counter) /= Void then
						format_index := formats_index.item (counter)
						temp_string := ""
						add_rtf_keyword (temp_string, rtf_highlight_string)

						temp_string.append (back_color_offset.i_th (format_index).out)
						add_rtf_keyword (temp_string, rtf_color_string)
						temp_string.append (color_offset.i_th (format_index).out)
						format_underlined := formats.i_th (format_index).effects.is_underlined
						if not is_current_format_underlined and format_underlined then
							add_rtf_keyword (temp_string, rtf_underline_string)
							is_current_format_underlined := True
						elseif is_current_format_underlined and not format_underlined then
							add_rtf_keyword (temp_string, rtf_underline_string + "0")
							is_current_format_underlined := False
						end
						format_striked := formats.i_th (format_index).effects.is_striked_out
						if not is_current_format_striked_through and format_striked then
							add_rtf_keyword (temp_string, rtf_strikeout_string)
							is_current_format_striked_through := True
						elseif is_current_format_striked_through and not format_striked then
							add_rtf_keyword (temp_string, rtf_strikeout_string + "0")
							is_current_format_striked_through := False
						end
						format_bold := formats.i_th (format_index).font.weight = {EV_FONT_CONSTANTS}.weight_bold
						if not is_current_format_bold and format_bold then
							add_rtf_keyword (temp_string, rtf_bold_string)
							is_current_format_bold := True
						elseif is_current_format_bold and not format_bold then
							add_rtf_keyword (temp_string, rtf_bold_string + "0")
							is_current_format_bold := False
						end
						format_italic := formats.i_th (format_index).font.shape = {EV_FONT_CONSTANTS}.shape_italic
						if not is_current_format_italic and format_italic then
							add_rtf_keyword (temp_string, rtf_italic_string)
							is_current_format_italic := True
						elseif is_current_format_italic and not format_italic then
							add_rtf_keyword (temp_string, rtf_italic_string + "0")
							is_current_format_italic := False
						end
						vertical_offset := formats.i_th (format_index).effects.vertical_offset
						if vertical_offset /= current_vertical_offset then
							add_rtf_keyword (temp_string, rtf_vertical_offset)
								-- We must specify the vertical offset in half points.
							temp_string.append ((pixel_to_point (screen_dc, vertical_offset) * 2).out)
							current_vertical_offset := vertical_offset
						end

						add_rtf_keyword (temp_string, rtf_font_string)
						temp_string.append (format_index.out)
						add_rtf_keyword (temp_string, rtf_font_size_string)
						temp_string.append (heights.i_th (format_index).out)
						temp_string.append (space_string)
						internal_text.append_string (temp_string)
						screen_dc.release
					end
					if end_formats.item (counter) /= Void and start_formats.item (counter) = Void then
						internal_text.append_string (default_font_format)
					end
					current_character := buffered_text.item (counter)
					if current_character = '%N' then
						add_rtf_keyword (internal_text, rtf_newline + "%N")
					elseif current_character = '\' then
						internal_text.append (rtf_backslash)
					elseif current_character = '{' then
						internal_text.append (rtf_open_brace)
					elseif current_character = '}' then
						internal_text.append (rtf_close_brace)
					else
						internal_text.append_character (current_character)
					end
					counter := counter + 1
				end
				internal_text.append ("}")
				set_selection (lowest_buffered_value - 1, highest_buffered_value - 1)
				create stream.make (internal_text)
				insert_rtf_stream_in (stream)
				stream.release_stream
			elseif buffer_locked_in_append_mode then
				generate_complete_rtf_from_buffering
				create stream.make (internal_text)
				rtf_stream_in (stream)
				stream.release_stream
			end
			buffer_locked_in_append_mode := False
			buffer_locked_in_format_mode := False

				-- Ensure there is no selection, and the caret is restored.
			if has_selection then
				unselect
			end
			text_up_to_date := False
			set_caret_position (original_position.min (text_length + 1))
		end

	enable_word_wrapping is
			-- Ensure `has_word_wrap' is True.
		do
			internal_change_word_wrapping (True)
		end

	disable_word_wrapping is
			-- Ensure `has_word_wrap' is False.
		do
			internal_change_word_wrapping (False)
		end

	internal_change_word_wrapping (word_wrapping: BOOLEAN) is
			-- Enable word wrapping if `word_wrapping', otherwise disable.
		local
			stream_in: WEL_RICH_EDIT_BUFFER_LOADER
			stream_out: WEL_RICH_EDIT_BUFFER_SAVER
			old_text_as_rtf: STRING
			l_is_read_only: BOOLEAN
		do
			safe_store_caret
			if change_actions_internal /= Void then
				change_actions_internal.block
			end

				-- Store contents of `Current' as RTF.
			create stream_out.make
			rtf_stream_out (stream_out)
			stream_out.release_stream
			old_text_as_rtf := stream_out.text

			l_is_read_only := is_editable
			wel_destroy
			if word_wrapping then
				internal_window_make (wel_parent, "", default_style, 0, 0, 0, 0, 0, default_pointer)
				show_vertical_scroll_bar
			else
				internal_window_make (wel_parent, "", default_style + Ws_hscroll, 0, 0, 0, 0, 0, default_pointer)
				show_scroll_bars
			end

			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
			cwin_send_message (wel_item, Em_settypographyoptions,
				to_wparam (to_advancedtypography), to_lparam (to_advancedtypography))
			set_text_limit (2560000)
			set_default_font
			if parent_imp /= Void then
				parent_imp.notify_change (2 + 1, Current)
			end
			set_background_color (background_color)
			enable_all_notifications

				-- Restore contents of `Current' from stored RTF.
			create stream_in.make (old_text_as_rtf)
			insert_rtf_stream_in (stream_in)
			stream_in.release_stream

				-- It appears that streaming rtf adds an extra new line character which we must now remove.
			select_region (text_length, text_length)
			check
				selected_text_is_newline: selected_text.is_equal ("%N")
			end
			delete_selection

			if change_actions_internal /= Void then
				change_actions_internal.resume
			end
			set_editable (l_is_read_only)
			safe_restore_caret
		ensure
			option_set: has_word_wrapping = word_wrapping
		end


	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' in pixels to `tab_width'.
		local
			screen_dc: WEL_SCREEN_DC
			logical_pixels: INTEGER
		do
			safe_store_caret
			tab_width := a_width
			if tab_positions.is_empty then
				create screen_dc
				screen_dc.get
				logical_pixels := get_device_caps (screen_dc.item, logical_pixels_x)
				screen_dc.release

				set_selection (0, text_length)
				set_tab_stops (mul_div (1440, tab_width, logical_pixels))
					-- Ensure change is reflected immediately.
				invalidate
			else
				update_tab_positions (1)
			end
			safe_restore_caret
		end

	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
			-- `value' is the index of the changed value when called directly by `tab_positions', as
			-- the result of a list modification, and is not used.
			-- Therefore, when calling `update_tab_positions' explicitly, any value may be passed.
		local
			array: ARRAY [INTEGER]
			counter, value_in_twips, logical_pixels, current_default: INTEGER
			screen_dc: WEL_SCREEN_DC
		do
			if tab_positions.count > 0 then
				safe_store_caret
				create screen_dc
				screen_dc.get
				logical_pixels := get_device_caps (screen_dc.item, logical_pixels_x)
				screen_dc.release

					-- Calculate the default tab width
				current_default := mul_div (1440, tab_width, logical_pixels)

					-- The Windows rich edit only supports 32 positions to be set for tab stops. After that,
					-- the default is reverted to.
				create array.make (1, 32)
				from
					counter := 1
				until
					counter > 32
				loop
					if tab_positions.count >= counter then
							-- Set tab to the value in `tab_positions'.
						value_in_twips := value_in_twips + mul_div (1440, tab_positions.i_th (counter), logical_pixels)
						if not tab_positions.off then
							tab_positions.forth
						end
					else
							-- Use the current default value, as a user has not set the position within `tab_positions'.
						value_in_twips := value_in_twips + current_default
					end
					array.put (value_in_twips, counter)
					counter := counter + 1
				end
					-- The formatting is applied to the current selection.
				set_selection (0, text_length)
				set_tab_stops_array (array)

				safe_restore_caret
					-- Ensure change is reflected immediately.
				invalidate
			end
		end

	text_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a text stream in operation with `stream'.
		do
			Precursor {WEL_RICH_EDIT} (stream)
			update_tab_positions (1)
		end

	rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a rtf stream in operation with `stream'.
		do
			Precursor {WEL_RICH_EDIT} (stream)
			update_tab_positions (1)
		end

	insert_rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a rtf stream in operation with `stream'.
		do
			Precursor {WEL_RICH_EDIT} (stream)
			update_tab_positions (1)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) text between
			-- 'start_pos' and 'end_pos'
		local
			actual_start, actual_end: INTEGER
		do
			if start_pos < end_pos then
				actual_start := start_pos
				actual_end := end_pos
			else
				actual_start := end_pos
				actual_end := start_pos
			end
			set_selection (actual_start - 1, actual_end)
		end

	set_current_format (format: EV_CHARACTER_FORMAT) is
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		local
			wel_character_format: WEL_CHARACTER_FORMAT2
		do
			safe_store_caret
			wel_character_format ?= format.implementation
			check
				wel_character_format_not_void: wel_character_format /= Void
			end
			set_character_format_selection (wel_character_format)
			safe_restore_caret
		end

	safe_store_caret is
			-- Store caret position, and block caret change events from occuring.
		do
			must_restore_selection := False
			internal_actions_blocked := True
			original_caret_position := internal_caret_position.min (text_length)
			if has_selection then
				must_restore_selection := True
				original_selection_start := wel_selection_start
				original_selection_end := wel_selection_end
			end
		end

	safe_restore_caret is
			-- Restore caret position stored by last call to `safe_store_caret' and restore
			-- change events.
		do
			internal_set_caret_position (original_caret_position.min (text_length))
			if must_restore_selection then
				if last_known_caret_position < original_selection_end then
						-- The direction of the selection is important when selecting with the keyboard
						-- and originally starting with no selection. See comment of `must_restore_selection'
						-- for details of problem case.
					set_selection (original_selection_start, original_selection_end)
				else
					set_selection (original_selection_end, original_selection_start)
				end
			else
				internal_set_caret_position (original_caret_position)
			end
			internal_actions_blocked := False
		end

	internal_actions_blocked: BOOLEAN
		-- Are caret position and selection change actions blocked internally due to an operation
		-- occurring that may affect them. They must be displayed during the implementation of
		-- certain features that require such modification as part of their implementation. See
		-- `safe_store_caret', `safe_restore_caret'.

	original_caret_position: INTEGER
		-- Original position of caret before call `to `safe_store_caret', to be restored by `safe_restore_caret'.

	must_restore_selection: BOOLEAN
		-- Must a selection be restored by `safe_restore_caret'?
		-- It is not just enough to check that there was originally a selection. For example, in the case
		-- where the `En_selchange_message' is received during an operation that will then call `safe_restore_caret'.
		-- As the selection may have changed from none to something between `safe_store_caret' and `safe_restore_caret',
		-- it is flagged, so the selection can be set. To reproduce such dangerous behaviour, remove selection from the rich text,
		-- connect an event to the `selection_change_actions' that queries the character format (internally this manipulates the selection)
		-- and select using shift and left or right. Without this boolean being set from `on_en_selchange' the new selection would not
		-- be correctly shown in the control. Julian.

	original_selection_start, original_selection_end: INTEGER
		-- Original selection when `safe_store_caret' called.

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			wel_set_background_color (background_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

feature {EV_CONTAINER_IMP} -- Implementation

	on_en_selchange (selection_type: INTEGER; character_range: WEL_CHARACTER_RANGE) is
			-- En_selchange received by `parent'. See WEL_EN_SELCHANGE_CONSTANTS for
			-- `selection_type' values. `character_range' contains lower and upper selection,
			-- equal when caret is moved with no selection.
		do
			if not internal_actions_blocked then
				if character_range.minimum /= character_range.maximum then
						-- Selection has changed, so must ensure that `safe_restore_caret' will set the appropriate
						-- selection if not flagged during `safe_store_caret'.
					must_restore_selection := True
				else
						-- Store last known caret position, so that `safe_restore_caret' can determine in which
						-- direction the selection is changing, and set it appropriately.
					last_known_caret_position := internal_caret_position
				end
				if selection_type = {WEL_EN_SELCHANGE_CONSTANTS}.sel_empty then
					if must_fire_final_selection then
							-- A selection has just been removed from `Current' so fire `selection_change_actions'
							-- one final time.
						must_fire_final_selection := False
						if selection_change_actions_internal /= Void then
							selection_change_actions_internal.call ([Void])
						end
					end
					check
						character_range_consistent: character_range.minimum = character_range.maximum
					end
					if caret_move_actions_internal /= Void then
							-- Limit the caret position to the last valid caret position as per EiffelVision2.
							-- It is possible to move the caret position to text_length + 2 in a rich edit control.
						caret_move_actions_internal.call ([(character_range.minimum + 1).min (text_length + 1)])
					end
				else
					must_fire_final_selection := True
					check
						character_range_consistent: character_range.minimum /= character_range.maximum
					end
					if selection_change_actions_internal /= Void then
						selection_change_actions_internal.call ([Void])
					end
				end
			end
		end

	last_known_caret_position: INTEGER
		-- Caret position kept internally for use in `safe_restore_caret', only set when there is no selection.
		-- Permits implementation to know the direction a selection is occuring, by comparing to the selection limits.

	must_fire_final_selection: BOOLEAN
		-- Must the selection change actions be fired when there is no selection, notifying
		-- that the selection has been lost. This is only fired once, hence the need for this boolean.

feature {EV_RICH_TEXT_BUFFERING_STRUCTURES_I}

	font_char_set (a_font: EV_FONT): INTEGER is
			-- `Result' is char set of font `a_font'.
		local
			font_imp: EV_FONT_IMP
		do
			font_imp ?= a_font.implementation
			check
				font_imp_not_void: font_imp /= Void
			end
			Result := font_imp.wel_font.log_font.char_set
		end

feature {NONE} -- Implementation

	internal_position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
			-- Internal version which has no precondition, as we implement `character_displayed'
			-- using the result of this call. Using `position_from_index' directly is not
			-- possible due to its precondition.
		require
			index_valid: an_index >= 1 and an_index <= text_length
		local
			wel: WEL_POINT
		do
			wel := position_from_character_index (an_index - 1)
			create Result.set (wel.x, wel.y)
		ensure
			result_not_void: Result /= Void
		end

	format_paragraph_internal (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; mask: INTEGER) is
			-- Apply paragraph formatting `format' to character positions `start_position', `end_position' inclusive, only
			-- modifying attributes specified in `mask'. Formatting applies to complete lines as seperated by new line
			-- characters that `start_position' and `end_position' fall on.
		require
			valid_positions: start_position <= end_position and start_position >= 1 and end_position <= text_length + 1
			format_not_void: format /= Void
		local
			paragraph: WEL_PARAGRAPH_FORMAT2
		do
			disable_redraw
			safe_store_caret
			set_selection (start_position - 1, end_position - 1)
			paragraph ?= format.implementation
			paragraph.set_mask (mask)
			set_paragraph_format (paragraph)
			safe_restore_caret
			enable_redraw
		end

	generate_font_heading (a_font: EV_FONT; index: INTEGER): STRING_32 is
			-- `Result' is a generated font descriptions for `a_font' with index `index'
			-- within the document.
		require
			a_font_not_void: a_font /= Void
			index_not_negative: index >= 0
		local
			a_font_imp: EV_FONT_IMP
			log_font: WEL_LOG_FONT
			current_family: INTEGER
			family: STRING_32
		do
			Result := "{"
			a_font_imp ?= a_font.implementation
			check
				font_imp_not_void: a_font_imp /= Void
			end
			log_font := a_font_imp.wel_font.log_font
			current_family := a_font_imp.family
				--\fnil | \froman | \fswiss | \fmodern | \fscript | \fdecor | \ftech | \fbidi
			inspect current_family
			when family_screen then
				family := "ftech"
			when family_roman then
				family := "froman"
			when family_sans then
				family := "fswiss"
			when family_typewriter then
				family := "fscript"
			when family_modern then
				family := "fmodern"
			else
				family := "fnil"
			end
			Result.append ("\f")
			Result.append (index.out)
			Result.append ("\")
			Result.append (family)
			Result.append ("\fcharset")
			Result.append (log_font.char_set.out)
			Result.append (" ")
			Result.append (a_font.name)
			Result.append (";}")
		ensure
			Result_not_void: Result /= Void
		end

	destroy is
			-- Destroy `Current'.
		do
			wel_destroy
			set_is_destroyed (True)
		end

	class_name: STRING_32 is
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.make_by_pointer (class_name_pointer)).string
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
		do
			-- Do nothing here. Redefined version from WEL_WINDOW as
			-- it redrew the background, causing flicker. We should do
			-- nothing, as Windows does this for us.
		end

	enable_redraw is
			-- Ensure `Current' is redrawn as required.
		do
			cwin_send_message (wel_item, wm_setredraw, to_wparam (1), to_lparam (0))
			invalidate_without_background
		end

	on_en_change is
			-- `Text' has been modified.
			--| We call the change_actions.
		do
			if change_actions_internal /= Void then
				change_actions_internal.call (Void)
			end
			text_up_to_date := False
		end

	internal_text_length: INTEGER
		-- Internal length of `text' in `Current'. This is only recomputed when
		-- `text_length' is called and `text_up_to_date' is False.

	text_up_to_date: BOOLEAN
		-- Is `text' of `Current' up to date? Used to buffer calls to `text' and `text_length'.

	private_windows_text_length: INTEGER
		-- The last value that windows returned as being the text length.
		-- We cannot use this directly as it includes %R%N but we can use
		-- it as a final check in `wel_text_length' to see if we must recomupte
		-- the length.

feature {EV_ANY_I} -- Implementation

	interface: EV_RICH_TEXT;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_RICH_TEXT_IMP

