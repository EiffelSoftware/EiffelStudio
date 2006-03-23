indexing
	description: "Edit control which can contain multiple lines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MULTIPLE_LINE_EDIT

inherit
	WEL_EDIT
		redefine
			scroll,
			set_selection,
			set_caret_position
		end

create
	make,
	make_by_id

feature -- Basic operations

	scroll (horizontal, vertical: INTEGER) is
			-- Scroll the text vertically and horizontally.
			-- `horizontal' is the number of characters to
			-- scroll horizontally, `vertical' is the number
			-- of lines to scroll vertically.
		do
			cwin_send_message (item, Em_linescroll, to_wparam (horizontal), to_lparam (vertical))
		end

feature -- Status setting

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
			-- If `scroll_caret_at_selection' is True, the
			-- caret will be scrolled to `start_position'.
		do
			cwin_send_message (item, Em_setsel, to_wparam (start_position), to_lparam (end_position))
			if scroll_caret_at_selection then
				cwin_send_message (item, Em_scrollcaret, to_wparam (0), to_lparam (0))
			end
		end

	set_caret_position (position: INTEGER) is
			-- Set the caret position with `position'.
			-- If `scroll_caret_at_selection' is True, the
			-- caret will be scrolled to `position'.
		do
			cwin_send_message (item, Em_setsel, to_wparam (position), to_lparam (position))
			if scroll_caret_at_selection then
				cwin_send_message (item, Em_scrollcaret, to_wparam (0), to_lparam (0))
			end
		end

	set_formatting_rect (rect: WEL_RECT) is
			-- Set `formatting_rect' with `rect'.
		require
			exists: exists
			rect_not_void: rect /= Void
		do
			cwin_send_message (item, Em_setrect, to_wparam (0), rect.item)
		end

	set_tab_stops (tab: INTEGER) is
			-- Set tab stops at every `tab' dialog box units.
		require
			exists: exists
			positive_tab: tab > 0
		do
			fixme (once "Should not use $tab here, since it is supposed to be an array of unsigned int.")
			cwin_send_message (item, Em_settabstops, to_wparam (1), $tab)
		end

	set_tab_stops_array (tab: ARRAY [INTEGER]) is
			-- Set tab stops using the values of `tab'.
		require
			exists: exists
			tab_not_void: tab /= Void
			tab_large_enough: tab.count > 1
		local
			a: WEL_INTEGER_ARRAY
		do
			fixme (once "Should use a WEL_UINT_ARRAY here, since it is supposed to be an array of unsigned int.")
			create a.make (tab)
			cwin_send_message (item, Em_settabstops, to_wparam (tab.count), a.item)
		end

	set_default_tab_stops is
			-- Set tab stops at every 32 dialog box units.
		require
			exists: exists
		do
			cwin_send_message (item, Em_settabstops, to_wparam (0), to_lparam (0))
		end

	enable_scroll_caret_at_selection is
			-- Set `scroll_caret_at_selection' to True.
			-- The caret will be scrolled at the selection after
			-- a call to `set_selection'.
		require
			exists: exists
		do
			scroll_caret_at_selection := True
		ensure
			scroll_caret_at_selection_enabled: scroll_caret_at_selection
		end

	disable_scroll_caret_at_selection is
			-- Set `scroll_caret_at_selection' to False.
			-- The caret will not be scrolled at the selection
			-- after a call to `set_selection'.
		require
			exists: exists
		do
			scroll_caret_at_selection := False
		ensure
			scroll_caret_at_selection_disabled: not scroll_caret_at_selection
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
				Em_getlinecount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	current_line_index: INTEGER is
			-- Index of the line that contains the caret.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Em_lineindex, to_wparam (-1), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	first_visible_line: INTEGER is
			-- Upper most visible line
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Em_getfirstvisibleline, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
			result_small_enough: Result < line_count
		end

	current_line_number: INTEGER is
			-- Line number of the line that contains the caret.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
				Em_linefromchar, to_wparam (-1), to_lparam (0))
		ensure
			positive_result: Result >= 0
			result_small_enough: Result < line_count
		end

	line_length (i: INTEGER): INTEGER is
			-- Length of the `i'th line
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < line_count
		do
			Result := cwin_send_message_result_integer (item, Em_linelength,
 				to_wparam (line_index (i)), to_lparam (0))
		ensure
			positive_result: Result >= 0
			result_ok: Result = line (i).count
		end

	line (i: INTEGER): STRING_32 is
			-- `i'th line
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < line_count
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			nb := line_length (i)
			if nb > 0 then
				create a_wel_string.make_empty (nb)
				a_wel_string.set_size_in_string (nb)
				nb := cwin_send_message_result_integer (item, Em_getline, to_wparam (i), a_wel_string.item)
				Result := a_wel_string.substring (1, nb)
			else
				create Result.make (0)
			end
		ensure
			result_exists: Result /= Void
			--count_ok: Result.count = line_length (i)
		end

	line_index (i: INTEGER): INTEGER is
			-- Number of characters from the beginning of the edit
			-- control to the zero-based line `i'.
			-- Retrieve a character index for a given line number.
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < line_count
		do
			Result := cwin_send_message_result_integer (item, Em_lineindex,
				to_wparam (i), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	line_from_char (i: INTEGER): INTEGER is
			-- Index of the line that contains the character
			-- index `i'. A character index is the number of
			-- characters from the beginning of the edit control.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
				Em_linefromchar, to_wparam (i), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	scroll_caret_at_selection: BOOLEAN
			-- Will the caret be scrolled at the selection after
			-- a call to `set_selection'?

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Es_left +
				Es_autohscroll + Es_autovscroll +
				Ws_vscroll + Ws_hscroll + Es_multiline
		end

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




end -- class WEL_MULTIPLE_LINE_EDIT

