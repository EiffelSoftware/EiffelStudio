indexing
	description: "Code generator for type methods and properties"
	date: "$Date$"
	revision: "$Revision$"
	
class
	ECDP_ROUTINE_FACTORY

inherit
	ECDP_MEMBER_FACTORY

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_routine (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD) is
			-- | Call `generate_function' or `generate_procedure' whether `a_source' has return type or not.	

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			if Return_type_void.is_equal (a_source.return_type.base_type) then
				generate_procedure (a_source)
			else
				generate_function (a_source)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end
		
	generate_creation_routine (a_source: SYSTEM_DLL_CODE_CONSTRUCTOR) is
			-- | Create instance of `EG_CREATION_ROUTINE'.
			-- | Set `current_feature'.
			-- | And initialize this instance with `a_source' -> Call `initialize_creation_routine'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_creation_routine: ECDP_CREATION_ROUTINE
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
			-- | Create instance of `EG_ROOT_PROCEDURE'.
			-- | Set `current_feature'.
			-- | And initialise this instance with `a_source' -> Call `initialize_root_procedure'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_root_procedure: ECDP_ROOT_PROCEDURE
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
			l_property_getter: ECDP_PROPERTY_GETTER
			l_property_setter: ECDP_PROPERTY_SETTER
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
			l_procedure: ECDP_PROCEDURE
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
			l_function: ECDP_FUNCTION
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

	initialize_creation_routine (a_source: SYSTEM_DLL_CODE_CONSTRUCTOR; a_creation_routine: ECDP_CREATION_ROUTINE) is
			-- | Set `type_feature' with `Initialization'
			-- | Call `generate_feature_clause'.
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `private_generate_routine'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_routine: a_creation_routine /= Void
		do
			a_creation_routine.set_type_feature (Initialization)
			current_type.add_creation_routine (a_creation_routine)
			initialize_routine (a_source, a_creation_routine)
		end

	initialize_root_procedure (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_root_procedure: ECDP_ROOT_PROCEDURE) is
			-- | Set `type_feature' with `Basic_operation'
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `initialize_routine'.
			-- | Set `root_procedure' in `ace_file'

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_root_procedure: a_root_procedure /= Void
		do
			a_root_procedure.set_type_feature (Basic_operations)
			current_type.add_feature (a_root_procedure)
			initialize_routine (a_source, a_root_procedure)
			
			if a_root_procedure.name /= Void then
				Ace_file.set_root_class_creation_routine (a_root_procedure.name)
				Ace_file.set_root_class_name (current_type.name)
			end
		ensure
			non_void_ace_file_root_class_creation_routine: Ace_file.root_class_creation_routine /= Void
			non_empty_ace_file_root_class_creation_routine: not Ace_file.root_class_creation_routine.is_empty
			non_void_ace_file_root_class_name: Ace_file.root_class_name /= Void
			non_empty_ace_file_root_class_name: not Ace_file.root_class_name.is_empty
		end
		
	initialize_procedure (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_procedure: ECDP_PROCEDURE) is
			-- | Set `type_feature' with `Basic_operation' 
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `initialize_routine'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_procedure: a_procedure /= Void
		do
			a_procedure.set_type_feature (Basic_operations)
			current_type.add_feature (a_procedure)
			initialize_routine (a_source, a_procedure)
		end
	
	initialize_property_getter (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY; a_property_getter: ECDP_PROPERTY_GETTER) is
			-- Set `a_property_getter' according to `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_property_getter: a_property_getter /= Void
		local
			i, l_count: INTEGER
			l_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
			l_comment: ECDP_COMMENT
			l_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			l_name: STRING
		do
			if current_type = Void then
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_type, ["property getter initialization"])
			else
				create l_name.make (a_source.name.length + 4)
				l_name.append ("get_")
				l_name.append (a_source.name)
				a_property_getter.set_name (l_name)
				a_property_getter.set_implemented_type_name (current_type.name)
				a_property_getter.set_type_feature (Get_property_string)
				
				l_comments := a_source.comments
				if l_comments /= Void then
					from
						i := 0
						l_count := l_comments.count
					until
						i = l_count
					loop
						code_dom_generator.generate_statement_from_dom (l_comments.item (i))
						l_comment ?= last_statement
						if l_comment /= Void then
							a_property_getter.add_comment (l_comment)
						else
							(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Failed_assignment_attempt, ["ECDP_STATEMENT", "ECDP_COMMENT", "property getter initialization"])
						end
						i := i + 1
					end
				end
	
				l_statements := a_source.get_statements
				if l_statements /= Void then
					from
						i := 0
						l_count := l_statements.count
					until
						i = l_statements.count
					loop
						code_dom_generator.generate_statement_from_dom (l_statements.item (i))
						a_property_getter.add_statement (last_statement)
						i := i + 1
					end
				else
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_statements, ["property getter initialization"])
				end
	
				if a_source.type /= Void then
					code_dom_generator.generate_type_reference_from_dom (a_source.type)
					a_property_getter.set_returned_type (last_return_type.name)
					a_property_getter.set_is_array_returned_type (a_source.type.array_element_type /= Void)
				else
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_return_type, ["property getter initialization"])
				end
	
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

	initialize_property_setter (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY; a_property_setter: ECDP_PROPERTY_SETTER) is
			-- Set `a_property_setter' according to `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_property_setter: a_property_setter /= Void
		local
			i, l_count: INTEGER
			l_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
			l_comment: ECDP_COMMENT
			l_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			l_arguments: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION
			l_argument_expression: ECDP_PARAMETER_DECLARATION_EXPRESSION
			l_name: STRING
		do
			if current_type = Void then
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_type, ["property setter initialization"])
			else
				create l_name.make (a_source.name.length + 4)
				l_name.append ("set_")
				l_name.append (a_source.name)
				a_property_setter.set_name (l_name)
				a_property_setter.set_implemented_type_name (current_type.name)
				a_property_setter.set_type_feature (Set_property_string)
				
				if l_comments /= Void then
					l_comments := a_source.comments
					from
						i := 0
						l_count := l_comments.count
					until
						i = l_count
					loop
						code_dom_generator.generate_statement_from_dom (l_comments.item (i))
						l_comment ?= last_statement
						if l_comment /= Void then
							a_property_setter.add_comment (l_comment)
						else
							(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Failed_assignment_attempt, ["ECDP_STATEMENT", "ECDP_COMMENT", "property setter initialization"])
						end
						i := i + 1
					end
				end
	
				l_statements := a_source.set_statements
				if l_statements /= Void then
					from
						i := 0
						l_count := l_statements.count
					until
						i = l_count
					loop
						code_dom_generator.generate_statement_from_dom (l_statements.item (i))
						a_property_setter.add_statement (last_statement)
						i := i + 1
					end
				else
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_statements, ["property setter initialization"])
				end
	
				if a_source.type /= Void then
					code_dom_generator.generate_type_reference_from_dom (a_source.type)
					a_property_setter.set_property_type_name (last_return_type.name)
				else
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_return_type, ["property setter initialization"])
				end
	
				l_arguments := a_source.parameters
				if l_arguments /= Void then
					from
						i := 0
						l_count := l_arguments.count
					until
						i = l_count
					loop
						code_dom_generator.generate_expression_from_dom (l_arguments.item (i))
						l_argument_expression ?= last_expression
						if l_argument_expression /= Void then
							a_property_setter.add_argument (l_argument_expression)
						else
							(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Failed_assignment_attempt, ["ECDP_EXPRESSION", "ECDP_PARAMETER_DECLARATION_EXPRESSION", "property setter initialization"])
						end
						i := i + 1
					end
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

	initialise_function (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_function: ECDP_FUNCTION) is
			-- | Set `type_feature' with `Status_report' if return type is BOOLEAN 
			-- | else Set `type_feature' with `Access' 
			-- | Call `generate_argument_result'
			-- | Add `a_creation_routine' to `current_type'
			-- | Call `initialize_routine'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_function: a_function /= Void
		do
			if Object_boolean.is_equal (a_source.return_type.base_type) then
				a_function.set_type_feature (Status_report)
			else
				a_function.set_type_feature (Implementation)
			end
			generate_argument_result (a_source, a_function)
			current_type.add_feature (a_function)
			initialize_routine (a_source, a_function)
		ensure
		 	function_ready: a_function.ready
		end	
	
	initialize_routine (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; a_routine: ECDP_ROUTINE) is
			-- | set name of `a_routine'
			-- | Set `implemented_type' with `current_type'
			-- | Call `generate_feature_clause'.
			-- | Call `generate_comments' if any.
			-- | Use `eg_generated_types' to set implemented_type.			
			-- | Call `generate_arguments' if any.
			-- | Call `generate_statements' if any.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_routine: a_routine /= Void
		local
			routine_name: STRING
		do
			
--			if Initialize_component_dotnet_name.is_equal (a_source.name) then
--					-- We need to temporarily InitializeComponent to initialize_component
--					-- This needs to be set back at end of routine
--				a_source.set_name (Initialize_component_eiffel_name)
--			end
			
			create routine_name.make_from_cil (a_source.name)
			a_routine.set_name (routine_name)
		
			a_routine.set_implemented_type_name (current_type.name)

			if a_source.user_data.contains (From_eiffel_code_key) then
				a_routine.set_from_eiffel (True)
			else
					-- If we are a new feature then we want name to be in lower case
				a_routine.set_name (routine_name.as_lower)
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
				generate_statements (a_source, a_routine)	
			end

			generate_feature_clause (a_source, a_routine)
			
--			if Initialize_component_eiffel_name.is_equal (a_source.name) then
--					-- We need to set back to InitializeComponent as this can be passed back to the Designer
--				a_source.set_name (Initialize_component_dotnet_name)
--			end
		ensure
			routine_ready: a_routine.ready
		end

feature {NONE} -- Implementation

	generate_arguments (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; routine: ECDP_ROUTINE) is
			-- | Call in loop to corresponding `generate_expression_from_dom'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_routine: routine /= Void
		local
			i: INTEGER
			arguments: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION
			an_argument: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
			argument_expression: ECDP_PARAMETER_DECLARATION_EXPRESSION
		do
			arguments := a_source.parameters
			from
			until
				arguments = Void or else
				i = arguments.count					
			loop
				an_argument := arguments.item (i)
				if an_argument /= Void then
					code_dom_generator.generate_expression_from_dom (an_argument)
					argument_expression ?= last_expression
					if argument_expression /= Void then
						routine.add_argument (argument_expression)
					end
				end
				i := i + 1
			end
		end	

	generate_argument_result (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; function: ECDP_FUNCTION) is
			-- | Call `generate_expression_from_dom'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_function: function /= Void
		local
			a_return_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			a_return_type := a_source.return_type
			code_dom_generator.generate_type_reference_from_dom (a_return_type)
			function.set_returned_type (last_return_type.name)
			
			if a_source.return_type.array_element_type /= Void then
				function.set_is_array_returned_type (True)
			end
		end	

	generate_statements (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD; routine: ECDP_ROUTINE) is
			-- | Call in loop to corresponding `generate_statement_from_dom'.

			-- Generate routine statements from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_routine: routine /= Void
		local
			i: INTEGER
			statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			a_statement: SYSTEM_DLL_CODE_STATEMENT
			a_declaration_variable_statement: ECDP_VARIABLE_DECLARATION_STATEMENT
			a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT
		do
			statements := a_source.statements
			from
			until
				statements = Void or else
				i = statements.count					
			loop
				a_statement := statements.item (i)
				if a_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_statement)
					a_declaration_variable_statement ?= last_statement
					a_try_catch_statement ?= last_statement
					if a_declaration_variable_statement /= Void then
						routine.add_local (a_declaration_variable_statement)
						routine.add_statement (a_declaration_variable_statement)
					elseif a_try_catch_statement /= Void then
						initialize_try_catch_feature (a_try_catch_statement, routine)
					else
						routine.add_statement (last_statement)
					end
				end
				i := i + 1
			end
		end

	initialize_try_catch_feature (a_try_catch_statement: ECDP_TRY_CATCH_FINALLY_STATEMENT; a_routine: ECDP_ROUTINE) is
			-- Add a feature to current type, and call this feature from current statement.
		require
			non_void_a_try_catch_statement: a_try_catch_statement /= Void
			non_void_a_routine: a_routine /= Void
		local
			l_feature_name: STRING
			a_rescue_feature: ECDP_ROUTINE
			l_snippet_value: STRING
			a_snippet_statement: ECDP_SNIPPET_STATEMENT
			first_argument: BOOLEAN
		do
			l_feature_name := "try_catch_" + current_routine.name

				-- Creation try catch statement.
			create a_rescue_feature.make
			a_rescue_feature.set_name (l_feature_name)
			l_snippet_value := l_feature_name

			a_rescue_feature.add_feature_clause ("NONE")
			a_rescue_feature.set_type_feature ("Rescued features.")
				-- Add arguments
			from
				current_routine.arguments.start
				first_argument := True
			until
				current_routine.arguments.after
			loop
				if first_argument then
					l_snippet_value.append (" (")
					first_argument := False
				else
					l_snippet_value.append (", ")
				end
				l_snippet_value.append (current_routine.arguments.item.name)
				a_rescue_feature.add_argument (current_routine.arguments.item)
				current_routine.arguments.forth
			end
			if not first_argument then
				l_snippet_value.append (")")
			end

				-- Add local variables
			from
				current_routine.locals.start
			until
				current_routine.locals.after
			loop
				a_rescue_feature.add_local (current_routine.locals.item)
				current_routine.locals.forth
			end
			a_rescue_feature.add_statement (a_try_catch_statement)

			check
				non_void_current_type: current_type /= Void
			end
			current_type.add_feature (a_rescue_feature)

				-- Add call to try_catch feature.
			create a_snippet_statement.make
			a_snippet_statement.set_value (l_snippet_value)
			a_routine.add_statement (a_snippet_statement)
		end

feature {NONE} -- Implementation

	Return_type_void: STRING is "System.Void"
			-- `System.Void' .NET type name

	Object_boolean: STRING is "System.Boolean"
			-- `System.Boolean' .NET type name

end -- class ECDP_ROUTINE_FACTORY

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