class
	XML_PARSER
inherit
	XML_PARSER_ABS
	C_STRING_HELPER
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end
creation
	make
feature

	set_base_imp (a_base: STRING) is
			-- sets the base to be used for resolving URIs in system identifiers
			-- in declarations. 
		do
			set_base (item, a_base.to_external)
		end

	get_base_imp: STRING is
			-- returns the base
		do
			create_copy_of_string_from_zstring (get_base (item))
			Result := last_string
				--TODO: make sure the C-string does not need to be freed!
		end

	parse_string_imp  (data: STRING): INTEGER is
			-- function has side effect !!!
		require
			data_not_void: data /= Void
		do
				-- TODO: Should I copy the string first?
			Result := parse (item, data.to_external, data.count, 0)
		end

	set_eiffel_object_as_user_data is
			-- expat hooks receive a user defineble integer as
			-- additional parameter. we set this to the Eiffel
			-- parser object.
		do
			set_user_data (item, Current.to_pointer)
		end


	last_error_description: STRING is 
		do
			create_copy_of_string_from_zstring (error_string (last_error))
			Result := last_string
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
	dispose is
		do
			parser_free (item)
		end

end -- class XML_PARSER
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