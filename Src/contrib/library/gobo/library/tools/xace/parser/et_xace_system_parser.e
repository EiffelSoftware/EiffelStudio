note

	description:

		"Xace Eiffel system parsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2001-2009, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_XACE_SYSTEM_PARSER

inherit

	ET_XACE_SYSTEM_CONFIG_PARSER
		redefine
			parse_file,
			last_system, new_system
		end

	ET_SHARED_XACE_OPTION_NAMES
		export {NONE} all end

	UT_STRING_ROUTINES
		export {NONE} all end

create

	make, make_with_factory, make_with_variables,
	make_with_variables_and_factory, make_standard

feature -- Parsing

	parse_file (a_file: KI_CHARACTER_INPUT_STREAM)
			-- Parse Xace file `a_file'.
		local
			a_document: XM_DOCUMENT
			a_root_element: XM_ELEMENT
			a_position_table: XM_POSITION_TABLE
		do
			last_system := Void
			xml_parser.parse_from_stream (a_file)
			if xml_parser.is_correct then
				if not tree_pipe.error.has_error then
					a_document := tree_pipe.document
					a_root_element := a_document.root_element
					a_position_table := tree_pipe.tree.last_position_table
					if STRING_.same_string (a_root_element.name, uc_library) then
						xml_validator.validate_library_doc (a_document, a_position_table)
						if not xml_validator.has_error then
							xml_preprocessor.preprocess_element (a_root_element, a_position_table)
							a_root_element.set_name (uc_system)
							last_system := new_system (a_root_element, a_position_table)
							last_system.set_root_class_name ("NONE")
							a_root_element.set_name (uc_library)
							parsed_libraries.wipe_out
						end
					else
						xml_validator.validate_system_doc (a_document, a_position_table)
						if not xml_validator.has_error then
							xml_preprocessor.preprocess_element (a_root_element, a_position_table)
							last_system := new_system (a_root_element, a_position_table)
							parsed_libraries.wipe_out
						end
					end
				else
					error_handler.report_parser_error (tree_pipe.last_error)
				end
			else
				error_handler.report_parser_error (xml_parser.last_error_extended_description)
			end
		end

feature -- Access

	last_system: ET_XACE_SYSTEM
			-- Eiffel system being parsed

feature {NONE} -- Xace AST factory

	new_system (an_element: XM_ELEMENT; a_position_table: XM_POSITION_TABLE): ET_XACE_SYSTEM
			-- New Eiffel system build from `an_element'
		local
			l_error_handler: ET_ERROR_HANDLER
			l_factory: ET_AST_FACTORY
			l_externals: ET_XACE_EXTERNALS
			l_external_include_pathnames: DS_ARRAYED_LIST [STRING]
			l_external_library_pathnames: DS_ARRAYED_LIST [STRING]
			l_pathname: STRING
			l_cursor: DS_LINKED_LIST_CURSOR [STRING]
			l_options: ET_XACE_OPTIONS
			l_name_attribute: XM_ATTRIBUTE
		do
			l_name_attribute := an_element.attribute_by_name (uc_name)
			if l_name_attribute /= Void and then not l_name_attribute.value.is_empty then
				create Result.make (l_name_attribute.value)
			else
					-- The "name" attribute is not optional.
					-- The Xace file is not valid.
				create Result.make ("*unknown*")
			end
			l_factory := new_eiffel_ast_factory
			Result.set_ast_factory (l_factory)
			l_error_handler := new_eiffel_error_handler
			Result.set_error_handler (l_error_handler)
			fill_system (Result, an_element, a_position_table, Result)
			Result.mount_libraries
			create l_externals.make
			Result.merge_externals (l_externals)
			l_external_include_pathnames := Result.external_include_pathnames
			l_cursor := l_externals.c_compiler_options.new_cursor
			from l_cursor.start until l_cursor.after loop
				l_external_include_pathnames.force_last ("some123/fake432/path567 " + l_cursor.item)
				l_cursor.forth
			end
			l_cursor := l_externals.include_directories.new_cursor
			from l_cursor.start until l_cursor.after loop
				l_pathname := l_cursor.item
				l_pathname := replace_all_characters (l_pathname, '{', '(')
				l_pathname := replace_all_characters (l_pathname, '}', ')')
				l_external_include_pathnames.force_last (l_pathname)
				l_cursor.forth
			end
			l_external_library_pathnames := Result.external_library_pathnames
			l_cursor := l_externals.link_libraries.new_cursor
			from l_cursor.start until l_cursor.after loop
				l_pathname := l_cursor.item
				l_pathname := replace_all_characters (l_pathname, '{', '(')
				l_pathname := replace_all_characters (l_pathname, '}', ')')
				l_external_library_pathnames.force_last (l_pathname)
				l_cursor.forth
			end
			l_options := Result.options
			if l_options /= Void then
				Result.set_console_application_mode (l_options.console_application)
				Result.set_exception_trace_mode (l_options.exception_trace)
				Result.set_trace_mode (l_options.trace)
				Result.set_use_boehm_gc (STRING_.same_string (l_options.garbage_collector, options.boehm_value))
			else
				Result.set_console_application_mode (True)
				Result.set_exception_trace_mode (False)
				Result.set_trace_mode (False)
				Result.set_use_boehm_gc (False)
			end
		end

feature {NONE} -- Eiffel AST factory

	new_eiffel_ast_factory: ET_AST_FACTORY
			-- New Eiffel AST factory
		do
			if eiffel_ast_factory /= Void then
				Result := eiffel_ast_factory
			else
				create Result.make
			end
		ensure
			eiffel_ast_factory_not_void: Result /= Void
		end

	new_eiffel_error_handler: ET_ERROR_HANDLER
			-- New Eiffel error handler for Eiffel parser
		do
			if eiffel_error_handler /= Void then
				Result := eiffel_error_handler
			else
				create Result.make_standard
			end
		ensure
			eiffel_error_handler_not_void: Result /= Void
		end

feature -- Configuration

	eiffel_ast_factory: ET_AST_FACTORY
			-- Return this AST factory in `new_eiffel_ast_factory'
			-- if not void

	eiffel_error_handler: ET_ERROR_HANDLER
			-- Return this error handler in `new_eiffel_error handler'
			-- if not void

feature -- Configuration setting

	set_eiffel_ast_factory (a_factory: like eiffel_ast_factory)
			-- Set `eiffel_ast_factory' to `a_factory'.
		do
			eiffel_ast_factory := a_factory
		ensure
			eiffel_ast_factory_set: eiffel_ast_factory = a_factory
		end

	set_eiffel_error_handler (a_handler: like eiffel_error_handler)
			-- Set `eiffel_error_handler' to `a_handler'.
		do
			eiffel_error_handler := a_handler
		ensure
			eiffel_error_handler_set: eiffel_error_handler = a_handler
		end

end
