indexing

	description: "Classname finder skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class YACC_CLASSNAME_FINDER

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create a new classname finder.
		do
		end

feature -- Access

	classname: STRING
			-- Last classname found

feature -- Parsing

	parse (a_file: FILE) is
			-- Parse `a_file' and set `classname' if `a_file'
			-- contains an Eiffel class text. Void otherwise.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			classname := c_clname (a_file.file_pointer)
		rescue
			classname := Void
		end

feature {NONE} -- Externals

	c_clname (file_pointer: POINTER): STRING is
			-- Class in file `file_pointer'.
		external
			"C"
		end

end -- class YACC_CLASSNAME_FINDER_SKELETON


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
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
