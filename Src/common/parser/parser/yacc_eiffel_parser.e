indexing

	description: "Eiffel parsers implemented in C with yacc"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class YACC_EIFFEL_PARSER

inherit

	MEMORY
		export {NONE} all end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel parser.
		do
		end

feature -- Parsing

	parse (a_file: FILE) is
			-- Parser Eiffel class text from `a_file'.
			-- Make result available in `root_node'.
			-- An exception is raised if a syntax error is found.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			class_file_name: STRING
		do
			class_file_name := a_file.name
			collection_off
			root_node := c_parse (a_file.file_pointer, $class_file_name)
			collection_on
		rescue
			root_node := Void
			collection_on
		end

feature -- Access

	root_node: CLASS_AS
			-- Root node of AST

feature -- Removal

	wipe_out is
			-- Release unused objects to garbage collector.
		do
			root_node := Void
		ensure
			root_node_void: root_node = Void
		end

feature {NONE} -- External

	c_parse (f: POINTER; s: POINTER): CLASS_AS is
		external
			"C"
		end

end -- class YACC_EIFFEL_PARSER


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
