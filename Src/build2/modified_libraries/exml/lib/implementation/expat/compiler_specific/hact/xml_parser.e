class
	XML_PARSER
inherit
	XML_PARSER_ABS
		rename
			make as make_abs
		end
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end
creation
	make
feature {NONE}
	make is
		do
			make_abs
			register_all_eiffel_callback
		end
feature

	set_base (a_base: STRING) is
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

	last_error_description: STRING is
		do
			!! Result.make (0)
			Result.from_c (error_string (last_error))
		end

	last_line_number: INTEGER is
		do
			Result := get_current_line_number (item)
		end
	last_column_number: INTEGER is
		do
			Result := get_current_column_number (item)
		end
	last_byte_index: INTEGER is
		do
			Result := get_current_byte_index (item)
		end

feature {NONE}
	parse_string_imp  (data: STRING): INTEGER is
			-- function has side effect !!!
		local
			a: ANY
		do
			a := data.area
			Result := parse (item, $a, data.count, 0)
		end

	set_eiffel_object_as_user_data is
			-- expat hooks receive a user defineble integer as
			-- additional parameter. we set this to the Eiffel
			-- parser object.
		do
			set_user_data (item, exml_adopt_object (Current))
		end

	dispose is
		do
			exml_release_object (c_get_user_data (item))
			parser_free (item)
		end

feature {NONE} -- In ISE Eiffel we need to tell the C-glue-code (exml-clib) the addresses of
					-- our Eiffel callback functions

	register_all_eiffel_callback is
		once
			c_exml_set_on_start_tag_procedure_address ($on_start_tag_procedure)
			c_exml_set_on_end_tag_procedure_address ($on_end_tag_procedure)
			c_exml_set_on_content_procedure_address ($on_content_procedure)
			c_exml_set_on_processing_instruction_procedure_address ($on_processing_instruction_procedure)
			c_exml_set_on_default_procedure_address ($on_default_procedure_address)
			c_exml_set_on_unparsed_entity_declaration_procedure_address ($on_unparsed_entity_declaration_procedure)
			c_exml_set_on_notation_declaration_procedure_address ($on_notation_declaration_procedure)
			c_exml_set_on_external_entity_reference_procedure_address ($on_external_entity_reference_procedure)
		end

	register_external_entity_reference_hook is
		do
			c_exml_set_on_external_entity_reference_procedure_address ($on_external_entity_reference_procedure)
		end

	register_unkown_encoding_hook is
		do
			c_exml_set_on_unkown_encoding_procedure_address ($on_unkown_encoding_procedure)
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