note
	description: "[
		A control in which the user can enter and edit rich text.

		Note: Rich edit DLL needs to be loaded. See class WEL_RICH_EDIT_DLL.
			All paragraph measurements are in twips. A twip is 1/1440 of
			an inch or 1/20 of a point.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT

inherit
	WEL_MULTIPLE_LINE_EDIT
		rename
			make as multiple_line_edit_make
		export
			{NONE} set_font
		redefine
			class_name,
			default_style,
			has_selection,
			set_selection,
			selection_start,
			selection_end,
			set_text_limit,
			set_tab_stops_array,
			set_tab_stops,
			set_default_tab_stops,
			text,
			set_text,
			process_notification_info,
			caret_position,
			set_caret_position
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

	WEL_SCF_CONSTANTS
		export
			{NONE} all
		end

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		end

	WEL_FIND_FLAGS_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_name: READABLE_STRING_GENERAL;
			a_x, a_y, a_width, a_height, an_id: INTEGER)
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
			name_set: text.same_string_general (a_name)
			id_set: id = an_id
		end

feature -- Status report

	selection_start: INTEGER
			-- Index of the first character selected
		do
			Result := selection.minimum
		end

	selection_end: INTEGER
			-- Index of the last character selected
		do
			Result := selection.maximum
		end

	selection: WEL_CHARACTER_RANGE
			-- Structure which contains the starting and ending
			-- character positions of the selection.
		require
			exists: exists
		do
			create Result.make_empty
			{WEL_API}.send_message (item, Em_exgetsel, to_wparam (0), Result.item)
		end

	caret_position: INTEGER
		local
			range: WEL_CHARACTER_RANGE
		do
			create range.make_empty
			{WEL_API}.send_message (item, Em_exgetsel, to_wparam (0), range.item)
			Result := range.maximum
		end

	has_selection: BOOLEAN
			-- Has a current selection?
		local
			a_selection: WEL_CHARACTER_RANGE
		do
			a_selection := selection
			Result := a_selection.minimum /= a_selection.maximum
		end

	default_character_format: WEL_CHARACTER_FORMAT
			-- Default character format information
		require
			exists: exists
		do
			create Result.make
			Result.set_all_masks
			{WEL_API}.send_message (item, Em_getcharformat, to_wparam (0), Result.item)
		ensure
			result_not_void: Result /= Void
		end

	current_selection_character_format: WEL_CHARACTER_FORMAT
			-- Current selection character format information
		require
			exists: exists
		do
			create Result.make
			Result.set_all_masks
			{WEL_API}.send_message (item, Em_getcharformat, to_wparam (1), Result.item)
		ensure
			result_not_void: Result /= Void
		end

	text_at (i: INTEGER; n: INTEGER): STRING_32
			-- Text of length `n' at position `i'.
		require
			exists: exists
			valid_length: n > 0
			valid_index: text.valid_index (i + 1)
			valid_length: text.valid_index (i + n)
		local
			new_options, old_options: INTEGER
			previous_selection: WEL_CHARACTER_RANGE
		do
			hide_selection
			previous_selection := selection
			old_options := options
			new_options := 0
			set_options (Ecoop_set, new_options)

			set_selection (i, i + n)
			Result := selected_text

			set_options (Ecoop_set, old_options)
			{WEL_API}.send_message (item, Em_exsetsel, to_wparam (0), previous_selection.item)
			show_selection
		end

	selected_text: STRING_32
			-- Currently selected text
		require
			exists: exists
			has_selection: has_selection
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create a_wel_string.make_empty (selection_end - selection_start)
			nb := {WEL_API}.send_message_result_integer (item, Em_getseltext, to_wparam (0), a_wel_string.item)
			Result := a_wel_string.substring (1, nb)
		ensure
			selected_text_not_void: Result /= Void
--			valid_length: Result.count =
--				selection_end - selection_start
		end

	position_from_character_index (character_index: INTEGER): WEL_POINT
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
			create Result.make (0, 0)
			{WEL_API}.send_message (item, Em_posfromchar, Result.item, to_lparam (character_index))
		ensure
			result_not_void: Result /= Void
		end

	character_index_from_position (a_x, a_y: INTEGER): INTEGER
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
			create p.make (a_x, a_y)
			Result := {WEL_API}.send_message_result_integer (item, Em_charfrompos, to_wparam (0), p.item)
		end

	line_number_from_position (a_pos: INTEGER): INTEGER
			-- Retrieves the line number from a character position.
			-- Line numbers start at 0.
		require
			exists: exists
			a_pos_large_enough: a_pos >= 0
		do
			Result := {WEL_API}.send_message_result_integer (item, Em_exlinefromchar, to_wparam (0), to_lparam (a_pos))
		end

	event_mask: INTEGER
			-- Event mask which specifies notification message the
			-- control sends to its parent window.
			-- See class WEL_ENM_CONSTANTS for values.
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Em_geteventmask, to_wparam (0), to_lparam (0))
		end

	text: STRING_32
			-- Contents of the rich edit control
		local
			stream: WEL_RICH_EDIT_BUFFER_SAVER
		do
			create stream.make
			stream.set_is_unicode_data (True)
			text_stream_out (stream)
			Result := stream.text
			stream.release_stream
		end

	count: INTEGER
			-- Length of text.
		do
			Result := {WEL_API}.send_message_result_integer (item, Wm_gettextlength, to_wparam (0), to_lparam (0))
		end

	options: INTEGER
			-- Give the current set of options.
		do
			Result := {WEL_API}.send_message_result_integer (item, Em_getoptions, to_wparam (0), to_lparam (0))
		end

feature -- Status setting

	set_selection (start_position, end_position: INTEGER)
			-- Set the selection between `start_position'
			-- and `end_position'.
		require else
			selection_in_upper_bound: start_position <= text_length and end_position <= text_length + 1
		local
			range: WEL_CHARACTER_RANGE
		do
			create range.make (start_position, end_position)
			{WEL_API}.send_message (item, Em_exsetsel, to_wparam (0), range.item)
		end

	set_caret_position (position: INTEGER)
   			-- Set the caret position with `position'.
   			-- If `scroll_caret_at_selection' is True, the
   			-- caret will be scrolled to `position'.
 		local
			range: WEL_CHARACTER_RANGE
 		do
			create range.make (position, position)
			{WEL_API}.send_message (item, Em_exsetsel, to_wparam (0), range.item)
  		end

	move_to_selection
			-- Move the selected text to be visible
		do
			{WEL_API}.send_message (item, Em_scrollcaret, to_wparam (0), to_lparam (0))
		end

	set_text_limit (limit: INTEGER)
			-- Set the length of the text the user can enter into
			-- the edit control.
		do
			{WEL_API}.send_message (item, Em_exlimittext, to_wparam (0), to_lparam (limit))
		end

	set_tab_stops_array (tab: ARRAY [INTEGER])
			-- Set tab stops using the values of `tab'.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			create para.make
			para.set_tabulations (tab)
			set_paragraph_format (para)
		end

	set_tab_stops (tab: INTEGER)
			-- Set tab stops at every `tab' dialog box units.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			create para.make
			para.set_tabulation (tab)
			set_paragraph_format (para)
		end

	set_default_tab_stops
			-- Set default tab stops.
		local
			para: WEL_PARAGRAPH_FORMAT
		do
			create para.make
			para.set_default_tabulation
			set_paragraph_format (para)
		end

	set_event_mask (an_event_mask: INTEGER)
			-- Set `event_mask' with `an_event_mask'.
			-- See class WEL_ENM_CONSTANTS for values.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Em_seteventmask, to_wparam (0), to_lparam (an_event_mask))
		ensure
			event_mask_set: event_mask = an_event_mask
		end

	set_options (operation, an_options: INTEGER)
			-- Set the opetions for the control.
			-- See class WEL_ECO_CONSTANTS for values.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Em_setoptions, to_wparam (operation), to_lparam (an_options))
		end

	set_text (a_text: detachable READABLE_STRING_GENERAL)
			-- Set `text' with `a_text'.
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
		do
			if a_text /= Void then
				create stream.make (a_text)
			else
				create stream.make ("")
			end
			stream.set_is_unicode_data (True)
			text_stream_in (stream)
			stream.release_stream
		end

	insert_text (a_text: READABLE_STRING_GENERAL)
			-- Insert `a_text' at the position of the cursor.
			-- Replace the current selection if there is one
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			stream: WEL_RICH_EDIT_BUFFER_LOADER
		do
			create stream.make (a_text)
			stream.set_is_unicode_data (True)
			insert_text_stream_in (stream)
			stream.release_stream
		end

	set_background_color (color: WEL_COLOR_REF)
			-- Set the background color with `color'.
		require
			exists: exists
			color_not_void: color /= Void
		do
			{WEL_API}.send_message (item, Em_setbkgndcolor, to_wparam (0), to_lparam (color.item))
		end

	set_background_system_color
			-- Set the background color with the window
			-- background system color.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Em_setbkgndcolor, to_wparam (1), to_lparam (0))
		end

	enable_standard_notifications
			-- Enable the standard notifications.
			-- (Enm_change, Enm_update and Enm_scroll).
		require
			exists: exists
		do
			set_event_mask (Enm_change + Enm_update + Enm_scroll)
		end

	enable_all_notifications
			-- Enable all notifications.
		require
			exists: exists
		do
			set_event_mask (
				Enm_change | Enm_update | Enm_scroll |
				Enm_keyevents | Enm_mouseevents | Enm_requestresize |
				Enm_selchange | Enm_dropfiles | Enm_protected |
				Enm_correcttext | Enm_imechange)
		end

	disable_notifications
			-- Disable all notifications.
		require
			exists: exists
		do
			set_event_mask (Enm_none)
		ensure
			no_notification: event_mask = Enm_none
		end

feature -- Basic operations

	load_text_file (file: RAW_FILE)
			-- Load a text `file' in the rich edit control.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_read: file.is_open_read
		local
			stream: WEL_RICH_EDIT_FILE_LOADER
		do
			create stream.make (file)
			text_stream_in (stream)
			stream.release_stream
		ensure
			file_closed: file.is_closed
		end

	load_rtf_file (file: RAW_FILE)
			-- Load a RTF `file' in the rich edit control.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_read: file.is_open_read
		local
			stream: WEL_RICH_EDIT_FILE_LOADER
		do
			create stream.make (file)
			rtf_stream_in (stream)
			stream.release_stream
		ensure
			file_closed: file.is_closed
		end

	save_text_file (file: RAW_FILE)
			-- Save the contents of the rich edit control in text
			-- format in `file'.
		require
			exists: exists
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_write: file.is_open_write
		local
			stream: WEL_RICH_EDIT_FILE_SAVER
		do
			create stream.make (file)
			text_stream_out (stream)
			stream.release_stream
		ensure
			file_closed: file.is_closed
		end

	save_rtf_file (file: RAW_FILE)
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
			create stream.make (file)
			rtf_stream_out (stream)
			stream.release_stream
		ensure
			file_closed: file.is_closed
		end

	text_stream_in (stream: WEL_RICH_EDIT_STREAM_IN)
			-- Start a text stream in operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			send_stream_in_message (Sf_text | Sf_unicode, stream)
		end

	text_stream_out (stream: WEL_RICH_EDIT_STREAM_OUT)
			-- Start a text stream out operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			send_stream_out_message (Sf_text | Sf_unicode, stream)
		end

	rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN)
			-- Start a rtf stream in operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			send_stream_in_message (Sf_rtf, stream)
		end

	rtf_stream_out (stream: WEL_RICH_EDIT_STREAM_OUT)
			-- Start a rtf stream out operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			send_stream_out_message (Sf_rtf, stream)
		end

	insert_text_stream_in (stream: WEL_RICH_EDIT_STREAM_IN)
			-- Start a text stream in operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			send_stream_in_message (Sf_text | Sf_unicode | Sff_selection, stream)
		end

	insert_rtf_stream_in (stream: WEL_RICH_EDIT_STREAM_IN)
			-- Start a rtf stream in operation with `stream'.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			send_stream_in_message (Sf_rtf + Sff_selection, stream)
		end

	send_stream_in_message (format: INTEGER;
			stream: WEL_RICH_EDIT_STREAM_IN)
			-- Start stream in operation with `stream'.
			-- See class WEL_SF_CONSTANTS for `format' values.
			-- Lowest level stream in procedures.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			stream.init_action
			{WEL_API}.send_message (item, Em_streamin, to_wparam (format), stream.item)
			stream.finish_action
		end

	send_stream_out_message (format: INTEGER;
			stream: WEL_RICH_EDIT_STREAM_OUT)
			-- Start stream out operation with `stream'.
			-- See class WEL_SF_CONSTANTS for `format' values.
			-- Lowest level stream out procedures.
		require
			exists: exists
			stream_not_void: stream /= Void
			stream_exists: stream.exists
		do
			stream.init_action
			{WEL_API}.send_message (item, Em_streamout, to_wparam (format), stream.item)
			stream.finish_action
		end

	hide_selection
			-- Hide the selection.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Em_hideselection, to_wparam (1), to_lparam (0))
		end

	show_selection
			-- Show selection.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Em_hideselection, to_wparam (0), to_lparam (0))
		end

	find (text_to_find: READABLE_STRING_GENERAL; match_case: BOOLEAN; start_from: INTEGER): INTEGER
			-- Find `text_to_find' in WEL_RICH_EDIT
		require
			text_to_find: text_to_find /= Void
		local
			find_text: WEL_FIND_ARGUMENT
			range: WEL_CHARACTER_RANGE
			flags: INTEGER
		do
			create range.make (start_from, count)
			create find_text.make (range, text_to_find)

			if match_case then
				flags := Fr_matchcase
			end

			Result := {WEL_API}.send_message_result_integer (item, Em_findtextex,
				to_wparam (flags), find_text.item)
		end

feature -- Element change

	set_character_format_all (a_char_format: WEL_CHARACTER_FORMAT)
			-- Apply `a_char_format' to all text.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
			a_char_format_exists: a_char_format.exists
		do
			{WEL_API}.send_message (item, Em_setcharformat,
				to_wparam (Scf_all), a_char_format.item)
		end

	set_character_format_selection (a_char_format: WEL_CHARACTER_FORMAT)
			-- Apply `a_char_format' to current selection.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
			a_char_format_exists: a_char_format.exists
		do
			{WEL_API}.send_message (item, Em_setcharformat,
				to_wparam (Scf_selection), a_char_format.item)
		end

	set_character_format_word (a_char_format: WEL_CHARACTER_FORMAT)
			-- Set the current word with `a_char_format'.
		require
			exists: exists
			a_char_format_not_void: a_char_format /= Void
			a_char_format_exists: a_char_format.exists
		do
			{WEL_API}.send_message (item, Em_setcharformat,
				to_wparam (Scf_word + Scf_selection), a_char_format.item)
		end

	set_paragraph_format (a_para_format: WEL_PARAGRAPH_FORMAT)
			-- Set the current paragraph with `a_para_format'.
		require
			exists: exists
			a_para_format_not_void: a_para_format /= Void
			a_para_format_exists: a_para_format.exists
		do
			{WEL_API}.send_message (item, Em_setparaformat, to_wparam (0), a_para_format.item)
		end

	print_all (dc: WEL_PRINTER_DC; title: READABLE_STRING_GENERAL)
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
					-- Looks like we need to remove the %R that seems to be included in `text_length'.
					-- To do that we simply need to remove the `line_count - 1'.
				tl := text_length - (line_count - 1)
				create fr.make
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
				create r.make (page_left, page_top,
					page_width, page_height)
			until
				i >= tl
			loop
				-- Print as mush as will fit on a page. The
				-- return value is the index of the first
				-- character on the next page.
				fr.set_rect (r)
				fr.set_rect_page (r)
				i := {WEL_API}.send_message_result_integer (item,
					Em_formatrange, to_wparam (1), fr.item)
				-- If there is more text to print, spit this
				-- page from the printer and start another one.
				if i < tl then
					dc.end_page
					dc.start_page
					fr.character_range.set_range (i, tl)
				end
			end
			-- Reset the formatting of the rich edit control.
			{WEL_API}.send_message (item, Em_formatrange, to_wparam (1), to_lparam (0))

			-- Finish the document.
			dc.end_page
			dc.end_document
		end

		ignore_filtered_message
				-- Call this message from within `on_en_msgfilter'
				-- to prevent the filtered message to be handled
				-- by the Rich Edit Control.
			local
				l_parent: like parent
			do
				l_parent := parent
				if l_parent /= Void then
					l_parent.set_message_return_value (to_lresult (1))
					l_parent.disable_default_processing
				end
			end
feature -- Notifications

	on_en_msgfilter (a_msg_filter: WEL_MSG_FILTER)
			-- Notfication of a keyboard or mouse event in the control.
			-- Only notfications are sent that are enabled
			-- in the `event_mask'.
			-- Note:
			-- To prevent the Rich Edit Control from handling the message
			-- indicated with `a_msg_filter' call `ignore_filtered_message'
		require
			exists: exists
			msg_filter_exists: a_msg_filter /= Void and then a_msg_filter.exists
		do
		end

feature -- Obsolete

	default_char_format: WEL_CHARACTER_FORMAT obsolete
			"Use ``default_character_format''"
		require
			exists: exists
		do
			Result := default_character_format
		ensure
			result_not_void: Result /= Void
		end

	current_selection_char_format: WEL_CHARACTER_FORMAT obsolete
			"Use ``current_selection_character_format''"
		require
			exists: exists
		do
			Result := current_selection_character_format
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (Class_name_pointer)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_border +
				Ws_hscroll + Ws_vscroll + Es_savesel +
				Es_disablenoscroll + Es_multiline
		end

	process_notification_info (notification_info: WEL_NMHDR)
		local
			a_msg_filter: WEL_MSG_FILTER
		do
			if
				notification_info.code = En_msgfilter
			then
				create a_msg_filter.make_from_nmhdr (notification_info)
				on_en_msgfilter (a_msg_filter)
			end
		end

feature {NONE} -- Externals

	Class_name_pointer: POINTER
		external
			"C [macro %"redit.h%"]"
		alias
			"RICHEDIT_CLASS"
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_RICH_EDIT

