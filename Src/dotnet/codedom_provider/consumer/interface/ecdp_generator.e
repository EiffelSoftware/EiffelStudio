indexing 
	description: "Generate Eiffel code from a given CodeDom tree"
	date: "$$"
	revision: "$$"

class
	ECDP_GENERATOR

inherit
	SYSTEM_DLL_ICODE_GENERATOR
		undefine
			equals,
			get_hash_code,
			to_string
		end

	ECDP_SHARED_DATA
		redefine
			default_rescue
		end

create
	default_create,
	make_with_filename,
	make_with_text_writer

feature {NONE} -- Initialization

	make_with_filename (a_file_name: STRING) is
			-- Creation routine
		require
			non_void_a_file_name: a_file_name /= Void
			not_empty_a_file_name: not a_file_name.is_empty
		local
			l_writer: STREAM_WRITER
		do
			create l_writer.make (a_file_name.to_cil, True)
			create {SYSTEM_DLL_INDENTED_TEXT_WRITER} output.make (l_writer)
		ensure
			non_void_output: output /= Void
		end

	make_with_text_writer (a_text_writer: SYSTEM_DLL_INDENTED_TEXT_WRITER) is
			-- Set `output' with `a_text_writer'.
		require
			non_void_a_text_writer: a_text_writer /= Void
		do
			output := a_text_writer
		ensure
			non_void_output: output /= Void
			valid_output: output = a_text_writer
		end
		
feature -- Interface

	generate_code_from_compile_unit (a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT; a_text_writer: TEXT_WRITER; options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Create `code_dom_source' and call `generate_code' on it, which calls appropriate code_generator.
			-- | Call `compile_unit' on current `EG_COMPILE_UNIT' and write code in `a_text_writer'.
		local
			last_compile_unit: ECDP_COMPILE_UNIT
			a_snippet_compile_unit: ECDP_SNIPPET_COMPILE_UNIT
			code: STRING
			l_text_writer: STREAM_WRITER
			path: STRING
		do
			check
				non_void_compile_unit: a_compile_unit /= Void
				valid_output: a_text_writer /= Void or temporary_files /= Void
			end		

			if Ace_file.path_to_generated_src.is_empty then
				Ace_file.set_path_to_generated_src ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			end

			factory.generate_compile_unit_from_dom (a_compile_unit)
			
				-- Generate code.
--				last_compile_unit := factory.code_dom_source.factory.last_compile_unit
--				code := last_compile_unit.compile_unit
			
			a_snippet_compile_unit ?= last_compile_unit
			if a_snippet_compile_unit /= Void then
					-- this is a web service...
				path := Ace_file.path_to_generated_src + "/" + "EIFFEL_WEB_SERVICE" + ".e"
				create l_text_writer.make_from_path (path.to_cil)
				l_text_writer.write_string (code.to_cil)
				l_text_writer.close

				Ace_file.set_root_class_creation_routine ("EIFFEL_WEB_SERVICE")
				Ace_file.set_root_class_name ("square")
			end
				-- Write ace_file in text writer.
			if a_text_writer = Void then
				check
					non_void_temporary_files: temporary_files /= Void
				end
				create l_text_writer.make_from_path_and_append (ace_file_path, False)
				Ace_file.set_text_writer (l_text_writer)
				temporary_files.add_file (ace_file_path, True)
			else
				Ace_file.set_text_writer (a_text_writer)
			end
			Ace_file.out_code
		ensure then
			code_generated: output.to_string.length > 0
		end
		
	generate_code_from_namespace (a_namespace: SYSTEM_DLL_CODE_NAMESPACE; a_text_writer: TEXT_WRITER; options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_namespace_from_dom'.
			-- | Call `namespace' on `EG_NAMESPACE' and write code in `a_text_writer'.
		local
			last_namespace: ECDP_NAMESPACE
			code: STRING
		do
			check
				non_void_namespace: a_namespace /= Void
				valid_output: a_text_writer /= Void or temporary_files /= Void
			end

			factory.generate_namespace_from_dom (a_namespace)

				-- Generate code.
			last_namespace := (create {ECDP_EIFFEL_FACTORY}).last_namespace
			code := last_namespace.code

				-- Write ace_file in text writer.
			if a_text_writer /= Void then
				a_text_writer.write_string (code.to_cil)
				a_text_writer.flush
			end
		end

	generate_code_from_type (a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_text_writer: TEXT_WRITER; options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_type_from_dom'.
			-- | Call `type' on `EG_GENERATED_TYPE' and write code in `a_text_writer'.
		local
			last_type: ECDP_GENERATED_TYPE
			code: STRING
		do
			check
				non_void_type: a_type /= Void
				non_void_text_writer: a_text_writer /= Void
			end	

			factory.generate_type_from_dom (a_type)

				-- Generate code.
			last_type := (create {ECDP_EIFFEL_FACTORY}).last_type
			code := last_type.code

				-- Write ace_file in text writer.
			if a_text_writer /= Void then
				a_text_writer.write_string (code)
				a_text_writer.flush
			end
		end

	generate_code_from_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT; a_text_writer: TEXT_WRITER; options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_statement_from_dom'.
			-- | Call `statement' on `EG_STATEMENT' and write code in `a_text_writer'.
		local
			last_statement: ECDP_STATEMENT
			code: STRING
		do
			check
				non_void_statement: a_statement /= Void
				non_void_text_writer: a_text_writer /= Void
			end

			factory.generate_statement_from_dom (a_statement)

				-- Generate code.
			last_statement := (create {ECDP_EIFFEL_FACTORY}).last_statement
			code := last_statement.code

				-- Write ace_file in text writer.
			if a_text_writer /= Void then
				a_text_writer.write_string (code)
				a_text_writer.flush
			end
		end		

	generate_code_from_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION; a_text_writer: TEXT_WRITER; options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_expression_from_dom'
			-- | Call `expression' on `EG_EXPRESSION' and write code in `a_text_writer'.
		local
			last_expression: ECDP_EXPRESSION
			code: STRING
		do
			check
				non_void_expression: an_expression /= Void
				non_void_text_writer: a_text_writer /= Void
			end

			factory.generate_expression_from_dom (an_expression)

				-- Generate code.
			last_expression := (create {ECDP_EIFFEL_FACTORY}).last_expression
			code := last_expression.code

				-- Write ace_file in text writer.
			if a_text_writer /= Void then
				a_text_writer.write_string (code.to_cil)
				a_text_writer.flush
			end
		end

	create_escaped_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
			-- Create an escaped identifier for the specified `value'.
		do
			 Result := value
		ensure then
			non_void_get_type_output: Result /= Void
		end

	validate_identifier (value: SYSTEM_STRING) is
			-- [Should test the specified identifier for validity in the current language and source code.%
			--				%Throw an exception if the specified `value' is not a valid identifier.]
		local
			l_variable_name: STRING
			l_formatter: NAME_FORMATTER
			arg_exception: ARGUMENT_EXCEPTION
		do
			if value /= Void then
				create l_formatter
				create l_variable_name.make_from_cil (value)
				if not l_formatter.is_valid_variable_name (l_variable_name) then
						-- Throw exception
					create arg_exception.make ("Invalid identifier")
				end
			else
					-- Throw exception
				create arg_exception.make ("Invalid identifier")
			end
		end

	create_valid_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
			-- Create a valid identifier for the specified `value'.
		do
			Result := value.to_lower
				-- For now return a lowercase version of 'value'
				-- Designer doesn't allow 'Result' to be an identifier name other than value.
		end
		
	is_valid_identifier (a_value: SYSTEM_STRING): BOOLEAN is
			-- Is `a_value' a valid identifier?
		do
			if a_value /= Void then
				Result := (create {NAME_FORMATTER}).is_valid_variable_name (a_value)
			end
		end

	supports (a_flag: SYSTEM_DLL_GENERATOR_SUPPORT): BOOLEAN is
			-- Does code_generator support construct corresponding to `a_flag'?
		do
			Result := a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.arrays_of_arrays or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.assembly_attributes or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.chained_constructor_arguments or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.complex_expressions or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_delegates or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_enums or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_events or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_interfaces or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_value_types or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.entry_point_method or
			--		a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.goto_statements or					No Gotos
			--		a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.multidimensional_arrays or			No multiple dimensional arrays
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.multiple_interface_members or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.nested_types or
			--		a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.parameter_attributes or				No parameter attributes
			--		a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.public_static_members or			No static members
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.reference_parameters or
			--		a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.return_type_attributes or			No return type attributes
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.static_constructors or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.try_catch_statements or
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.win_32_resources
		end

	get_type_output (a_type: SYSTEM_DLL_CODE_TYPE_REFERENCE): SYSTEM_STRING is
			-- Get the type indicated by the specified `type'.
		local
			l_type: TYPE
		do
			l_type := feature {TYPE}.get_type (a_type.base_type)
			if l_type /= Void then
				Result := cache.type_name (l_type)
			else
				Result := (create {NAME_FORMATTER}).full_formatted_type_name (a_type.base_type)
			end
		ensure then
			non_void_get_type_output: Result /= Void
		end

feature -- Access

	factory: ECDP_CONSUMER_FACTORY is
			-- eiffel CodeDOM factory.
		once
			Create Result.make
		ensure
			factory_created: Result /= Void
		end

	output: TEXT_WRITER
			-- Text writer to write the result of the code generation.

feature {NONE} -- Implementation

	cache: CACHE_REFLECTION is
			-- Access to Eiffel assemblies cache
		once
			create Result.make (feature {RUNTIME_ENVIRONMENT}.get_system_version)
		end

	default_rescue is
			-- Handle exceptions
		local
			l_event_manager: ECDP_EVENT_MANAGER
		do
			create l_event_manager
			l_event_manager.process_exception
		end

end -- class ECDP_GENERATOR

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------