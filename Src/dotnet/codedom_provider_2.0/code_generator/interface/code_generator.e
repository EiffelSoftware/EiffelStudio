indexing
	description: "Generate Eiffel code from a given CodeDom tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_GENERATOR

inherit
	SYSTEM_DLL_ICODE_GENERATOR
	CODE_SHARED_ANALYSIS_CONTEXT	
		rename
			reset as reset_context
		end

	CODE_SHARED_GENERATION_CONTEXT
	CODE_SHARED_EVENT_MANAGER
	CODE_SHARED_FACTORIES
	CODE_SHARED_METADATA_ACCESS
	CODE_SHARED_GENERATION_HELPERS
	CODE_SHARED_TYPE_REFERENCE_FACTORY
	CODE_SHARED_NAME_FORMATTER
	CODE_SHARED_ACCESS_MUTEX
	CODE_SHARED_PARTIAL_TREE_STORE

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
			-- | Call `compile_unit' on current `CODE_COMPILE_UNIT' and write code in `a_text_writer'.
		do
			if Access_mutex.wait_one then
				reset
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromCompileUnit"])
				if a_compile_unit = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromCompileUnit"])
				else
					initialize (a_text_writer, a_options)
					set_current_state (Code_analysis)
					code_dom_generator.generate_compile_unit_from_dom (a_compile_unit)
					set_current_state (Code_generation)
					output.write_string (last_compile_unit.code)
					output := Void
				end
				Type_reference_factory.reset_cache
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromCompileUnit"])
				Access_mutex.release_mutex
			end
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	generate_code_from_namespace (a_namespace: SYSTEM_DLL_CODE_NAMESPACE; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_namespace_from_dom'.
			-- | Call `namespace' on `CODE_NAMESPACE' and write code in `a_text_writer'.
		do
			if Access_mutex.wait_one then
				reset
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromNamespace"])
				Type_reference_factory.reset_cache
				if a_namespace = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromNamespace"])
				else
					initialize (a_text_writer, a_options)
					set_current_state (Code_analysis)
					code_dom_generator.generate_namespace_from_dom (a_namespace)
					set_current_state (Code_generation)
					output.write_string (last_namespace.code)
					output := Void
				end
				Type_reference_factory.reset_cache
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromNamespace"])
				Access_mutex.release_mutex
			end
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	generate_code_from_type (a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_type_from_dom'.
			-- | Call `type' on `CODE_GENERATED_TYPE' and write code in `a_text_writer'.
		do
			if Access_mutex.wait_one then
				reset
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromType"])
				if a_type = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromType"])
				else
					initialize (a_text_writer, a_options)
					set_current_state (Code_analysis)
					code_dom_generator.generate_type_from_dom (a_type)
					set_current_state (Code_generation)
					output.write_string (last_type.code)
					output := Void
				end
				Type_reference_factory.reset_cache
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromType"])
				Access_mutex.release_mutex
			end
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	generate_code_from_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_statement_from_dom'.
			-- | Call `statement' on `CODE_STATEMENT' and write code in `a_text_writer'.
		do
			if Access_mutex.wait_one then
				reset
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromStatement"])
				if a_statement = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromStatement"])
				else
					partial_tree_store.put_statement (a_statement)
					initialize (a_text_writer, a_options)
					output.write_string (partial_tree_store.tree_id.out)
					output := Void
				end
				Type_reference_factory.reset_cache
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromStatement"])
				Access_mutex.release_mutex
			end
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	generate_code_from_expression (a_expression: SYSTEM_DLL_CODE_EXPRESSION; a_text_writer: TEXT_WRITER; a_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
			-- | Call `generate_expression_from_dom'
			-- | Call `expression' on `CODE_EXPRESSION' and write code in `a_text_writer'.
		do
			if Access_mutex.wait_one then
				reset
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GenerateCodeFromExpression"])
				if a_expression = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["GenerateCodeFromExpression"])
				else
					partial_tree_store.put_expression (a_expression)
					initialize (a_text_writer, a_options)
					output.write_string (partial_tree_store.tree_id.out)
					output := Void
				end
				Type_reference_factory.reset_cache
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GenerateCodeFromExpression"])
				Access_mutex.release_mutex
			end
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	create_escaped_identifier (a_value: SYSTEM_STRING): SYSTEM_STRING is
			-- Escaped identifier for `a_value'
		local
			l_char: CHARACTER
			i: INTEGER
			l_result, l_escaped: STRING
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.CreateEscapedIdentifier"])
			if a_value /= Void and then a_value.length > 0 then
				 l_result := {SYSTEM_STRING}.copy (a_value)
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
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["CreateEscapedIdentifier"])
			end
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.CreateEscapedIdentifier"])
		ensure then
			non_void_get_type_output: Result /= Void
		end

	validate_identifier (a_value: SYSTEM_STRING) is
			-- Throw exception if `a_value' is not a valid Eiffel identifier.
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.ValidateIdentifier"])
			if a_value = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["ValidateIdentifier"])
			else
				if not (create {NAME_FORMATTER}).is_valid_variable_name (a_value) then
					{ISE_RUNTIME}.raise (create {ARGUMENT_EXCEPTION}.make ("Invalid identifier", a_value))
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Invalid_identifier, [a_value])
				end
			end
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.ValidateIdentifier"])
		end

	create_valid_identifier (a_value: SYSTEM_STRING): SYSTEM_STRING is
			-- Create a valid identifier for the specified `value'.
			--| Designer doesn't allow 'Result' to be an identifier name other than value.
		local
			l_formatter: NAME_FORMATTER
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.CreateValidIdentifier"])
			if a_value = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_input, ["CreateValidIdentifier"])
			else
				create l_formatter
				if not l_formatter.is_valid_variable_name (a_value) then
					Result := l_formatter.valid_variable_name (a_value)
				else
					Result := a_value.to_lower
				end
			end
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.CreateValidIdentifier"])
		end

	is_valid_identifier (a_value: SYSTEM_STRING): BOOLEAN is
			-- Is `a_value' a valid identifier?
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.IsValidIdentifier"])
			if a_value /= Void then
				Result := (create {NAME_FORMATTER}).is_valid_variable_name (a_value)
			end
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.IsValidIdentifier"])
		end

	supports (a_flag: SYSTEM_DLL_GENERATOR_SUPPORT): BOOLEAN is
			-- Does code_generator support construct corresponding to `a_flag'?
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.Supports"])
			Result := a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.arrays_of_arrays or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.assembly_attributes or
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.chained_constructor_arguments or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.complex_expressions or
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_delegates or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_enums or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_events or
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_indexer_properties or		No Generation of indexer properties yet	2.0
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_interfaces or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.declare_value_types or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.entry_point_method or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.generic_type_declaration or	--		2.0
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.generic_type_reference or	-- 		2.0
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.goto_statements or					No Gotos
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.multidimensional_arrays or			No multiple dimensional arrays
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.multiple_interface_members or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.nested_types or
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.parameter_attributes or				No parameter attributes
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.partial_types or --					2.0
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.public_static_members or			No static members
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.reference_parameters or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.resources or --						2.0
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.return_type_attributes or			No return type attributes
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.static_constructors or
					a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.try_catch_statements
			--		a_flag = {SYSTEM_DLL_GENERATOR_SUPPORT}.win_32_resources;					No win32 resources
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.Supports"])
		end

	get_type_output (a_type: SYSTEM_DLL_CODE_TYPE_REFERENCE): SYSTEM_STRING is
			-- Get the type indicated by the specified `type'.
		local
			l_type: SYSTEM_TYPE
			l_type_name: STRING
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeGenerator.GetTypeOutput"])
			l_type := {SYSTEM_TYPE}.get_type (a_type.base_type)
			if l_type /= Void then
				l_type_name := cache_reflection.type_name (l_type)
				if l_type_name /= Void then
					Result := l_type_name
				end
			end
			if Result = Void then
				Result := (create {NAME_FORMATTER}).full_formatted_type_name (a_type.base_type)
			end
			Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeGenerator.GetTypeOutput"])
		ensure then
			non_void_get_type_output: Result /= Void
		end

feature -- Access

	output: SYSTEM_DLL_INDENTED_TEXT_WRITER
			-- Text writer to write the result of the code generation.

feature {NONE} -- Implementation

	reset is
			-- Reset all global variables.
		do
			Resolver.reset
			Name_formatter.reset
		end

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
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_output, [(create {EXECUTION_ENVIRONMENT}).Current_working_directory + (create {OPERATING_ENVIRONMENT}).Directory_separator.out + "generated.es"])
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_GENERATOR

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------