indexing
	description:"abstract definition of expat-c-function"
	note:			"the implementation may be slightly different on%
					%different Eiffel-compilers"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"
deferred class
	EXPAT_EXTERNALS_ABS
feature {NONE} -- externals from EXPAT clib
	parser_create (encoding: POINTER): POINTER is deferred end
			-- creates a parser and returns it's handler
	parser_free (parser_handle: POINTER) is deferred end
			-- frees the parser specified with the handle 'parser'
	use_parser_as_handler_arg (parser_handle: POINTER) is deferred end
			-- forces parser to use its own handle as first parameter for it's callback functions
	set_user_data (parser_handle, user_data: POINTER) is deferred end
	get_user_data (parser_handle: POINTER): POINTER is deferred end
	parse (parser_handle, data: POINTER; len, is_final: INTEGER): INTEGER is deferred end
	get_error_code (parser_handle: POINTER): INTEGER is deferred end
	get_current_line_number (parser_handle: POINTER): INTEGER is deferred end
	get_current_column_number (parser_handle: POINTER): INTEGER is deferred end
	get_current_byte_index (parser_handle: POINTER): INTEGER is deferred end
	error_string (code: INTEGER): POINTER is deferred end
	pass_to_defaul_handler (parser_handle: POINTER) is deferred end
	set_base (parser_handle, base: POINTER) is deferred end
	get_base (parser_handle: POINTER): POINTER is deferred end
end -- class EXPAT_EXTERNALS_ABS
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner
 and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------