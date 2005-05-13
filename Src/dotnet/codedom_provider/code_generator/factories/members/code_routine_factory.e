indexing
	description: "Code generator for type methods and properties"
	date: "$Date$"
	revision: "$Revision$"
	
class
	CODE_ROUTINE_FACTORY

inherit
	CODE_MEMBER_FACTORY
	
	CODE_SHARED_CONTEXT
		export
			{NONE} all
		end

	CODE_USER_DATA_KEYS
		export
			{NONE} all
		end

	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		end

	CODE_DIRECTIONS
		export
			{NONE} all
		end
	
feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_routine (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_routine: CODE_ROUTINE_IMP
			l_member: CODE_MEMBER_REFERENCE
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_type: CODE_TYPE_REFERENCE
			l_parent: CODE_MEMBER_REFERENCE
		do
			if current_type /= Void then
				l_arguments := code_arguments (a_source.parameters)
				l_type := Type_reference_factory.type_reference_from_code (current_type)
				l_member := l_type.member (a_source.name, l_arguments)
				check
					exists: l_member /= Void
				end
				create l_routine.make (a_source.name, l_member.eiffel_name)
				if a_source.user_data /= Void and then a_source.user_data.contains (From_eiffel_code_key) then
					l_routine.set_eiffel_name (a_source.name)
				end
				if l_member.is_redefined then
					l_routine.set_redefined (True)
					l_parent := l_member.parent
					if l_parent /= Void then
						current_type.add_redefine_clause (l_parent.implementing_type, l_member)
					end
				end
				l_routine.set_arguments (l_arguments)
				set_current_feature (l_routine)
				initialize_routine (a_source)
				current_type.add_feature (l_routine)
				set_current_feature (Void)
				set_last_feature (l_routine)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, [current_context])
				set_last_feature (Empty_routine)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end
		
	generate_creation_routine (a_source: SYSTEM_DLL_CODE_CONSTRUCTOR) is
			-- Generate Eiffel code from `a_source'.
			-- | Create instance of `CODE_CREATION_ROUTINE'.
			-- | Set `current_feature'.
			-- | And initialize this instance with `a_source' -> Call `initialize_creation_routine'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.
		require
			non_void_source: a_source /= Void
		local
			l_creation_routine: CODE_CREATION_ROUTINE
			l_member: CODE_MEMBER_REFERENCE
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_type: CODE_TYPE_REFERENCE
			l_parent: CODE_MEMBER_REFERENCE
		do
			if current_type /= Void then
				l_arguments := code_arguments (a_source.parameters)
				l_type := Type_reference_factory.type_reference_from_code (current_type)
				l_member := l_type.member (a_source.name, l_arguments)
				check
					exists: l_member /= Void
				end
				create l_creation_routine.make (a_source.name, l_member.eiffel_name)
				if l_member.is_redefined then
					l_parent := l_member.parent
					if l_parent /= Void then
						current_type.add_redefine_clause (l_parent.implementing_type, l_member)
					end
				end
				l_creation_routine.set_arguments (l_arguments)
				l_creation_routine.set_feature_kind (Initialization)
				set_current_feature (l_creation_routine)
				initialize_routine (a_source)
				current_type.add_creation_routine (l_creation_routine)
				set_current_feature (Void)
				set_last_feature (l_creation_routine)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, [current_context])
				set_last_feature (Empty_routine)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end

	generate_root_procedure (a_source: SYSTEM_DLL_CODE_ENTRY_POINT_METHOD) is
			-- Generate Eiffel code from `a_source'.
			-- | Create instance of `CODE_ROOT_PROCEDURE'.
			-- | Set `current_feature'.
			-- | And initialise this instance with `a_source' -> Call `initialize_root_procedure'
			-- | Set `current_feature' to Void because there no more current feature
			-- | Set `last_feature'.
		require
			non_void_source: a_source /= Void
		local
			l_root_procedure: CODE_ROOT_PROCEDURE
			l_member: CODE_MEMBER_REFERENCE
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
		do
			if current_type /= Void then
				l_arguments := code_arguments (a_source.parameters)
				l_member := Type_reference_factory.type_reference_from_code (current_type).member (a_source.name, l_arguments)
				check
					exists: l_member /= Void
				end
				create l_root_procedure.make (a_source.name, l_member.eiffel_name)
				if a_source.user_data /= Void and then a_source.user_data.contains (From_eiffel_code_key) then
					l_root_procedure.set_eiffel_name (a_source.name)
				end
				l_root_procedure.set_arguments (l_arguments)
				set_current_feature (l_root_procedure)
				initialize_routine (a_source)
				l_root_procedure.set_feature_kind (Initialization)
				current_type.add_feature (l_root_procedure)
				current_type.add_feature (l_root_procedure)
				set_current_feature (Void)
				set_last_feature (l_root_procedure)

				Compilation_context.set_root_creation_routine_name (l_root_procedure.eiffel_name)
				Compilation_context.set_root_class_name (current_type.eiffel_name)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, [current_context])
				set_last_feature (Empty_routine)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end

	generate_property (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY) is
			-- | Create instance of `CODE_PROPERTY_ROUTINE' if has a get property.
			-- | Create instance of `CODE_PROPERTY_ROUTINE' if has a set property.
			-- | For each instance : Set `current_feature'.
			-- | Add `current_feature' to `current_type'.
			-- | Initialize current_feature.
			-- | Set `current_feature' to Void because there no more current feature.
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_property_getter, l_property_setter: CODE_ROUTINE_IMP
			l_getter, l_setter: CODE_MEMBER_REFERENCE
			l_getter_name, l_setter_name, l_name: STRING
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_argument_expression: CODE_PARAMETER_DECLARATION_EXPRESSION
			l_parent: CODE_MEMBER_REFERENCE
		do
			if current_type /= Void then
				l_name := a_source.name
				if l_name /= Void then
					l_arguments := code_arguments (a_source.parameters)
					if a_source.has_get then
						create l_getter_name.make (l_name.count + 4)
						l_getter_name.append ("get_")
						l_getter_name.append (l_name)
						l_getter := Type_reference_factory.type_reference_from_code (current_type).member (l_getter_name, l_arguments)
						check
							exists: l_getter /= Void
						end
						create l_property_getter.make (l_getter_name, l_getter.eiffel_name)
						if l_getter.is_redefined then
							l_property_getter.set_redefined (True)
							l_parent := l_getter.parent
							if l_parent /= Void then
								current_type.add_redefine_clause (l_parent.implementing_type, l_getter)
							end
						end
						l_property_getter.set_arguments (l_arguments)
						set_current_feature (l_property_getter)
						initialize_property_getter (a_source)
						current_type.add_feature (l_property_getter)
						set_last_feature (l_property_getter)
						set_current_feature (Void)
					end

					if a_source.has_set then
						create l_setter_name.make (l_name.count + 4)
						l_setter_name.append ("set_")
						l_setter_name.append (l_name)
						create l_argument_expression.make (create {CODE_VARIABLE_REFERENCE}.make ("value", Type_reference_factory.type_reference_from_reference (a_source.type), Type_reference_factory.type_reference_from_code (current_type)), in_argument)
						create {ARRAYED_LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]} l_arguments.make (1)
						l_arguments.extend (l_argument_expression)
						l_setter := Type_reference_factory.type_reference_from_code (current_type).member (l_setter_name, l_arguments)
						check
							exists: l_setter /= Void
						end
						create l_property_setter.make (l_setter_name, l_setter.eiffel_name)
						if l_setter.is_redefined then
							l_property_setter.set_redefined (True)
							l_parent := l_setter.parent
							if l_parent /= Void then
								current_type.add_redefine_clause (l_parent.implementing_type, l_setter)
							end
						end
						l_property_setter.set_arguments (l_arguments)
						set_current_feature (l_property_setter)
						initialize_property_setter (a_source)
						current_type.add_feature (l_property_setter)
						set_last_feature (l_property_setter)
						set_current_feature (Void)
					end
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature_name, [current_context])
					set_last_feature (Empty_routine)
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, [current_context])
				set_last_feature (Empty_routine)
			end
		end
	
feature {NONE} -- Routine Initialization

	initialize_property_getter (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY) is
			-- Set `a_property_getter' according to `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_property_getter: current_feature /= Void
		do
			if current_type = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, ["property getter initialization (" + current_context + ")"])
			else
				current_feature.set_feature_kind (Get_property_string)

				if a_source.comments /= Void then
					initialize_comments (a_source.comments)
				end

				current_feature.set_result_type (Type_reference_factory.type_reference_from_reference (a_source.type))
				initialize_member_status (a_source.attributes)

				if a_source.custom_attributes /= Void then
					initialize_custom_attributes (a_source.custom_attributes)
				end

				if a_source.private_implementation_type /= Void then
					current_feature.add_feature_clause (Type_reference_factory.type_reference_from_reference (a_source.private_implementation_type))
				end

				if a_source.get_statements /= Void then
					initialize_statements (a_source.get_statements)
				end
			end
		end

	initialize_property_setter (a_source: SYSTEM_DLL_CODE_MEMBER_PROPERTY) is
			-- Set `a_property_setter' according to `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_routine: current_routine /= Void
		do
			if current_type = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, ["property setter initialization"])
			else
				current_feature.set_feature_kind (Set_property_string)

				if a_source.comments /= Void then
					initialize_comments (a_source.comments)
				end

				current_feature.set_result_type (None_type_reference)
				initialize_member_status (a_source.attributes)

				if a_source.custom_attributes /= Void then
					initialize_custom_attributes (a_source.custom_attributes)
				end

				if a_source.private_implementation_type /= Void then
					current_feature.add_feature_clause (Type_reference_factory.type_reference_from_reference (a_source.private_implementation_type))
				end

				if a_source.set_statements /= Void then
					initialize_statements (a_source.set_statements)
				end
			end
		end

	initialize_routine (a_source: SYSTEM_DLL_CODE_MEMBER_METHOD) is
			-- Generate Eiffel code from `a_source'.
			-- | set name of `a_routine'
			-- | Set `implemented_type' with `current_type'
			-- | Call `generate_feature_inheritance_clause'.
			-- | Call `generate_comments' if any.
			-- | Use `eg_generated_types' to set implemented_type.			
			-- | Call `generate_arguments' if any.
			-- | Call `generate_statements' if any.
		require
			non_void_source: a_source /= Void
			non_void_routine: current_routine /= Void
		do
			initialize_member_status (a_source.attributes)

			if a_source.custom_attributes /= Void then
				initialize_custom_attributes (a_source.custom_attributes)
			end

			if a_source.private_implementation_type /= Void then
				current_routine.add_feature_clause (Type_reference_factory.type_reference_from_reference (a_source.private_implementation_type))
				current_feature.set_feature_kind (Implementation)
			else
				if a_source.return_type.base_type.equals (("System.Boolean").to_cil) then
					current_feature.set_feature_kind (Status_report)
				elseif a_source.return_type.base_type.equals (("System.Void").to_cil) then
					current_feature.set_feature_kind (Basic_operations)
				else
					current_feature.set_feature_kind (Access)
				end
			end

			current_feature.set_result_type (Type_reference_factory.type_reference_from_reference (a_source.return_type))

			if a_source.comments /= Void then
				initialize_comments (a_source.comments)
			end

			if a_source.statements /= Void then
				initialize_statements (a_source.statements)
			end
		end

feature {NONE} -- Implementation

	initialize_statements (a_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION) is
			-- | Call in loop `generate_statement_from_dom'.
			-- Generate feature statements from `a_source'.
			-- Take into account local variables.
		require
			non_void_routine: current_routine /= Void
			non_void_statements: a_statements /= Void
		local
			i, l_count: INTEGER
			l_var_decl_statement: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT
			l_statement: SYSTEM_DLL_CODE_STATEMENT
			l_var_decl_statements: ARRAYED_LIST [SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT]
		do
			from
				l_count := a_statements.count
				create l_var_decl_statements.make (l_count)
			until
				i = l_count
			loop
				l_statement := a_statements.item (i)
				l_var_decl_statement ?= l_statement
				if l_var_decl_statement /= Void then
					l_var_decl_statements.extend (l_var_decl_statement)
				end
				i := i + 1
			end
			-- We have to initialize locals first, otherwise local references
			-- won't be resolvable.
			initialize_locals (l_var_decl_statements)
			from
				i := 0
			until
				i = l_count
			loop
				code_dom_generator.generate_statement_from_dom (a_statements.item (i))
				if last_statement /= Void then
					current_routine.add_statement (last_statement)
				end
				i := i + 1
			end
		end

	initialize_locals (a_statements: LIST [SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT]) is
			-- Add local variables declared in code
		require
			non_void_statements: a_statements /= Void
			non_void_routine: current_routine /= Void
		do
			from
				a_statements.start
			until
				a_statements.after		
			loop
				if a_statements.item.name /= Void and a_statements.item.type /= Void then
					current_routine.add_local (create {CODE_VARIABLE}.make (create {CODE_VARIABLE_REFERENCE}.make (
						a_statements.item.name,
						Type_reference_factory.type_reference_from_reference (a_statements.item.type),
						Type_reference_factory.type_reference_from_code (current_type))))
				end
				a_statements.forth		
			end
		end

	code_arguments (a_arguments: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION): LIST [CODE_PARAMETER_DECLARATION_EXPRESSION] is
			-- Add arguments in `a_arguments' to `current_routine'.
		local
			i, l_count: INTEGER
			l_argument: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
			l_argument_expression: CODE_PARAMETER_DECLARATION_EXPRESSION
		do
			if a_arguments /= Void then
				from
					l_count := a_arguments.count
					create {ARRAYED_LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]} Result.make (l_count)
				until
					i = l_count					
				loop
					l_argument := a_arguments.item (i)
					if l_argument /= Void then
						code_dom_generator.generate_expression_from_dom (l_argument)
						l_argument_expression ?= last_expression
						if l_argument_expression /= Void then
							Result.extend (l_argument_expression)
						else
							Event_manager.raise_event ({CODE_EVENTS_IDS}.Failed_assignment_attempt, ["CODE_EXPRESSION", "CODE_ARGUMENT_EXPRESSION", "arguments generation of " + current_context])
						end
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Void_argument, [current_context])
					end
					i := i + 1
				end
			end
		end	

end -- class CODE_ROUTINE_FACTORY

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