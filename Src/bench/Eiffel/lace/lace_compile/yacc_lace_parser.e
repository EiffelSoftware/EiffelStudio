indexing

	description: "Lace parsers implemented in C with yacc"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class YACC_LACE_PARSER

inherit

	LACE_PARSER_ROUTINES

	MEMORY
		export {NONE} all end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create a new Lace parser.
		do
		end

feature {NONE} -- Implementation

	parse_lace (a_file: FILE) is
			-- Call lace parser with a source file.
		local
			file_name: STRING
		do
			file_name := a_file.name
			collection_off
			ast := lp_file (a_file.file_pointer, $file_name)
			collection_on
		rescue
			ast := Void
			collection_on
		end

feature {NONE} -- Externals

	lp_file (file: POINTER; fn: POINTER): ACE_SD is
			-- Call lace parser with a source file.
		external
			"C"
		end

end -- class YACC_LACE_PARSER


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
