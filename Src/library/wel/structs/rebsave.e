indexing
	description: "This class allows to get the contents of a rich edit %
		%control. Used internally by WEL."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested streams are not supported."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_BUFFER_SAVER

inherit
	WEL_RICH_EDIT_STREAM_OUT
		rename
			make as rich_edit_stream_out_make
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create `text'.
		do
			rich_edit_stream_out_make
			!! text.make (0)
		end

feature -- Access

	text: STRING
			-- Contents of the rich edit control

feature {NONE} -- Implementation

	write_buffer (buffer: STRING) is
			-- Append `buffer' in `text'.
		do
			text.append (buffer)
		ensure then
			valid_count: text.count = old text.count + buffer.count
		end

invariant
	text_not_void: text /= Void

end -- class WEL_RICH_EDIT_BUFFER_SAVER

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
