indexing
	description: "Defines the general notions of a stream in for the rich %
		%edit control."
	note: "Do not use more than one instance of this class at the same %
		%time. Nested streams are not supported."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_RICH_EDIT_STREAM_IN

inherit
	WEL_RICH_EDIT_STREAM
		rename
			make as rich_edit_stream_make
		end

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables.
		do
			rich_edit_stream_make
			cwel_set_editstream_procedure_address ($internal_callback)
			cwel_set_editstream_object (Current)
			cwel_set_editstream_in (True)
		end

feature -- Access

	buffer: STRING
			-- Buffer to set in `read_buffer'.

feature -- Basic operations

	read_buffer (length: INTEGER) is
			-- Set to `buffer' a string of `length' (or
			-- less) characters.
		require
			positive_length: length >= 0
		deferred
		ensure
			buffer_not_void: buffer /= Void
			valid_buffer_length: buffer.count <= length
		end

feature {NONE} -- Implementation

	internal_callback (a_buffer: POINTER; a_length: INTEGER): INTEGER is
			-- Set to `a_buffer' a string of `a_length' characters.
		local
			a_wel_string: WEL_STRING
		do
			stream_result := 0
			read_buffer (a_length)
			!! a_wel_string.make (buffer)
			cwel_set_editstream_buffer (a_wel_string.item)
			cwel_set_editstream_buffer_size (buffer.count)
			Result := stream_result
		end

end -- class WEL_RICH_EDIT_STREAM_IN

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

