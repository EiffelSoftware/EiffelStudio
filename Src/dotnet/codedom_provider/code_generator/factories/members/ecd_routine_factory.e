indexing
	description: "Code generator for type methods and properties"
	date: "$Date$"
	revision: "$Revision$"
	
class
	ECD_ROUTINE_FACTORY

inherit
	ECD_MEMBER_FACTORY
	
	ECD_SHARED_CONTEXT
		export
			{NONE} all
		end

	ECD_USER_DATA_KEYS
		export
			{NONE} all
		end

feature {ECD_CONSUMER_FACTORY} -- Visitor features.

	generate_routine (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD) is
			-- Generate Eiffel code from `a_source'.
			--| Call `generate_function' or `generate_procedure' whether
			--|  b`a_source' has return type or not.	
		require
			non_void_source: a_source /= Void
		do
			if a_source.return_type.base_type.equals (("System.Void").to_cil) then
				generate_procedure (a_source)
			else
				generate_function (a_source)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end
		
	generate_creation_routine (a_source: SYSTEM_DLL_CODE_CONSTRUCTOR) is
			-- Generate Eiffel code from `a_source'.
			-- | Create instance of `ECD_CREATION_ROUTINE'.
			-- | Set `current_feature'.
			-- | And initialize this instance with `a_source' -> Call `initialize_creation_routine'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.
		require
			non_void_source: a_source /= Void
		local
			l_creation_routine: ECD_CREATION_ROUTINE
		do
			create l_creation_routine.make
			set_current_routine (l_creation_routine)
			initialize_creation_routine (a_source, l_creation_routine)
			set_current_routine (Void)
			set_last_feature (l_creation_routine)
		ensure
			non_void_last_feature: last_feature /= Void
		end

	generate_root_procedure (a_source: SYSTEM_DLL_CODE_ENTRY_POINT_METHOD) is
			-- Generate Eiffel code from `a_source'.
			-- | Create instance of `ECD_ROOT_PROCEDURE'.
			-- | Set `current_feature'.
			-- | And initialise this instance with `a_source' -> Call `initialize_root_procedure'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.
		require
			non_void_source: a_source /= Void
		local
			l_root_procedure: ECD_ROOT_PROCEDURE
		do
			create l_root_procedure.make
			set_current_routine (l_root_procedure)
			initialize_root_procedure (a_source, l_root_procedure)
			set_current_routine (Void)
			set_last_feature (l_root_procedure)
		ensure
			non_void_last_feature: last_feature /= Void
		end

	generate_property (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY) is
			-- | Create instance of `EG_PROPERTY_GETTER' if has a get property.
			-- | Create instance of `EG_PROPERTY_SETTER' if has a set property.
			-- | For each instance : Set `current_feature'.
			-- | Add `current_feature' to `current_type'.
			-- | Initialize current_feature.
			-- | Set `current_feature' to Void because there no more current feature.
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_property_getter: ECD_PROPERTY_GETTER
			l_property_setter: ECD_PROPERTY_SETTER
		do
			if a_source.has_get then
				create l_property_getter.make
				set_current_routine (l_property_getter)
				current_type.add_feature (l_property_getter)
				initialize_property_getter (a_source, l_property_getter)
			end

			if a_source.has_set then
				create l_property_setter.make
				set_current_routine (l_property_setter)
				current_type.add_feature (l_property_setter)
				initialize_property_setter (a_source, l_property_setter)
			end

			set_current_routine (Void)
			if l_property_getter /= Void then
				set_last_feature (l_property_getter)
			else
				set_last_feature (l_property_setter)
			end
		end
			
	generate_procedure (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD) is
			-- | Create instance of `EG_PROCEDURE'.
			-- | Set `current_feature'.
			-- | And initialise this instance with `a_source' -> Call `initialize_procedure'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_procedure: ECD_PROCEDURE
		do
			create l_procedure.make
			set_current_routine (l_procedure)
			initialize_procedure (a_source, l_procedure)
			set_current_routine (Void)
			set_last_feature (l_procedure)
		ensure
			non_void_last_feature: last_feature /= Void
		end			
		
	generate_function (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD) is
			-- | Create instance of `EG_FUNCTION'.
			-- | Set `current_feature'.
			-- | And initialise this instance with `a_source' -> Call `initialise_function'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_function: ECD_FUNCTION
		do
			create l_function.make
			set_current_routine (l_function)
			initialise_function (a_source, l_function)
			set_current_routine (Void)
			set_last_feature (l_function)
		ensure
			non_void_last_feature: last_feature /= Void
		end	
	
feature {NONE} -- Routine Initialization

	initialize_creation_routine (a_source: SYSTEM_DLL_CODE_CONSTRUCTOR; a_creation_routine: ECD_CREATION_ROUTINE) is
			-- | Set `type_feature' with `Initialization'
			-- | Call `generate_feature_clause'.
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `private_generate_routine'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_routine: a_creation_routine /= Void
		do
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["creation routine initialization (" + context (a_creation_routine) + ")"])
			else
				a_creation_routine.set_type_feature (Initialization)
				current_type.add_creation_routine (a_creation_routine)
				initialize_routine (a_source, a_creation_routine)
			end
		end

	initialize_root_procedure (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_root_procedure: ECD_ROOT_PROCEDURE) is
			-- Generate Eiffel code from `a_source'.
			-- | Set `type_feature' with `Basic_operation'
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `initialize_routine'.
			-- | Set `root_procedure' in `ace_file'
		require
			non_void_source: a_source /= Void
			non_void_root_procedure: a_root_procedure /= Void
		do
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["root creation routine initialization (" + context (a_root_procedure) + ")"])
			else
				a_root_procedure.set_type_feature (Initialization)
				current_type.add_feature (a_root_procedure)
				initialize_routine (a_source, a_root_procedure)
				
				if a_root_procedure.name = Void then
					Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_feature_name, ["root creation routine initialization (" + context (a_root_procedure) + ")"])
				else
					Compilation_context.set_root_creation_routine_name (a_root_procedure.name)
					Compilation_context.set_root_class_name (current_type.name)
				end
			end
		end
		
	initialize_procedure (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_procedure: ECD_PROCEDURE) is
			-- Generate Eiffel code from `a_source'.
			-- | Set `type_feature' with `Basic_operation' 
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `initialize_routine'.
		require
			non_void_source: a_source /= Void
			non_void_procedure: a_procedure /= Void
		do
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["root creation routine initialization (" + context (a_procedure) + ")"])
			else
				a_procedure.set_type_feature (Basic_operations)
				current_type.add_feature (a_procedure)
				initialize_routine (a_source, a_procedure)
			end
		end
	
	initialize_property_getter (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY; a_property_getter: ECD_PROPERTY_GETTER) is
			-- Set `a_property_getter' according to `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_property_getter: a_property_getter /= Void
		local
			l_name: STRING
		do
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["property getter initialization (" + context (a_property_getter) + ")"])
			else
				create l_name.make (a_source.name.length + 4)
				l_name.append ("get_")
				l_name.append (a_source.name)
				a_property_getter.set_name (l_name)
				a_property_getter.set_implemented_type_name (current_type.name)
				a_property_getter.set_type_feature (Get_property_string)
				
				generate_comments (a_source, a_property_getter)
				generate_statements (a_source.get_statements, a_property_getter)
				generate_result (a_source, a_property_getter)
	
				if a_source.attributes /= Void then
					initialize_member_status (a_source.attributes, a_property_getter)
				end
				
				if a_source.custom_attributes /= Void then
					initialize_custom_attributes (a_source.custom_attributes, a_property_getter)
				end
				
				if a_source.private_implementation_type /= Void then
					initialize_feature_clauses (a_source.private_implementation_type, a_property_getter)
				end
	
				generate_feature_clause (a_source, a_property_getter)
			end
		end

	initialize_property_setter (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY; a_property_setter: ECD_PROPERTY_SETTER) is
			-- Set `a_property_setter' according to `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_property_setter: a_property_setter /= Void
		local
			l_argument_expression: ECD_PARAMETER_DECLARATION_EXPRESSION
			l_name: STRING
		do
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["property setter initialization"])
			else
				create l_name.make (a_source.name.length + 4)
				l_name.append ("set_")
				l_name.append (a_source.name)
				a_property_setter.set_name (l_name)
				a_property_setter.set_implemented_type_name (current_type.name)
				a_property_setter.set_type_feature (Set_property_string)
				
				generate_comments (a_source, a_property_setter)
				generate_arguments (a_source, a_property_setter)
				generate_statements (a_source.set_statements, a_property_setter)
	
				if a_source.type = Void then
					Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_return_type, ["property setter initialization"])
				else
					code_dom_generator.generate_type_reference_from_dom (a_source.type)
					a_property_setter.set_property_type_name (last_return_type.name)
				end	
	
				create l_argument_expression.make
				l_argument_expression.set_name ("value")
				l_argument_expression.set_parameter_type (a_property_setter.property_type_name)
				Resolver.add_variable (a_property_setter.property_type_name, "value")
				a_property_setter.add_argument (l_argument_expression)
	
				if a_source.attributes /= Void then
					initialize_member_status (a_source.attributes, a_property_setter)
				end
				
				if a_source.custom_attributes /= Void then
					initialize_custom_attributes (a_source.custom_attributes, a_property_setter)
				end
				
				if a_source.private_implementation_type /= Void then
					initialize_feature_clauses (a_source.private_implementation_type, a_property_setter)
				end
	
				generate_feature_clause (a_source, a_property_setter)
			end
		end

	initialise_function (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_function: ECD_FUNCTION) is
			-- Generate Eiffel code from `a_source'.
			-- | Set `type_feature' with `Status_report' if return type is BOOLEAN 
			-- | else Set `type_feature' with `Access' 
			-- | Call `generate_result'
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `initialize_routine'.
		require
			non_void_source: a_source /= Void
			non_void_function: a_function /= Void
		do
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["routine initialization"])
			else
				if a_source.return_type.base_type.equals (("System.Boolean").to_cil) then
					a_function.set_type_feature (Status_report)
				else
					a_function.set_type_feature (Implementation)
				end
				generate_result (a_source, a_function)
				current_type.add_feature (a_function)
				initialize_routine (a_source, a_function)
			end
		ensure
		 	function_ready: a_function.ready
		end	
	
	initialize_routine (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_routine: ECD_ROUTINE) is
			-- Generate Eiffel code from `a_source'.
			-- | set name of `a_routine'
			-- | Set `implemented_type' with `current_type'
			-- | Call `generate_feature_clause'.
			-- | Call `generate_comments' if any.
			-- | Use `eg_generated_types' to set implemented_type.			
			-- | Call `generate_arguments' if any.
			-- | Call `generate_statements' if any.
		require
			non_void_source: a_source /= Void
			non_void_routine: a_routine /= Void
		local
			l_routine_name: STRING
		do
			if a_source.name.equals ((".ctor").to_cil) then
				l_routine_name := "make"
			else
				l_routine_name := a_source.name
			end
			if a_source.user_data = Void or else not a_source.user_data.contains (From_eiffel_code_key) then
				-- If we are a new feature then we want name to be in eiffel case
				l_routine_name := (create {NAME_FORMATTER}).formatted_feature_name (l_routine_name)
			end
			a_routine.set_name (l_routine_name)
			
			if current_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["routine initialization"])
			else
				a_routine.set_implemented_type_name (current_type.name)
			end


			if a_source.attributes /= Void then
				initialize_member_status (a_source.attributes, a_routine)
			end

			if a_source.custom_attributes /= Void then
				initialize_custom_attributes (a_source.custom_attributes, a_routine)
			end

			if a_source.private_implementation_type /= Void then
				initialize_feature_clauses (a_source.private_implementation_type, a_routine)
			end

			if a_source.comments /= Void and then a_source.comments.count > 0 then
				generate_comments (a_source, a_routine)
			end
			if a_source.parameters /= Void and then a_source.parameters.count > 0 then
				generate_arguments (a_source, a_routine)
			end
			if a_source.statements /= Void and then a_source.statements.count > 0 then
				generate_statements (a_source.statements, a_routine)	
			end

			generate_feature_clause (a_source, a_routine)
		ensure
			routine_ready: a_routine.ready
		end

feature {NONE} -- Implementation

	generate_arguments (a_source: SYSTEM_DLL_CODE_TYPE_MEMBER; a_routine: ECD_ROUTINE) is
			-- Generate Eiffel code from `a_source'.
			-- | Call in loop to corresponding `generate_expression_from_dom'.
		require
			non_void_source: a_source /= Void
			non_void_routine: a_routine /= Void
		local
			i, l_count: INTEGER
			l_arguments: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION
			l_argument: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
			l_argument_expression: ECD_PARAMETER_DECLARATION_EXPRESSION
		do
			l_method ?= a_source
			if l_method = Void then
				l_property ?= a_source
				if l_property = Void then
					Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Failed_assignment_attempt, ["SYSTEM_DLL_CODE_TYPE_MEMBER", "SYSTEM_DLL_CODE_MEMBER_METHOD or SYSTEM_DLL_CODE_MEMBER_PROPERTY", "statements generation of " + context (a_routine)])
				else
					l_arguments := l_property.parameters
				end
			else
				l_arguments := l_method.parameters
			end
			if l_arguments /= Void then
				from
					l_count := l_arguments.count
				until
					i = l_count					
				loop
					l_argument := l_arguments.item (i)
					if l_argument /= Void then
						code_dom_generator.generate_expression_from_dom (l_argument)
						l_argument_expression ?= last_expression
						if l_argument_expression /= Void then
							a_routine.add_argument (l_argument_expression)
						else
							Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Failed_assignment_attempt, ["ECD_EXPRESSION", "ECD_ARGUMENT_EXPRESSION", "arguments generation of " + context (a_routine)])
						end
					else
						Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Void_argument, [context (a_routine)])
					end
					i := i + 1
				end
			else
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_parameters, [context (a_routine)])
			end
		end	

	generate_result (a_source: SYSTEM_DLL_CODE_TYPE_MEMBER; a_function: ECD_FUNCTION) is
			-- Generate Eiffel code from `a_source'.
			-- | Call `generate_expression_from_dom'.
		require
			non_void_source: a_source /= Void
			non_void_function: a_function /= Void
		local
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
			l_return_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			l_method ?= a_source
			if l_method = Void then
				l_property ?= a_source
				if l_property = Void then
					Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Failed_assignment_attempt, ["ECD_EXPRESSION", "ECD_ARGUMENT_EXPRESSION", "result generation of " + context (a_function)])
				else
					l_return_type := l_property.type
				end
			else
				l_return_type := l_method.return_type
			end
			if l_return_type = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_return_type, [context (a_function)])
			else
				code_dom_generator.generate_type_reference_from_dom (l_return_type)
				a_function.set_returned_type (last_return_type.name)
				a_function.set_is_array_returned_type (l_return_type.array_element_type /= Void)
			end
		end	

	generate_statements (a_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION; a_routine: ECD_ROUTINE) is
			-- Generate statements `a_statements' in `a_routine'.
			-- | Call in loop to corresponding `generate_statement_from_dom'.
		require
			non_void_statements: a_statements /= Void
			non_void_routine: a_routine /= Void
		local
			i, l_count: INTEGER
			l_statement: SYSTEM_DLL_CODE_STATEMENT
			l_declaration_variable_statement: ECD_VARIABLE_DECLARATION_STATEMENT
			l_try_catch_statement: ECD_TRY_CATCH_FINALLY_STATEMENT
		do
			if a_statements = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_statements, [context (a_routine)])
			else
				from
					l_count := a_statements.count
				until
					i = l_count				
				loop
					l_statement := a_statements.item (i)
					if l_statement = Void then
						Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Void_statement, [context (a_routine)])
					else
						code_dom_generator.generate_statement_from_dom (l_statement)
						l_declaration_variable_statement ?= last_statement
						if l_declaration_variable_statement /= Void then
							a_routine.add_local (l_declaration_variable_statement)
							a_routine.add_statement (l_declaration_variable_statement)
						else
							l_try_catch_statement ?= last_statement
							if l_try_catch_statement /= Void then
								initialize_try_catch_feature (l_try_catch_statement, a_routine)
							else
								a_routine.add_statement (last_statement)
							end
						end
					end
					i := i + 1
				end
			end
		end

	initialize_try_catch_feature (a_try_catch_statement: ECD_TRY_CATCH_FINALLY_STATEMENT; a_routine: ECD_ROUTINE) is
			-- Add a feature to current type, and call this feature from current statement.
		require
			non_void_a_try_catch_statement: a_try_catch_statement /= Void
			non_void_a_routine: a_routine /= Void
		local
			l_feature_name: STRING
			l_rescue_feature: ECD_ROUTINE
			l_snippet_value: STRING
			l_snippet_statement: ECD_SNIPPET_STATEMENT
			l_arguments: LIST [ECD_PARAMETER_DECLARATION_EXPRESSION]
			l_locals: LIST [ECD_VARIABLE_DECLARATION_STATEMENT]
		do
			if current_routine = Void then
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_routine, ["try catch feature initialization (" + context (a_routine) + ")"])
			else
				l_feature_name := "try_catch_" + current_routine.name
	
					-- Creation try catch statement.
				create l_rescue_feature.make
				l_rescue_feature.set_name (l_feature_name)
				l_snippet_value := l_feature_name
	
				l_rescue_feature.add_feature_clause ("NONE")
				l_rescue_feature.set_type_feature ("Rescued features")
					-- Add arguments
				from
					l_arguments := current_routine.arguments
					l_arguments.start
					if not l_arguments.after then
						l_snippet_value.append (" (")
						l_snippet_value.append (l_arguments.item.name)
						l_rescue_feature.add_argument (l_arguments.item)
						l_arguments.forth
					end
				until
					l_arguments.after
				loop
					l_snippet_value.append (", ")
					l_snippet_value.append (l_arguments.item.name)
					l_rescue_feature.add_argument (l_arguments.item)
					l_arguments.forth
				end
				if l_arguments.count > 0 then
					l_snippet_value.append (")")
				end
	
					-- Add local variables
				from
					l_locals := current_routine.locals
					l_locals.start
				until
					l_locals.after
				loop
					l_rescue_feature.add_local (l_locals.item)
					l_locals.forth
				end
				l_rescue_feature.add_statement (a_try_catch_statement)
	
				if current_type = Void then
					Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["routine initialization"])
				else
					current_type.add_feature (l_rescue_feature)
				end
	
					-- Add call to try_catch feature.
				create l_snippet_statement.make
				l_snippet_statement.set_value (l_snippet_value)
				a_routine.add_statement (l_snippet_statement)
			end
		end

end -- class ECD_ROUTINE_FACTORY

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