indexing
	description:"abstract definition of expat-error codes"
	note:			"the implementation may be slightly different on%
					%different Eiffel-compilers"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

deferred class 
	EXPAT_ERROR_CODES_ABS
feature -- external C functions

   Xml_error_none  : INTEGER is deferred end
   Xml_error_no_memory  : INTEGER is deferred end
   Xml_error_syntax  : INTEGER is deferred end
   Xml_error_no_elements  : INTEGER is deferred end
   Xml_error_invalid_token  : INTEGER is deferred end
   Xml_error_unclosed_token  : INTEGER is deferred end
   Xml_error_partial_char  : INTEGER is deferred end
   Xml_error_tag_mismatch  : INTEGER is deferred end
   Xml_error_duplicate_attribute  : INTEGER is deferred end
   Xml_error_junk_after_doc_element  : INTEGER is deferred end
   Xml_error_param_entity_ref  : INTEGER is deferred end
   Xml_error_undefined_entity  : INTEGER is deferred end
   Xml_error_recursive_entity_ref  : INTEGER is deferred end 
   Xml_error_async_entity  : INTEGER is deferred end
   Xml_error_bad_char_ref  : INTEGER is deferred end
   Xml_error_binary_entity_ref  : INTEGER is deferred end
   Xml_error_attribute_external_entity_ref  : INTEGER is deferred end
   Xml_error_misplaced_Xml_pi  : INTEGER is deferred end
   Xml_error_unknown_encoding  : INTEGER is deferred end
   Xml_error_incorrect_encoding  : INTEGER is deferred end
   Xml_error_unclosed_cdata_section  : INTEGER is deferred end
   Xml_error_external_entity_handling  : INTEGER is deferred end
end -- class EXPAT_ERROR_CODES_ABS
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