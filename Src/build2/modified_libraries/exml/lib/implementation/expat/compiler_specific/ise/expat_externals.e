class
   EXPAT_EXTERNALS
feature
   parser_create (encoding: POINTER): POINTER is 
      do
	 Result := c_parser_create (encoding)
      end
   parser_create_ns (encoding: POINTER; namespace_seperator: CHARACTER): POINTER is 
      do
	 Result := c_parser_create_ns (encoding, namespace_seperator)
      end
   
   external_entity_parser_create (parser, context, encoding: POINTER): POINTER is 
      do
	 Result := c_external_entity_parser_create (parser, context, encoding)
      end
   
   parser_free (parser_handle: POINTER) is 
      do
	 c_parser_free (parser_handle)
      end
   use_parser_as_handler_arg (parser_handle: POINTER) is 
      do
	 c_use_parser_as_handler_arg (parser_handle)
      end
   set_user_data (parser_handle, user_data: POINTER) is 
      do
	 c_set_user_data (parser_handle, user_data)
      end
   get_user_data (parser_handle: POINTER): POINTER is 
      do
	 Result := c_get_user_data (parser_handle)
      end
   parse (parser_handle, data: POINTER; len, is_final: INTEGER): INTEGER is 
      do
	 Result := c_parse (parser_handle, data, len, is_final)
      end
   get_error_code (parser_handle: POINTER): INTEGER is 
      do
	 Result := c_get_error_code (parser_handle)
      end
   get_current_line_number (parser_handle: POINTER): INTEGER is 
      do
	 Result := c_get_current_line_number (parser_handle)
      end
   get_current_column_number (parser_handle: POINTER): INTEGER is 
      do
	 Result := c_get_current_column_number (parser_handle)
      end
   get_current_byte_index (parser_handle: POINTER): INTEGER is 
      do
	 Result := c_get_current_byte_index (parser_handle)
      end
   error_string (code: INTEGER): POINTER is 
      do
	 Result := c_error_string (code)
      end
   pass_to_defaul_handler (parser_handle: POINTER) is 
      do
	 c_pass_to_defaul_handler (parser_handle)
      end
   set_base (parser_handle, base: POINTER) is 
      do
	 c_set_base (parser_handle, base)
      end
   get_base (parser_handle: POINTER): POINTER is
      do
	 Result := c_get_base (parser_handle)
      end
	

feature {NONE} -- externals from EXPAT clib

   c_parser_create (encoding: POINTER): POINTER is
	 -- creates a parser and returns it's handler
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_ParserCreate"
      end
   c_parser_create_ns (encoding: POINTER; namespace_seperator: CHARACTER): POINTER is
	 -- creates a parser and returns it's handler
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_ParserCreateNS"
      end
   
   c_external_entity_parser_create (parser, context, encoding: POINTER): POINTER is
	 -- creates a parser and returns it's handler
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_ExternalEntityParserCreate"
      end
   c_parser_free (parser_handle: POINTER) is
	 -- frees the parser specified with the handle 'parser'
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_ParserFree"
      end

   c_use_parser_as_handler_arg (parser_handle: POINTER) is
	 -- forces parser to use its own handle as first parameter for it's callback functions
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_UseParserAsHandlerArg"
      end
   c_set_user_data (parser_handle, user_data: POINTER) is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_SetUserData"
      end

   c_get_user_data (parser_handle: POINTER): POINTER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_GetUserData"
      end

   c_parse (parser_handle, data: POINTER; len, is_final: INTEGER): INTEGER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_Parse"
      end

   c_get_error_code (parser_handle: POINTER): INTEGER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_GetErrorCode"
      end

   c_get_current_line_number (parser_handle: POINTER): INTEGER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_GetCurrentLineNumber"
      end

   c_get_current_column_number (parser_handle: POINTER): INTEGER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_GetCurrentColumnNumber"
      end

   c_get_current_byte_index (parser_handle: POINTER): INTEGER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_GetCurrentByteIndex"
      end

   c_error_string (code: INTEGER): POINTER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_ErrorString"
      end

   c_pass_to_defaul_handler (parser_handle: POINTER) is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_DefaultCurrent"
      end

   c_set_base (parser_handle, base: POINTER) is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_SetBase"
      end

   c_get_base (parser_handle: POINTER): POINTER is
      external
	 "C [macro %"exml_parser.h%"]"
      alias
	 "EXML_GetBase"
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
