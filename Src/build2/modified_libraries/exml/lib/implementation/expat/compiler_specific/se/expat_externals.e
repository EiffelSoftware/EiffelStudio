class
   EXPAT_EXTERNALS
feature {NONE} -- externals from EXPAT clib
   parser_create (encoding: POINTER): POINTER is
	 -- creates a parser and returns it's handler
      external
	 "C"
      alias
	 "XML_ParserCreate"
      end
   parser_create_ns (encoding: POINTER; namespace_seperator: CHARACTER): POINTER is
	 -- creates a parser and returns it's handler
      external
	 "C"
      alias
	 "XML_ParserCreateNS"
      end
   parser_free (parser_handle: POINTER) is
	 -- frees the parser specified with the handle 'parser'
      external
	 "C"
      alias
	 "XML_ParserFree"
      end

   use_parser_as_handler_arg (parser_handle: POINTER) is
	 -- forces parser to use its own handle as first parameter for it's callback functions
      external
	 "C"
      alias
	 "XML_UseParserAsHandlerArg"
      end
   set_user_data (parser_handle, user_data: POINTER) is
      external
	 "C"
      alias
	 "XML_SetUserData"
      end

   get_user_data (parser_handle: POINTER): POINTER is
      external
	 "C"
      alias
	 "XML_GetUserData"
      end

   parse (parser_handle, data: POINTER; len, is_final: INTEGER): INTEGER is
      external
	 "C"
      alias
	 "XML_Parse"
      end

   get_error_code (parser_handle: POINTER): INTEGER is
      external
	 "C"
      alias
	 "XML_GetErrorCode"
      end

   get_current_line_number (parser_handle: POINTER): INTEGER is
      external
	 "C"
      alias
	 "XML_GetCurrentLineNumber"
      end

   get_current_column_number (parser_handle: POINTER): INTEGER is
      external
	 "C"
      alias
	 "XML_GetCurrentColumnNumber"
      end

   get_current_byte_index (parser_handle: POINTER): INTEGER is
      external
	 "C"
      alias
	 "XML_GetCurrentByteIndex"
      end

   error_string (code: INTEGER): POINTER is
      external
	 "C"
      alias
	 "XML_ErrorString"
      end

   pass_to_defaul_handler (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "XML_DefaultCurrent"
      end

   set_base (parser_handle, base: POINTER) is
      external
	 "C"
      alias
	 "XML_SetBase"
      end

   get_base (parser_handle: POINTER): POINTER is
      external
	 "C"
      alias
	 "XML_GetBase"
      end

end -- class EXPAT_EXTERNALS
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
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
