indexing
	description: "This class allows to load a file into a rich edit control."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested streams are not supported."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_FILE_LOADER

inherit
	WEL_RICH_EDIT_STREAM_IN
		rename
			make as rich_edit_stream_in_make
		redefine
			finish_action
		end

creation
	make

feature {NONE} -- Initialization

	make (a_file: RAW_FILE) is
			-- Load `a_file' in the rich edit control.
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_is_open_read: a_file.is_open_read
		do
			rich_edit_stream_in_make
			file := a_file
		ensure
			file_set: file = a_file
		end

feature {NONE} -- Implementation

	file: RAW_FILE
			-- File to load

	read_buffer (length: INTEGER) is
			-- Read from `file' `length' characters.
		do
			if file.readable then
				file.read_stream (length)
				buffer := file.last_string
			else
				buffer := ""
			end
		end

	finish_action is
			-- Close `file'.
		do
			file.close
		ensure then
			file_closed: file.is_closed
		end

invariant
	file_not_void: file /= Void

end -- class WEL_RICH_EDIT_FILE_LOADER


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

