indexing
	description: "A control in which the user can enter and edit rich text."
	note: "Rich edit DLL needs to be loaded. See class WEL_RICH_EDIT_DLL. %
		%All paragraph measurements are in twips. A twip is 1/1440 of %
		%an inch or 1/20 of a point."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT

inherit
	WEL_MULTIPLE_LINE_EDIT
		rename
			make as multiple_line_edit_make
		redefine
			class_name,
			default_style,
			set_selection,
			selection_start,
			selection_end,
			set_text_limit,
			set_tab_stops_array,
			set_tab_stops,
			set_default_tab_stops,
			text,
			set_text
		end

	WEL_RICH_EDIT_MESSAGE_CONSTANTS
		export
			{NONE} all
		end

	WEL_RICH_EDIT_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_ENM_CONSTANTS
		export
			{NONE} all
		end

	WEL_ECO_CONSTANTS
		export
			{NONE} all
		end

	WEL_SF_CONSTANTS
		export
			{NONE} all
		end

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a rich edit control.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			multiple_line_edit_make (a_parent, a_name,
				a_x, a_y, a_width, a_height, an_id)
			set_options (Ecoop_set, Eco_autovscroll + Eco_autohscroll)
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.is_equal (a_name)
			id_set: id = an_id
		end

feature -- Status report

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := selection.minimum
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := selection.maximum
		end

	selection: WEL_CHARACTER_RANGE is
			-- Structure which contains the starting and ending
			-- character positions of the selection.
		require
			exists: exists
		do
			!! Result.make_empty
			cwin_send_message (item, Em_exgetsel, 0,
				Result.to_integer)
		end

	default_character_format: WEL_CHARACTER_FORMAT is
			-- Default character format information
		require
			exists: exists
		do
			!! Result.make
			Result.set_all_masks
			cwin_send_message (item, Em_getcharformat, 0,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	current_selection_character_format: WEL_CHARACTER_FORMAT is
			-- Current selection character format information
		require
			exists: exists
		do
			!! Result.make
			Result.set_all_masks
			cwin_send_message (item, Em_getcharformat, 1,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	selected_text: STRING is
			-- Currently selected text
		require
			exists: exists
			has_selection: has_selection
		local
			a: ANY
		do
			!! Result.make (selection_end - selection_start)
			a := Result.to_c
			Result.fill_blank
			cwin_send_message (item, Em_getseltext, 0,
				cwel_pointer_to_integer ($a))
		ensure
			valid_length: Result.count =
				selection_end - selection_start
		end

	position_from_character_index (character_index: INTEGER): WEL_POINT is
			-- Coordinates of a character at `character_index' in
			-- the client area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area.
			-- The coordinates are truncated to integer values and
			-- are in screen units relative to the upper-left
			-- corner of the client area of the control.
		require
			exists: exists
			index_large_enough: character_index >= 0
			index_small_enough: character_index <= text_length + 2
		do
			--| The Win32 SDK documentation for EM_POSFROMCHAR
			--| is incorrect.
			--| The right parameters has been found in the
			--| Microsoft Developer Network CD (April 1996).
			--| See article PSS ID Number: Q137805
			!! Result.make (0, 0)
			cwin_send_message (item, Em_posfromchar,
				Result.to_integer, character_index)
		ensure
			result_not_void: Result /= Void
		end

	character_index_from_position (a_x, a_y: INTEGER): INTEGER is
			-- Zero-based character index of the character which is
			-- the nearest to `a_x' and `a_y' position in the client
			-- area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area. The coordinates are truncated
			-- to integer values and are in screen units relative
			-- to the upper-left corner of the client area of the
			-- control.
		require
			exists: exists
			a_x_large_enough: a_x >= 0
			a_y_large_enough: a_y >= 0
		local
			p: WEL_POINT
		do
			--| The Win32 SDK documentation for EM_CHARFROMPOS
			--| is incorrect.
			--| The right parameters has been found in the
			--| Microsoft Developer Network CD (April 1996).
			--| See article PSS ID Number: Q137805
			!! p.make (a_x, a_y)
			Result := cwin_send_message_result (item,
				Em_charfrompos, 0, p.to_integer)
		end

	event_mask: INTEGER is
			-- Event mask which specifies notification message the
			-- control sends to its parent window.
			-- See class WEL_ENM_CONSTANTS for values.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Em_geteventmask, 0, 0)
		end

	text: STRING is
			-- Contents of the rich edit control
		local
			stream: WEL_RICH_EDIT_BUFFER_SAVER
		do
			!! stream.make
			text_stream_out (stream)
			Result := stream.text
		end

feature -- Status setting

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		local
			range: WEL_CHARACTER_RANGE
		do
			!! range.make (start_position, end_position)
			cwin_send_message (item, Em_exsetsel, 0,
				range.to_integer)
			if scroll_caret_at_selection then
				cwel_scroll_caret (item)
			end
		end

	set_text_limit (limit: INTEGER) is
			-- Set the length of the text the user can enter into
			-- the edit control.
		do
			cwin_send_message (item, Em_exlimittext, 0, limit)
		end

	set_tab_stops_array (tab: ARRAY [INTEGER]) is
			-- Set tab stops using the values of `tab'.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			!! para.make
			para.set_tabulations (tab)
			set_paragraph_format (para)
		end

	set_tab_stops (tab: INTEGER) is
			-- Set tab stops at every `tab' dialog box units.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			!! para.make
			para.set_tabulation (tab)
			set_paragraph_format (para)
		end

	set_default_tab_stops is
			-- Set default tab stops.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			!! para.make
			para.set_default_tabulation
			set_paragraph_format (para)
		end

	set_event_mask (an_event_mask: INTEGER) is
			-- Set `event_mask' with `an_event_mask'.
			-- See class WEL_ENM_CONSTANTS for values.
		require
			exists: exists
		do
			cwin_send_message (item, Em_seteventmask, 0,
				an_event_mask)
		ensure
			event_mask_set: event_mask = an_event_mask
		end

	set_options (operation, an_options: INTEGER) is
			-- Set the opetions for the control.
			-- See class WEL_ECO_CONSTANTS for values.
		require
			exists: exists
		do
			cwin_send_message (item, Em_setoptions, operation,
				an_options)
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
		do
			!! stream.make (a_text)
			text_stream_in (stream)
		end

	set_background_color (color: WEL_COLOR_REF) is
			-- Set the background color with `color'.
		require
			exists: exists
			color_not_void: color /= Void
		do
			cwin_send_message (item, Em_setbkgndcolor, 0,
				color.to_integer)
		end

	set_background_system_color is
			-- Set the background color with the window
			-- background system color.
		require
			exists: exists
		do
			cwin_send_message (item, Em_setbkgndcolor, 1, 0)
		end

	enable_standard_notifications is
			-- Enable the standard notifications.
			-- (Enm_change, Enm_update and Enm_scroll).
		require
			exists: exists
		do
			set_event_mask (Enm_change + Enm_update + Enm_scroll)
		end

	disable_notifications is
			-- Disable all notifications.
		require
			exists: exists
		do
			set_event_mask (Enm_none)
		ensure
			no_notification: event_mask = Enm_none
		end

feature -- Basic operations

	load_text_file (file: RAW_FILE) is
			-- Load a text `file' in the rich edit control.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_read: file.is_open_read
		local
			stream: WEL_RICH_EDIT_FILE_LOADER
		do
			!! stream.make (file)
			text_stream_in (stream)
		ensure
			file_closed: file.is_closed
		end

	load_rtf_file (file: RAW_FILE) is
			-- Load a RTF `file' in the rich edit control.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_read: file.is_open_read
		local
			stream: WEL_RICH_EDIT_FILE_LOADER
		do
			!! stream.make (file)
			rtf_stream_in (stream)
		ensure
			file_closed: file.is_closed
		end

	save_text_file (file: RAW_FILE) is
			-- Save the contents of the rich edit control in text
			-- format in `file'.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_read: file.is_open_write
		local
			stream: WEL_RICH_EDIT_FILE_SAVER
		do
			!! stream.make (file)
			text_stream_out (stream)
		ensure
			file_closed: file.is_closed
		end

	save_rtf_file (file: RAW_FILE) is
			-- Save the contents of the rich edit control in RTF
			-- format in `file'.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_read: file.is_open_write
		local
			stream: WEL_RICH_EDIT_FILE_SAVER
		do
			!! stream.make (file)
			rtf_stream_out (stream)
		ensure
			file_closed: file.is_closed
		end

	text_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a text stream in operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
		do
			send_stream_in_message (Sf_text, stream)
		end

	text_stream_out (stream: WEL_RICH_EDIT_STREAM_OUT) is
			-- Start a text stream out operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
		do
			send_stream_out_message (Sf_text, stream)
		end

	rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start a rtf stream in operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
		do
			send_stream_in_message (Sf_rtf, stream)
		end

	rtf_stream_out (stream: WEL_RICH_EDIT_STREAM_OUT) is
			-- Start a rtf stream out operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
		do
			send_stream_out_message (Sf_rtf, stream)
		end

	send_stream_in_message (format: INTEGER;
			stream: WEL_RICH_EDIT_STREAM_IN) is
			-- Start stream in operation with `stream'.
			-- See class WEL_SF_CONSTANTS for `format' values.
			-- Lowest level stream in procedures.
		require
			exists: exists
			stream_not_void: stream /= Void
		do
			stream.init_action
			cwin_send_message (item, Em_streamin, format,
				stream.to_integer)
			stream.finish_action
		end

	send_stream_out_message (format: INTEGER;
			stream: WEL_RICH_EDIT_STREAM_OUT) is
			-- Start stream out operation with `stream'.
			-- See class WEL_SF_CONSTANTS for `format' values.
			-- Lowest level stream out procedures.
		require
			exists: exists
			stream_not_void: stream /= Void
		do
			stream.init_action
			cwin_send_message (item, Em_streamout, format,
				stream.to_integer)
			stream.finish_action
		end

	hide_selection is
			-- Hide the selection.
		require
			exists: exists
		do
			cwin_send_message (item, Em_hideselection, 1, 0)
		end

	show_selection is
			-- Show the selection.
		require
			exists: exists
		do
			cwin_send_message (item, Em_hideselection, 0, 0)
		end

feature -- Element change

	set_character_format_selection (a_char_format: WEL_CHARACTER_FORMAT) is
			-- Set the current selection with `a_char_format'.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
		do
			cwin_send_message (item, Em_setcharformat,
				Scf_selection, a_char_format.to_integer)
		end

	set_character_format_word (a_char_format: WEL_CHARACTER_FORMAT) is
			-- Set the current word with `a_char_format'.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
		do
			cwin_send_message (item, Em_setcharformat,
				Scf_word + Scf_selection,
				a_char_format.to_integer)
		end

	set_paragraph_format (a_para_format: WEL_PARAGRAPH_FORMAT) is
			-- Set the current paragraph with `a_para_format'.
		require
			exists: exists
			a_para_format_not_void: a_para_format /= Void
		do
			cwin_send_message (item, Em_setparaformat, 0,
				a_para_format.to_integer)
		end

	print_all (dc: WEL_PRINTER_DC; title: STRING) is
			-- Print the contents of the rich edit control on
			-- the printer `dc'. `title' is the printer job name.
		require
			exists: exists
			dc_not_void: dc /= Void
			dc_exists: dc.exists
			title_not_void: title /= Void
		local
			i, tl, page_width, page_height: INTEGER
			page_left, page_top: INTEGER
			fr: WEL_FORMAT_RANGE
			r: WEL_RECT
		do
			from
				tl := text_length
				!! fr.make
				fr.set_dc (dc)
				fr.set_dc_target (dc)
				fr.character_range.set_range (0, tl)
				dc.start_document (title)
				dc.start_page
				page_left := 720
				page_top := 720
				page_width := (dc.width /
					dc.device_caps (Logical_pixels_x) *
					1440).truncated_to_integer - 720
				page_height := (dc.height /
					dc.device_caps (Logical_pixels_y) *
					1440).truncated_to_integer - 720
				!! r.make (page_left, page_top,
					page_width, page_height)
			until
				i >= tl
			loop
				-- Print as mush as will fit on a page. The
				-- return value is the index of the first
				-- character on the next page.
				fr.set_rect (r)
				fr.set_rect_page (r)
				i := cwin_send_message_result (item,
					Em_formatrange, 1, fr.to_integer)
				-- If there is more text to print, spit this
				-- page from the printer and start another one.
				if i < tl then
					dc.end_page
					dc.start_page
					fr.character_range.set_range (i, tl)
				end
			end
			-- Reset the formatting of the rich edit control.
			cwin_send_message (item, Em_formatrange, 1, 0)

			-- Finish the document.
			dc.end_page
			dc.end_document
		end

feature -- Obsolete

	default_char_format: WEL_CHARACTER_FORMAT is obsolete
			"Use ``default_character_format''"
		require
			exists: exists
		do
			Result := default_character_format
		ensure
			result_not_void: Result /= Void
		end

	current_selection_char_format: WEL_CHARACTER_FORMAT is obsolete
			"Use ``current_selection_character_format''"
		require
			exists: exists
		do
			Result := current_selection_character_format
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			Result := "RichEdit"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_border +
				Ws_hscroll + Ws_vscroll + Es_savesel +
				Es_disablenoscroll + Es_multiline
		end

feature {NONE} -- Externals

	Scf_selection: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SCF_SELECTION"
		end

	Scf_word: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SCF_WORD"
		end

end -- class WEL_RICH_EDIT

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
