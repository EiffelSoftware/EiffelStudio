class
	EXPAT_ERROR_CODES
inherit
	EXPAT_ERROR_CODES_ABS
feature

   Xml_error_none  : INTEGER is
		do
			Result := c_xml_error_none
		end
   Xml_error_no_memory  : INTEGER is
		do
			Result := c_xml_error_no_memory
		end
   Xml_error_syntax  : INTEGER is
		do
			Result := c_xml_error_syntax
		end
   Xml_error_no_elements  : INTEGER is
		do
			Result := c_xml_error_no_elements
		end
   Xml_error_invalid_token  : INTEGER is
		do
			Result := c_xml_error_invalid_token
		end
   Xml_error_unclosed_token  : INTEGER is
		do
			Result := c_xml_error_unclosed_token
		end
   Xml_error_partial_char  : INTEGER is
		do
			Result := c_xml_error_partial_char
		end
   Xml_error_tag_mismatch  : INTEGER is
		do
			Result := c_xml_error_tag_mismatch
		end
   Xml_error_duplicate_attribute  : INTEGER is
		do
			Result := c_xml_error_duplicate_attribute
		end
   Xml_error_junk_after_doc_element  : INTEGER is
		do
			Result := c_xml_error_junk_after_doc_element
		end
   Xml_error_param_entity_ref  : INTEGER is
		do
			Result := c_xml_error_param_entity_ref
		end
   Xml_error_undefined_entity  : INTEGER is
		do
			Result := c_xml_error_undefined_entity
		end
   Xml_error_recursive_entity_ref  : INTEGER is
		do
			Result := c_xml_error_recursive_entity_ref
		end
   Xml_error_async_entity  : INTEGER is
		do
			Result := c_xml_error_async_entity
		end
   Xml_error_bad_char_ref  : INTEGER is
		do
			Result := c_xml_error_bad_char_ref
		end
   Xml_error_binary_entity_ref  : INTEGER is
		do
			Result := c_xml_error_binary_entity_ref
		end
   Xml_error_attribute_external_entity_ref  : INTEGER is
		do
			Result := c_xml_error_attribute_external_entity_ref
		end
   Xml_error_misplaced_xml_pi  : INTEGER is
		do
			Result := c_xml_error_misplaced_xml_pi
		end
   Xml_error_unknown_encoding  : INTEGER is
		do
			Result := c_xml_error_unknown_encoding
		end
   Xml_error_incorrect_encoding  : INTEGER is
		do
			Result := c_xml_error_incorrect_encoding
		end
   Xml_error_unclosed_cdata_section  : INTEGER is
		do
			Result := c_xml_error_unclosed_cdata_section
		end
   Xml_error_external_entity_handling  : INTEGER is
		do
			Result := c_xml_error_external_entity_handling
		end


feature {NONE} -- externals
	c_xml_error_none: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_NONE"
	end
	c_xml_error_no_memory: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_NO_MEMORY"
	end
	c_xml_error_syntax: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_SYNTAX"
	end
	c_xml_error_no_elements: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_NO_ELEMENTS"
	end
	c_xml_error_invalid_token: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_INVALID_TOKEN"
	end
	c_xml_error_unclosed_token: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_UNCLOSED_TOKEN"
	end
	c_xml_error_partial_char: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_PARTIAL_CHAR"
	end
	c_xml_error_tag_mismatch: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_TAG_MISMATCH"
	end
	c_xml_error_duplicate_attribute: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_DUPLICATE_ATTRIBUTE"
	end
	c_xml_error_junk_after_doc_element: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_JUNK_AFTER_DOC_ELEMENT"
	end
	c_xml_error_param_entity_ref: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_PARAM_ENTITY_REF"
	end
	c_xml_error_undefined_entity: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_UNDEFINED_ENTITY"
	end
	c_xml_error_recursive_entity_ref: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_RECURSIVE_ENTITY_REF"
	end
	c_xml_error_async_entity: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_ASYNC_ENTITY"
	end
	c_xml_error_bad_char_ref: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_BAD_CHAR_REF"
	end
	c_xml_error_binary_entity_ref: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_BINARY_ENTITY_REF"
	end
	c_xml_error_attribute_external_entity_ref: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF"
	end
	c_xml_error_misplaced_xml_pi: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_MISPLACED_XML_PI"
	end
	c_xml_error_unknown_encoding: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_UNKNOWN_ENCODING"
	end
	c_xml_error_incorrect_encoding: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_INCORRECT_ENCODING"
	end
	c_xml_error_unclosed_cdata_section: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_UNCLOSED_CDATA_SECTION"
	end
	c_xml_error_external_entity_handling: INTEGER is
		external
			"C [macro %"xmlparse.h%"]"
		alias
			"XML_ERROR_EXTERNAL_ENTITY_HANDLING"
	end
end
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