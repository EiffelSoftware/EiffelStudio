indexing
	description:	"abstract definition of c-functions in the exml-clib."
	note:				"the implementation may be slightly different on%
						%different Eiffel-compilers"
deferred class
	EXML_EXTERNALS_ABS
feature {NONE} -- externals

	exml_register_start_end_tag_hook (parser_handle: POINTER) is deferred end		
	exml_register_content_hook (parser_handle: POINTER) is deferred end
	exml_register_processing_instruction_hook (parser_handle: POINTER) is deferred end
	exml_register_default_hook (parser_handle: POINTER) is deferred end
			-- if this hook is registered, internal entity references
			-- are not expanded !!!
	exml_register_unparsed_entity_declaration_hook (parser_handle: POINTER) is deferred end
	exml_register_notation_declaration_hook (parser_handle: POINTER) is deferred end
	exml_register_external_entity_reference_hook (parser_handle: POINTER) is deferred end
	exml_register_unkown_encoding (parser_handle: POINTER) is deferred end
end -- class EXML_EXTERNALS_ABS
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
