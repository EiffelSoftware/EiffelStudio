indexing
	description: "This class allows to set a buffer into a rich edit %
		%control. Used internally by WEL."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested streams are not supported."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_BUFFER_LOADER

inherit
	WEL_RICH_EDIT_STREAM_IN
		rename
			make as rich_edit_stream_in_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Set `a_string' to the rich edit control.
		require
			a_string_not_void: a_string /= Void
		do
			rich_edit_stream_in_make
			string := a_string
			last_position := 1
		ensure
			string_set: string = a_string
		end

feature {NONE} -- Implementation

	last_position: INTEGER
			-- Last position of `string'

	string: STRING
			-- String to set in the rich edit control

	read_buffer (length: INTEGER) is
			-- Set to buffer a substring of `string'.
		do
			if last_position > string.count then
				buffer := ""
			else
				buffer := string.substring (last_position,
					(last_position + length - 1).min (string.count))
				last_position := last_position + length
			end
		end

invariant
	string_not_void: string /= Void
	positive_last_position: last_position > 0

end -- class WEL_RICH_EDIT_BUFFER_LOADER


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

