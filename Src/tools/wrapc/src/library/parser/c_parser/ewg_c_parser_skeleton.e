note

	description:

		"Skeleton class for class C_PARSER"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_C_PARSER_SKELETON

inherit

	EWG_PARSER_SKELETON
		rename
			make as make_ewg_parser
		end

	EWG_C_SCANNER
		rename
			make as make_c_scanner
		end

	EWG_CL_ATTRIBUTE_CONSTANTS
		export {NONE} all	end

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

feature {NONE} -- Initialization

	make (a_error_handler: like error_handler)
			-- Create a new parser.
		require
			a_error_handler_not_void: a_error_handler /= Void
		do
			make_ewg_parser (a_error_handler)
			make_c_scanner ("unknown")
			init_type_names
			last_string_value := ""
		ensure
			error_header_set: error_handler = a_error_handler
		end

feature {ANY}

	parse_buffer (a_buffer: KI_CHARACTER_INPUT_STREAM)
			-- Parses the content of `a_buffer'. Adds to
			-- `c_system' what it finds.
		do
			init_type_names
			set_input_buffer (new_file_buffer (a_buffer))
				check
					type_name_scope_is_empty: type_name_scope_stack.is_empty
				end
			parse
				check
					corrept_parsing_implies_type_name_scope_is_empty: not syntax_error implies type_name_scope_stack.is_empty
				end
			if syntax_error then
				type_name_scope_stack.wipe_out
			end
		end

	parse_file (a_file_name: STRING)
			-- Parse the already preprocessed C header file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			in_file: KL_TEXT_INPUT_FILE
			total_ticks: INTEGER
		do
			last_header_file_name := a_file_name
			create in_file.make (a_file_name)
			total_ticks := in_file.count
			in_file.open_read
			if in_file.is_open_read then
				error_handler.start_task ("phase 1: parsing")
				error_handler.set_current_task_total_ticks (total_ticks)
				parse_buffer (in_file)
				in_file.close
				error_handler.stop_task
				if not syntax_error then
					error_handler.report_parsed_successfuly_message
				else
					Exceptions.die (1)
				end
			else
				error_handler.report_cannot_read_error (a_file_name)
				Exceptions.die (1)
			end
		end

	print_summary
			-- Print summary about parsed system
		do
			error_handler.report_info_message ("  found:")
			error_handler.report_info_message ("    . " + c_system.types.count.out + " types")
			error_handler.report_info_message ("    . " + c_system.declarations.count.out + " declarations")
		end

feature {NONE}

	Type_names_initial_size: INTEGER = 500
			-- Initial size of type name hash set.

feature {NONE}

	update_type_names (a_declaration_specifiers: DS_LINKED_LIST [ANY];
						a_declarators: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR])
			-- This is the semi complete (but fast) type table used
			-- just by the lexer to distinguish `TOK_IDENTIFIE' from
			-- `TOK_TYPE_NAME'.
		local
			cs_ds: DS_LINKED_LIST_CURSOR [ANY]
			cs_dc: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATOR]
			is_typedef: BOOLEAN
		do
			-- see if this is a typedef
			from
				cs_ds := a_declaration_specifiers.new_cursor
				cs_ds.start
			until
				cs_ds.off or is_typedef
			loop
				if attached {EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS} cs_ds.item as storage_class_spec and then
					storage_class_spec.is_typedef
				then
					is_typedef := True
				end
				cs_ds.forth
			end
			if is_typedef then
				from
					cs_dc := a_declarators.new_cursor
					cs_dc.start
				until
					cs_dc.off
				loop
-- you bet! below check does not hold, of course vc seems to allow double definitions
-- opengl PFORMAT_STRING is an example
--						check
--							item_not_yet_in_table: not type_names.has (cs_dc.item.name)
--						end
					if attached cs_dc.item.name as l_name then
						type_names.force (l_name)
					end

					cs_dc.forth
				end
			end
		end

	is_type_name (a_token: STRING): BOOLEAN
			-- This feature is for the lexer to ask if a given
			-- token is a regular TOK_IDENTIFIER or a TOK_TYPE_NAME
		do
			Result := type_names.has (a_token)
		end

	add_top_level_declaration (a_declaration: EWG_C_PHASE_1_DECLARATION)
			-- Analyze `a_declaration' and add appropriate
			-- objects to `c_system'.
		require
			a_declaration_not_void: a_declaration /= Void
		do
			c_system.add_top_level_declaration (a_declaration)
		end

	init_type_names
			-- Create `type_names' and add built in types.
		do
			create type_names.make (Type_names_initial_size)
			type_names.set_equality_tester (string_equality_tester)
			-- Add built in for gcc, doesn't seem to harm other C compilers
			-- so no conditional needed
			type_names.force ("__builtin_va_list")
		end

feature

	type_names: DS_HASH_SET [STRING]
			-- Set of all named types found so far.
			-- Note that this table is redundant with the one
			-- found in `c_system'. `type_names' is here to
			-- be able to tell the scanner whether a given token
			-- is a type name or a identifier.

feature

	c_code_from_specifier_qualifier_list (a_list: DS_LINEAR[ANY]): STRING
		require
			a_list_not_void: a_list /= Void
		local
			cs: DS_LINEAR_CURSOR[ANY]
		do
			from
				create Result.make (5)
				cs := a_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if attached {EWG_C_PHASE_1_TYPE_SPECIFIER} cs.item as specifier then
					Result.append_string (specifier.c_code)
				end
				if attached {EWG_C_PHASE_1_TYPE_SPECIFIER} cs.item as qualifier  then
					Result.append_string (qualifier.c_code)
				end
				cs.forth
			end
		ensure
			result_not_void: Result /= Void
		end

invariant

	type_names_not_void: type_names /= Void

end
