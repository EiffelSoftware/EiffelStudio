class
   EXML_EXTERNALS
feature {NONE} -- externals

   exml_register_start_end_tag_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   exml_register_start_end_namespace_decl_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   exml_register_content_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   exml_register_processing_instruction_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   exml_register_default_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   exml_register_unparsed_entity_declaration_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   exml_register_notation_declaration_hook (parser_handle: POINTER) is
      external
	 "C"
      end

   exml_register_external_entity_reference_hook (parser_handle: POINTER) is
      external
	 "C"
      end

   exml_register_unknown_encoding (parser_handle: POINTER) is
      external
	 "C"
      end
   
   exml_register_comment_hook (parser_handle: POINTER) is
      external
	 "C"
      end
   
end -- class EXML_EXTERNALS
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

