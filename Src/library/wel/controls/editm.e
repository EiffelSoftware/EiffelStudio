indexing
	description: "Edit control which can contain multiple lines."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MULTIPLE_LINE_EDIT

inherit
	WEL_EDIT

	WEL_ES_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Basic operations

	scroll (horizontal, vertical: INTEGER) is
			-- Scroll the text vertically and horizontally.
			-- `horizontal' is the number of characters to
			-- scroll horizontally, `vertical' is the number
			-- of lines to scroll vertically.
		require
			exists: exists
		do
			cwin_send_message (item, Em_linescroll, horizontal,
				vertical)
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Em_getlinecount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

	current_line_index: INTEGER is
			-- Index of the line that contains the caret.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Em_lineindex,
				-1, 0)
		ensure
			positive_result: Result >= 0
		end

	current_line_number: INTEGER is
			-- Line number of the line that contains the caret.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Em_linefromchar, -1, 0)
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
			Result := cwin_send_message_result (item, Em_linelength,
				line_index (i), 0)
		ensure
			positive_result: Result >= 0
			result_ok: Result = line (i).count
		end

	line (i: INTEGER): STRING is
			-- `i'th line
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < line_count
		local
			a: ANY
		do
			!! Result.make (line_length (i))
			Result.fill_blank
			a := Result.to_c
			Result.head (cwin_send_message_result (item,
				Em_getline, i, cwel_pointer_to_integer ($a)))
		ensure
			result_exists: Result /= Void
			count_ok: Result.count = line_length (i)
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
			Result := cwin_send_message_result (item, Em_lineindex,
				i, 0)
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
			Result := cwin_send_message_result (item,
				Em_linefromchar, i, 0)
		ensure
			positive_result: Result >= 0
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Es_left +
				Es_autohscroll + Es_autovscroll +
				Ws_vscroll + Ws_hscroll + Es_multiline
		end

end -- class WEL_MULTIPLE_LINE_EDIT

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
