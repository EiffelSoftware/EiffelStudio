indexing

	description: "Shared parser file buffer"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_PARSER_FILE_BUFFER

feature -- Access

	File_buffer: YY_FILE_BUFFER is
			-- Parser input file buffer
		once
			!! Result.make_with_size (io.input, 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

end -- class SHARED_PARSER_FILE_BUFFER


--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
