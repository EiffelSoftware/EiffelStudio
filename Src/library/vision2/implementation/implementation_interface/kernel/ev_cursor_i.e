indexing
	description:
		"EiffelVision cursor, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CURSOR_I

inherit
	EV_ANY_I

feature {NONE} -- Initialization

	make is
			-- Create a cursor with the default appearance.
		deferred
		end

	make_by_code (code: INTEGER) is
			-- Create a cursor with the appearance corresponding
			-- to `value'. See class EV_CURSOR_CODE fo the code.
		deferred
		end

	make_by_filename (filename: STRING) is
			-- Create a cursor from the given file path
		require
			valid_filename: filename /= Void
			filename_exists: interface.file_exists (filename)
		deferred
		end

end -- class EV_CURSOR_I

--!----------------------------------------------------------------
--! EiffelVision Library: Example for the ISE EiffelVision library.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
