indexing

	description: "Classname finder skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class CLASSNAME_FINDER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			fatal_error
		end

	SHARED_PARSER_FILE_BUFFER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new classname finder.
		do
			make_with_buffer (Empty_buffer)
		end

feature -- Access

	classname: STRING
			-- Last classname found

feature -- Parsing

	parse (a_file: IO_MEDIUM) is
			-- Parse `a_file' and set `classname' if `a_file'
			-- contains an Eiffel class text. Void otherwise.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			classname := Void
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			read_token
			reset
		rescue
			classname := Void
			reset
		end

feature -- Error handling

	fatal_error (a_message: STRING) is
			-- A fatal error occurred.
		do
		end

feature {NONE} -- Constants

	TE_ID: INTEGER is 300

end -- class CLASSNAME_FINDER_SKELETON


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
