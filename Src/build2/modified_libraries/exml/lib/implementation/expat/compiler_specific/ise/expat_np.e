deferred class
   EXPAT_NP
inherit
   EXPAT_ERROR_CODES
   EXPAT_EXTERNALS
      rename
	 get_base as get_base_expat,
	 set_base as set_base_expat
      end
   EXML_EXTERNALS
   C_STRING_HELPER_NP
feature {NONE} -- externals
   initialize is
      do
	 register_all_eiffel_callbacks
      end
   -- Since ISE Eiffel has got a garbage collector that is able to move objects
   -- we need to tell it that expat parser objects must not move.
   -- This way, we make sure the external C code can call the correct Eiffel code


   exml_release_object (object: POINTER) is
      external
	 "C"
      end

   exml_adopt_object (object: like Current): POINTER is
      external
	 "C"
      end

   set_eiffel_object_as_user_data is
	 -- expat hooks receive a user defineble integer as
	 -- additional parameter. we set this to the Eiffel
	 -- parser object.
      do
	 set_user_data (item, exml_adopt_object (Current))
      end



   set_base (a_base: STRING) iS
	 -- sets the base to be used for resolving URIs in system identifiers
	 -- in declarations.
      local
	 a: ANY
      do
	 a := a_base.area
	 -- TODO: Check if string ends with a NULL char
	 -- if it does not, append one!
	 set_base_expat (item, $a)
      end

   get_base: STRING is
	 -- returns the base
      do
	 !! Result.make (0)
	 Result.from_c (get_base_expat (item))
      end

   parse_string_imp  (data: STRING): INTEGER is
	 -- function has side effect !!!
      local
	 a: ANY
      do
	 a := data.area
	 Result := parse (item, $a, data.count, 0)
      end
   
   parse_buffer_imp  (data: SPECIAL [CHARACTER]): INTEGER is
	 -- function has side effect !!!
      do
	 Result := parse (item, $data, data.count, 0)
      end
   
   item: POINTER
	 -- points to expat parser c-handle


feature {NONE} -- In ISE Eiffel we need to tell the C-glue-code (exml-clib) the addresses of
   -- our Eiffel callback functions

   register_all_eiffel_callbacks is
      once
	 exml_set_on_start_tag_procedure_address ($on_start_tag_procedure)
	 exml_set_on_end_tag_procedure_address ($on_end_tag_procedure)
	 exml_set_on_content_procedure_address ($on_content_procedure)
	 exml_set_on_processing_instruction_procedure_address ($on_processing_instruction_procedure)
	 exml_set_on_default_procedure_address ($on_default_procedure)
	 exml_set_on_unparsed_entity_declaration_procedure_address ($on_unparsed_entity_declaration_procedure)
	 exml_set_on_notation_declaration_procedure_address ($on_notation_declaration_procedure)
	 exml_set_on_external_entity_reference_procedure_address ($on_external_entity_reference_procedure)
	 exml_set_on_comment_procedure_address ($on_comment_procedure)
	 exml_set_on_start_namespace_decl_procedure_address ($on_start_namespace_decl_procedure)	 
	 exml_set_on_end_namespace_decl_procedure_address ($on_end_namespace_decl_procedure)
      end

   register_external_entity_reference_hook is
      do
	 exml_set_on_external_entity_reference_procedure_address ($on_external_entity_reference_procedure)
      end

   register_unknown_encoding_hook is
      do
	 exml_set_on_unknown_encoding_procedure_address ($on_unknown_encoding_procedure)
      end

feature {NONE} -- Callbacks
    on_start_tag_procedure (tag_name_ptr, attribute_specifications_ptr: POINTER) is
      require
	 tag_name_ptr_not_void: tag_name_ptr /= Void
	 attribute_specifications_ptr_not_void: attribute_specifications_ptr /= Void
      deferred
      end

    on_end_tag_procedure (tag_name_ptr: POINTER) is
      deferred
      end

    on_start_namespace_decl_procedure (prefix_ptr, uri_ptr: POINTER) is
      require
	 prefix_ptr_not_void: prefix_ptr /= Void
	 uri_ptr_not_void: uri_ptr /= Void
      deferred
      end

    on_end_namespace_decl_procedure (prefix_ptr: POINTER) is
      deferred
      end

    on_content_procedure (content_ptr: POINTER; len: INTEGER) is
      deferred
      end

    on_processing_instruction_procedure (target, data: POINTER) is
      deferred
      end

    on_default_procedure (data_ptr: POINTER; len: INTEGER) is
      deferred
      end

    on_unparsed_entity_declaration_procedure (enitity_name, base, system_id, public_id, notation_name: POINTER) is
      deferred
      end

   on_notation_declaration_procedure (notation_name, base, system_id, public_id: POINTER) is
      deferred
      end

    on_external_entity_reference_procedure (open_entity_name, base, system_id, public_id: POINTER): INTEGER is
      deferred
      end

    on_unknown_encoding_procedure (name, info: POINTER): INTEGER is
      deferred
      end

   on_comment_procedure (data: POINTER) is
	 -- data is a 0 terminated C string
      deferred
      end



invariant
	item_not_void: item /= Void
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
