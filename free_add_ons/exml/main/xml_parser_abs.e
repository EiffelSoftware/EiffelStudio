indexing
	description: "Class for parsing XML documents"
	status: "See notice at end of class."
	author: "Andreas Leitner"

deferred class
	XML_PARSER_ABS
inherit
	EXPAT_ERROR_CODES
	EXPAT_EXTERNALS
		rename
			get_base as get_base_expat,
			set_base as set_base_expat
		end
	EXML_EXTERNALS

feature {NONE}  -- Initialisation
	make is
		do
			item := parser_create (default_pointer)

			exml_register_start_end_tag_hook (item)
			exml_register_content_hook (item)
			exml_register_processing_instruction_hook (item)
		--	exml_register_default_hook (item)
				-- registering the default hook, prevents the parser
				-- from expanding internal  entity-references
			exml_register_unparsed_entity_declaration_hook (item)
			exml_register_notation_declaration_hook (item)
			exml_register_external_entity_reference_hook (item)
			exml_register_unkown_encoding (item)

			set_eiffel_object_as_user_data
		end


feature {ANY} -- operations

	parse_string (data: STRING) is
			-- Parse 'data'.
			-- Note: You can call parse_string multiple times
			-- and give the parse the document in parts only.
			-- You have to call 'set_end_of_file' after the
			-- last call to 'parse_string' in every case.
		require
			data_not_void: data /= Void
		do
			if
				parse_string_imp (data) = 0
					-- function call with side effect !!!!
			then
				last_error := get_error_code (item)	
			end
		end

	set_end_of_file is
			-- Call this routine to
			-- tell the parser that the document has been
			-- completly parsed and no input is comming anymore.
		local
			int_result: INTEGER
			a: ANY
			s: STRING
		do
			int_result := parse (item, default_pointer, 0, 1)

			if
				int_result = 0
			then
				last_error := get_error_code (item)	
			end
		end

feature -- Access
	last_error: INTEGER
			-- see XML_PARSER_ERROR_CODES

	is_correct: BOOLEAN is
			-- returns False if an error was detected
			-- by the parser
		do
			Result := last_error = Xml_error_none
		ensure
			error_flag_set: (Result = True) implies (last_error = Xml_error_none)
			error_flag_set2: (Result = False) implies (last_error /= Xml_error_none)
		end


	last_error_description: STRING is deferred end
			-- gives a text that explain 'last_error'

	last_error_extended_description: STRING is
			-- extended description of 'last_error'
		do
			!! Result.make (0)
			Result.append (last_error_description)
			Result.append ("(")
			Result.append (last_error.out)
			Result.append (") at ln: ")
			Result.append (last_line_number.out)
			Result.append (", cl: ")
			Result.append (last_column_number.out)
		end

	last_line_number: INTEGER is deferred end
			-- current line number (works in callback too)
	last_column_number: INTEGER is deferred end
			-- current column number (works in callback too)
	last_byte_index: INTEGER is deferred end
			-- current byte index (works in callback too)

	set_base (a_base: STRING) is deferred end
			-- sets the base to be used for resolving URIs in system identifiers
			-- in declarations. 
	get_base: STRING is deferred end
			-- returns the base

feature {NONE} -- Redefinable Callbacks
	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		require
			start_tag_not_void: start_tag /= Void
		do
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data
		require
			content_not_void: content /= Void
		do
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		require
			end_tag_not_void: end_tag /= Void
		do
		end
	on_default (data: CHARACTER_ARRAY) is
		-- this feature is called for any character in the XML
		-- document for which there is no applicable handler
	
		require
			data_not_void: data /= Void
		do
		end

feature {NONE} -- Implementation

	pass_to_default_handler is
			-- can be called within a start, end, processing instruction,
			-- and content handler to pass the current markup to the default handler
			-- TODO: work out dbc to ensure it is called only from the
			-- good features!
		do
			pass_to_defaul_handler (item)
		end
	
feature {NONE} -- (low level) frozen callbacks (called from eXML clib)

	frozen on_start_tag_procedure (tag_name_ptr, attribute_specifications_ptr: POINTER) is
		require
			tag_name_ptr_not_void: tag_name_ptr /= Void
			attribute_specifications_ptr_not_void: attribute_specifications_ptr /= Void
		local
			start_tag: XML_START_TAG
		do
			!! start_tag.make_from_c (tag_name_ptr, attribute_specifications_ptr)
			on_start_tag (start_tag)
		end

	frozen on_end_tag_procedure (tag_name_ptr: POINTER) is
		local
			end_tag: XML_END_TAG
		do
			!! end_tag.make_from_c (tag_name_ptr)
			on_end_tag (end_tag)
		end

	frozen on_content_procedure (content_ptr: POINTER; len: INTEGER) is
		local
			content: XML_CONTENT
		do
			!! content.make_from_c (content_ptr, len)
			on_content (content)
		end

	frozen on_processing_instruction_procedure (target, data: POINTER) is
		do
			print ("found processing_instruction (HELP!!!)%N")
				-- TODO: Don't really know yet. If you know please let me know too (:
		end

	frozen on_default_procedure_address (data_ptr: POINTER; len: INTEGER) is
		local
			data: CHARACTER_ARRAY
		do
			!! data.make_from_c (data_ptr, len)
			on_default (data)
		end

	frozen on_unparsed_entity_declaration_procedure (enitity_name, base, system_id, public_id, notation_name: POINTER) is
		do
			print ("found unparsed_entity_declaration (HELP!!!)%N")
				-- TODO: Don't really know yet. If you know please let me know too (:
	
		end
	frozen on_notation_declaration_procedure (notation_name, base, system_id, public_id: POINTER) is
		do
			print ("found notation_declaration (HELP!!!)%N")
				-- TODO: Don't really know yet. If you know please let me know too (:
		end

	frozen on_external_entity_reference_procedure (open_entity_name, base, system_id, public_id: POINTER): INTEGER is
			-- return zero if parsing of external entity was not successfull
			-- 'base' is a char* pointing to data previously set with 'set_base'
		do
			print ("found external_entity_reference (HELP!!!)%N")
			Result := 1
				-- TODO: Well,, I guess I need to start another parser here - always?
				-- maybe this should be configurable
				-- anyway there needs to be some expat stuff encapsulated first (XML_ExternalEntityParserCreate)
				-- this function is used to create a parse, that parses those external references.
				-- I assume this will be a heir from XML_PARSER.
		end

	frozen on_unkown_encoding_procedure (name, info: POINTER): INTEGER is
		do
			print ("found unkown_encoding (HELP!!!)%N")
				-- TODO: Don't really know yet. If you know please let me know too (:
		end

feature {NONE}

	parse_string_imp  (data: STRING): INTEGER is
			-- function has side effect !!!
		require
			data_not_void: data /= Void
		deferred 
		end

	set_eiffel_object_as_user_data is deferred end
			-- expat hooks receive a user defineble integer as
			-- additional parameter. we set this to the Eiffel
			-- parser object.

	item: POINTER
		-- the expat parser handle

	

invariant
	item_not_void: item /= Void
end	-- XML_PARSER_ABS
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