indexing 
	description: "Generate Eiffel code from a given CodeDom tree"
	date: "$$"
	revision: "$$"

class
	CODE_GENERATOR

inherit
	SYSTEM_DLL_ICODE_GENERATOR

	CODE_GENERATION_CONTEXT
		redefine
			default_rescue
		end
	
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		undefine
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
			create output.make (l_writer)
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
			output_set: output = a_text_writer
		end
		
feature -- Interface

	generate_code_from_compile_unit (a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Create `code_dom_source' and call `generate_code' on it, which calls appropriate code_generator.
			-- | Call `compile_unit' on current `EG_COMPILE_UNIT' and write code in `a_text_writer'.
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromCompileUnit"])
			if a_compile_unit = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromCompileUnit"])
			else
				initialize (a_text_writer, a_options)
				factory.generate_compile_unit_from_dom (a_compile_unit)
				output.write_string ((create {CODE_EIFFEL_FACTORY}).last_compile_unit.code)
				output.flush
				output.close
				output := Void
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromCompileUnit"])
		end
		
	generate_code_from_namespace (a_namespace: SYSTEM_DLL_CODE_NAMESPACE; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_namespace_from_dom'.
			-- | Call `namespace' on `EG_NAMESPACE' and write code in `a_text_writer'.
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromNamespace"])
			if a_namespace = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromNamespace"])
			else
				initialize (a_text_writer, a_options)
				factory.generate_namespace_from_dom (a_namespace)
				output.write_string ((create {CODE_EIFFEL_FACTORY}).last_namespace.code)
				output.flush
				output.close
				output := Void
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromNamespace"])
		end

	generate_code_from_type (a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_type_from_dom'.
			-- | Call `type' on `EG_GENERATED_TYPE' and write code in `a_text_writer'.
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromType"])
			if a_type = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromType"])
			else
				initialize (a_text_writer, a_options)
				factory.generate_type_from_dom (a_type)
				output.write_string ((create {CODE_EIFFEL_FACTORY}).last_type.code)
				output.flush
				output.close
				output := Void
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromType"])
		end

	generate_code_from_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_statement_from_dom'.
			-- | Call `statement' on `EG_STATEMENT' and write code in `a_text_writer'.
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromStatement"])
			if a_statement = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromStatement"])
			else
				initialize (a_text_writer, a_options)
				factory.generate_statement_from_dom (a_statement)
				output.write_string ((create {CODE_EIFFEL_FACTORY}).last_statement.code)
				output.flush
				output.close
				output := Void
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromStatement"])
		end		

	generate_code_from_expression (a_expression: SYSTEM_DLL_CODE_EXPRESSION; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_expression_from_dom'
			-- | Call `expression' on `EG_EXPRESSION' and write code in `a_text_writer'.
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromExpression"])
			if a_expression = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromExpression"])
			else
				initialize (a_text_writer, a_options)
				factory.generate_expression_from_dom (a_expression)
				output.write_string ((create {CODE_EIFFEL_FACTORY}).last_expression.code)
				output.flush
				output.close
				output := Void
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromExpression"])
		end

	create_escaped_identifier (a_value: SYSTEM_STRING): SYSTEM_STRING is
			-- Escaped identifier for `a_value'
		local
			l_char: CHARACTER
			i: INTEGER
			l_result, l_escaped: STRING
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.CreateEscapedIdentifier"])
			if a_value /= Void and then a_value.length > 0 then
				 l_result := feature {SYSTEM_STRING}.copy (a_value)
				 l_char := l_result.item (1)
				 if not l_char.is_alpha then
				 	l_escaped := escaped_character (l_char)
				 	l_result.replace_substring (l_escaped, 1, 1)
				 	i := l_escaped.count + 1
				 else
				 	i := 1
				 end
				 from
				 until
				 	i > l_result.count
				 loop
				 	l_char := l_result.item (i)
				 	if not l_char.is_alpha and not l_char.is_digit and l_char /= '_' then
					 	l_escaped := escaped_character (l_char)
					 	l_result.replace_substring (l_escaped, i, i)
					 	i := i + l_escaped.count
				 	else
					 	i := i + 1
					end
				 end
				 Result := l_result
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["CreateEscapedIdentifier"])
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.CreateEscapedIdentifier"])
		ensure then
			non_void_get_type_output: Result /= Void
		end

	validate_identifier (a_value: SYSTEM_STRING) is
			-- Throw exception if `a_value' is not a valid Eiffel identifier.
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.ValidateIdentifier"])
			if a_value = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["ValidateIdentifier"])
			else
				if not (create {NAME_FORMATTER}).is_valid_variable_name (a_value) then
					feature {ISE_RUNTIME}.raise (create {ARGUMENT_EXCEPTION}.make ("Invalid identifier", a_value))
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Invalid_identifier, [a_value])
				end
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.ValidateIdentifier"])
		end

	create_valid_identifier (a_value: SYSTEM_STRING): SYSTEM_STRING is
			-- Create a valid identifier for the specified `value'.
			--| Designer doesn't allow 'Result' to be an identifier name other than value.
		local
			l_formatter: NAME_FORMATTER
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.CreateValidIdentifier"])
			if a_value = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_input, ["CreateValidIdentifier"])
			else
				create l_formatter
				if not l_formatter.is_valid_variable_name (a_value) then
					Result := l_formatter.valid_variable_name (a_value)
				else
					Result := a_value.to_lower
				end
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.CreateValidIdentifier"])
		end
		
	is_valid_identifier (a_value: SYSTEM_STRING): BOOLEAN is
			-- Is `a_value' a valid identifier?
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.IsValidIdentifier"])
			if a_value /= Void then
				Result := (create {NAME_FORMATTER}).is_valid_variable_name (a_value)
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.IsValidIdentifier"])
		end

	supports (a_flag: SYSTEM_DLL_GENERATOR_SUPPORT): BOOLEAN is
			-- Does code_generator support construct corresponding to `a_flag'?
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.Supports"])
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
					a_flag = feature {SYSTEM_DLL_GENERATOR_SUPPORT}.win_32_resources;
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.Supports"])
		end

	get_type_output (a_type: SYSTEM_DLL_CODE_TYPE_REFERENCE): SYSTEM_STRING is
			-- Get the type indicated by the specified `type'.
		local
			l_type: TYPE
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GetTypeOutput"])
			l_type := feature {TYPE}.get_type (a_type.base_type)
			if l_type /= Void then
				Result := cache.type_name (l_type)
			else
				Result := (create {NAME_FORMATTER}).full_formatted_type_name (a_type.base_type)
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GetTypeOutput"])
		ensure then
			non_void_get_type_output: Result /= Void
		end

feature -- Access

	factory: CODE_CONSUMER_FACTORY is
			-- eiffel CodeDOM factory.
		once
			Create Result.make
		ensure
			factory_created: Result /= Void
		end

	output: SYSTEM_DLL_INDENTED_TEXT_WRITER
			-- Text writer to write the result of the code generation.

feature {NONE} -- Implementation

	initialize (a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- Initialize `output' with `a_text_writer'.
		do
			if a_text_writer /= Void then
				if output /= Void then
					output.close
				end
				create output.make (a_text_writer)
			elseif output = Void then
				make_with_filename ("generated.es")
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_output, [(create {EXECUTION_ENVIRONMENT}).Current_working_directory + (create {OPERATING_ENVIRONMENT}).Directory_separator.out + "generated.es"])
			end
			if a_options /= Void then
				set_blank_lines_between_members (a_options.blank_lines_between_members)
				set_else_on_closing (a_options.else_on_closing)
				if a_options.indent_string /= Void then
					set_indent_string (a_options.indent_string)
				end
			end
		ensure
			non_void_output: output /= Void
		end

	escaped_character (a_char: CHARACTER): STRING is
			-- Valid indentifier built from `a_char'
		do
			create Result.make (4)
			Result.append ("x")
			Result.append (a_char.code.out)
		end

	cache: CACHE_REFLECTION is
			-- Access to Eiffel assemblies cache
		once
			create Result.make (feature {RUNTIME_ENVIRONMENT}.get_system_version)
		end

	default_rescue is
			-- Handle exceptions
		local
			l_event_manager: CODE_EVENT_MANAGER
		do
			create l_event_manager
			l_event_manager.process_exception
		end

end -- class CODE_GENERATOR

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