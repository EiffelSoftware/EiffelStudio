class
   EXML_EXTERNALS
feature {NONE}
   exml_register_unknown_encoding (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_unknown_encoding"
      end
   exml_register_external_entity_reference_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_external_entity_reference_hook"
      end
   exml_register_notation_declaration_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_notation_declaration_hook"
      end
   exml_register_start_end_tag_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_start_end_tag_hook"
      end
   exml_register_start_end_namespace_decl_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_start_end_namespace_decl_hook"
      end
   exml_register_content_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_content_hook"
      end
   exml_register_processing_instruction_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_processing_instruction_hook"
      end
   exml_register_default_hook (parser_handle: POINTER) is
	 -- if this hook is registered internal entity references
	 -- are not expanded !!!
      external
	 "C"
      alias
	 "exml_register_default_hook"
      end
   exml_register_unparsed_entity_declaration_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_unparsed_entity_declaration_hook"
      end
   exml_register_comment_hook (parser_handle: POINTER) is
      external
	 "C"
      alias
	 "exml_register_comment_hook"
      end


   exml_set_on_start_tag_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_start_tag_procedure_address"
      end

   exml_set_on_end_tag_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_end_tag_procedure_address"
      end

   exml_set_on_start_namespace_decl_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_start_namespace_decl_procedure_address"
      end

   exml_set_on_end_namespace_decl_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_end_namespace_decl_procedure_address"
      end

   exml_set_on_content_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_content_procedure_address"
      end

   exml_set_on_processing_instruction_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_processing_instruction_procedure_address"
      end

   exml_set_on_default_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_default_procedure_address"
      end

   exml_set_on_unparsed_entity_declaration_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_unparsed_entity_declaration_procedure_address"
      end

   exml_set_on_notation_declaration_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_notation_declaration_procedure_address"
      end

   exml_set_on_external_entity_reference_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_external_entity_reference_procedure_address"
      end

   exml_set_on_unknown_encoding_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_unknown_encoding_procedure_address"
      end

   exml_set_on_comment_procedure_address (address: POINTER) is
      external
	 "C"
      alias
	 "exml_set_on_comment_procedure_address"
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
