class
   EXPAT_NP
inherit
   EXML_EXTERNALS
   EXPAT_EXTERNALS
   C_STRING_HELPER_NP

feature {NONE} -- externals
   initialize is
      do
	 -- In SmallEiffel we do not need to initialize the 
	 -- callbacks. This is done statically via the cevil.se file.
      end
   
   set_eiffel_object_as_user_data is
	 -- expat hooks receive a user defineble integer as
	 -- additional parameter. we set this to the Eiffel
	 -- parser object.
      do
	 set_user_data (item, Current.to_pointer)
      end
   
   
   
   set_base (a_base: STRING) iS
	 -- sets the base to be used for resolving URIs in system identifiers
	 -- in declarations.
      do
	 set_base_expat (item, a_base.to_external)
      end

   get_base: STRING is
	 -- returns the base
      do
	 create_copy_of_string_from_zstring (get_base (item))
	 Result := last_string
	 --TODO: make sure the C-string does not need to be freed!
      end   
   
   parse_string_imp, parse_buffer_imp (data: STRING): INTEGER is
	 -- function has side effect !!!
      require
	 data_not_void: data /= Void
      do
	 -- TODO: Should I copy the string first?
	 Result := parse (item, data.to_external, data.count, 0)
      end
   
   item: POINTER
	 -- points to expat parser c-handle
   
   
feature {NONE} -- In ISE Eiffel we need to tell the C-glue-code (exml-clib) the addresses of
   -- our Eiffel callback functions

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
      deferred
      end
   
   
   
invariant
	item_not_void: item /= Void


end -- class EXPAT_NP

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
