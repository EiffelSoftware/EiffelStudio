indexing
	description: "Code generator for expressions"
	date: "$$"
	revision: "$$"		
	
class
	ECD_EXPRESSION_FACTORY

inherit
	ECD_FACTORY

	EXCEPTIONS
		export
			{NONE} all
		end

	ECD_CODE_GENERATOR_CONSTANTS
		export
			{NONE} all
		end

feature {ECD_CONSUMER_FACTORY} -- Visitor features.

	generate_base_reference_expression (a_source: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_BASE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.
			-- | NOT SUPPORTED YET !!!

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_base_reference_expression: ECD_BASE_REFERENCE_EXPRESSION
		do
			(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Not_implemented, ["base reference expression"])
			create a_base_reference_expression.make
			initialize_base_reference_expression (a_source, a_base_reference_expression)
			set_last_expression (a_base_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_binary_operator_expression (a_source: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION) is
			-- | Create instance of `EG_BINARY_OPERATOR_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_binary_operator_expression: ECD_BINARY_OPERATOR_EXPRESSION
		do
			create a_binary_operator_expression.make
			initialize_binary_operator_expression (a_source, a_binary_operator_expression)
			set_last_expression (a_binary_operator_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_cast_expression (a_source: SYSTEM_DLL_CODE_CAST_EXPRESSION) is
			-- | Create instance of `EG_CAST_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_cast_expression: ECD_CAST_EXPRESSION
		do
			create a_cast_expression.make
			initialize_cast_expression (a_source, a_cast_expression)
			set_last_expression (a_cast_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_direction_expression (a_source: SYSTEM_DLL_CODE_DIRECTION_EXPRESSION) is
			-- | Create instance of `ECD_DIRECTION_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.
			-- | NOT SUPPORTED YET !!

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_direction_expression: ECD_DIRECTION_EXPRESSION
		do
			create a_direction_expression.make
			initialize_direction_expression (a_source, a_direction_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_event_reference_expression (a_source: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_EVENT_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.
			-- | NOT SUPPORTED YET !!!

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_event_reference_expression: ECD_EVENT_REFERENCE_EXPRESSION
		do
			create an_event_reference_expression.make
			initialize_event_reference_expression (a_source, an_event_reference_expression)
			set_last_expression (an_event_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_attribute_reference_expression (a_source: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_ATTRIBUTE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_attribute_reference_expression: ECD_ATTRIBUTE_REFERENCE_EXPRESSION
		do
			create an_attribute_reference_expression.make
			initialize_attribute_reference_expression (a_source, an_attribute_reference_expression)
			set_last_expression (an_attribute_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_indexer_expression (a_source: SYSTEM_DLL_CODE_INDEXER_EXPRESSION) is
			-- | Create instance of `EG_INDEXER_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_indexer_expression: ECD_INDEXER_EXPRESSION
		do
			create an_indexer_expression.make
			initialize_indexer_expression (a_source, an_indexer_expression)
			set_last_expression (an_indexer_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_object_create_expression (a_source: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `EG_OBJECT_CREATE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_object_create_expression: ECD_OBJECT_CREATE_EXPRESSION
		do
			create an_object_create_expression.make
			initialize_object_create_expression (a_source, an_object_create_expression)
			set_last_expression (an_object_create_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_primitive_expression (a_source: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION) is
			-- | Create instance of `EG_PRIMITIVE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_primitive_expression: ECD_PRIMITIVE_EXPRESSION
		do
			create a_primitive_expression.make
			initialize_primitive_expression (a_source, a_primitive_expression)
			set_last_expression (a_primitive_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_snippet_expression (a_source: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION) is
			-- | Create instance of `EG_SNIPPET_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_snippet_expression: ECD_SNIPPET_EXPRESSION
		do
			create a_snippet_expression.make
			initialize_snippet_expression (a_source, a_snippet_expression)
			set_last_expression (a_snippet_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_this_reference_expression (a_source: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_THIS_REFERENCE_EXPRESSION'.
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_this_reference_expression: ECD_THIS_REFERENCE_EXPRESSION
		do
			create a_this_reference_expression.make
			set_last_expression (a_this_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_type_of_expression (a_source: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION) is
			-- | Create instance of `EG_TYPE_OF_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.
			-- | NOT SUPPORTED YET !!!

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_type_of_expression: ECD_TYPE_OF_EXPRESSION
		do
			create a_type_of_expression.make
			initialize_type_of_expression (a_source, a_type_of_expression)
			set_last_expression (a_type_of_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_type_reference_expression (a_source: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_TYPE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_type_reference_expression: ECD_TYPE_REFERENCE_EXPRESSION
		do
			create a_type_reference_expression.make
			initialize_type_reference_expression (a_source, a_type_reference_expression)
			set_last_expression (a_type_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_variable_reference_expression (a_source: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_VARIABLE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_variable_reference_expression: ECD_VARIABLE_REFERENCE_EXPRESSION
		do
			create a_variable_reference_expression.make
			initialize_variable_reference_expression (a_source, a_variable_reference_expression)
			set_last_expression (a_variable_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

feature {NONE} -- Implementation

	initialize_base_reference_expression (a_source: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION; a_base_reference_expression: ECD_BASE_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_last_expression: last_expression /= Void
		do
			(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Not_implemented, ["base reference expression"])
		end

	initialize_binary_operator_expression (a_source: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION; a_binary_operator_expression: ECD_BINARY_OPERATOR_EXPRESSION) is
			-- | Call `generate_expression_from_dom' to generate `left_operand'.
			-- | Set `operator'.
			-- | Call `generate_expression_from_dom' to generate `right_operand'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_binary_operator_expression: a_binary_operator_expression /= Void
		local
			left_operator_expression: SYSTEM_DLL_CODE_EXPRESSION
			right_operator_expression: SYSTEM_DLL_CODE_EXPRESSION
			operator: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE
		do
			operator := a_source.operator
			a_binary_operator_expression.set_operator (operator)

			left_operator_expression := a_source.left
			code_dom_generator.generate_expression_from_dom (left_operator_expression)
			a_binary_operator_expression.set_left_operand (last_expression)

			right_operator_expression := a_source.right
			code_dom_generator.generate_expression_from_dom (right_operator_expression)
			a_binary_operator_expression.set_right_operand (last_expression)
		end

	initialize_cast_expression (a_source: SYSTEM_DLL_CODE_CAST_EXPRESSION; a_cast_expression : ECD_CAST_EXPRESSION) is
			-- | Call `generate_expression_from_dom' to set `expression'.
			-- | Set `target_type' by using `eg_generated_types'.
			-- | Add local variable with same type as `target_type'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_cast_expression: a_cast_expression /= Void
		local
			an_expression_to_cast: SYSTEM_DLL_CODE_EXPRESSION
			a_type_to_cast: SYSTEM_DLL_CODE_TYPE_REFERENCE
			
			l_assignment_attempt_statement: ECD_ASSIGNMENT_ATTEMPT_STATEMENT
			l_local_variable_name: STRING
			l_local_variable: ECD_VARIABLE_DECLARATION_STATEMENT
			l_snippet_expression: ECD_SNIPPET_EXPRESSION
		do
			if current_type = Void then
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Not_implemented, ["base reference expression"])
			end

			a_type_to_cast := a_source.target_type
			code_dom_generator.generate_type_reference_from_dom (a_type_to_cast)
			a_cast_expression.set_target_type (last_return_type.name)
			
			an_expression_to_cast := a_source.expression
			code_dom_generator.generate_expression_from_dom (an_expression_to_cast)
			a_cast_expression.set_expression_to_cast (last_expression)
			
				-- Add a assignent attent if current statement is not an affectation statement.
			create l_local_variable.make
			l_local_variable_name := cast_local_variable_name
			l_local_variable.set_name (l_local_variable_name)
			l_local_variable.set_dotnet_type (last_return_type.name)
			current_routine.add_local (l_local_variable)
			create l_assignment_attempt_statement.make
			l_assignment_attempt_statement.set_expression_to_cast (last_expression)
			l_assignment_attempt_statement.set_target_object (l_local_variable_name)
			current_routine.add_statement (l_assignment_attempt_statement)

			create l_snippet_expression.make
			l_snippet_expression.set_value (l_local_variable_name)
			a_cast_expression.set_expression_to_cast (l_snippet_expression)
		end

	cast_local_variable_name: STRING is
			-- cast local variable name.
		do
			create Result.make_from_string (Cast_expr_local)
			Result.append (Resolver.cast_variable_suffix)
			Resolver.increase_cast_variable_suffix
		ensure
			non_void_cast_local_variable_name: Result /= Void
			not_empty_cast_local_variable_name: not Result.is_empty
		end

	initialize_direction_expression (a_source: SYSTEM_DLL_CODE_DIRECTION_EXPRESSION; a_direction_expression: ECD_DIRECTION_EXPRESSION) is

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_direction_expression: a_direction_expression /= Void
		do
			a_direction_expression.set_byref (a_source.direction = feature {SYSTEM_DLL_FIELD_DIRECTION}.out or a_source.direction = feature {SYSTEM_DLL_FIELD_DIRECTION}.ref)
			code_dom_generator.generate_expression_from_dom (a_source.expression)
			a_direction_expression.set_expression (last_expression)
		end

	initialize_event_reference_expression (a_source: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION; an_event_reference_expression: ECD_EVENT_REFERENCE_EXPRESSION) is
			-- | Set `name', `target_object'.

			-- Generate Eiffel code from `a_source'.		
		require
			non_void_source: a_source /= Void
			non_void_event_reference_expression: an_event_reference_expression /= Void
		do
			an_event_reference_expression.set_event_name (a_source.event_name)
			code_dom_generator.generate_expression_from_dom (a_source.target_object)
			an_event_reference_expression.set_target_object (last_expression)
		ensure
			event_reference_expression_ready: an_event_reference_expression.ready
		end

	initialize_attribute_reference_expression (a_source: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION; an_attribute_reference_expression: ECD_ATTRIBUTE_REFERENCE_EXPRESSION) is
			-- | Call `GetType' on target object to have CodeDom name of type in which attribute is defined.
			-- | Use `eg_generated_types' to get corresponding `EG_GENERATED_TYPE'.
			-- | Generate hash value from CodeDom attribute name.
			-- | Get `EG_ATTRIBUTE' (with Eiffel name) using `eg_attributes' in `EG_GENERATED_TYPE'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_attribute_reference_expression: an_attribute_reference_expression /= Void
		local			
			target: SYSTEM_DLL_CODE_EXPRESSION
		do
			an_attribute_reference_expression.set_attribute_name (a_source.field_name)

			target := a_source.target_object
			if target /= Void then
				code_dom_generator.generate_expression_from_dom (target)
				an_attribute_reference_expression.set_target_object (last_expression)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_target_object, ["attribute reference expression"])
			end
			
			if current_namespace /= Void then
				an_attribute_reference_expression.set_current_namespace (current_namespace.name)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_current_namespace, ["attribute reference expression"])
			end
			if current_type /= Void then
				an_attribute_reference_expression.set_current_class (current_type.name)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["attribute reference expression"])
			end
		ensure
			attribute_reference_expression_ready: an_attribute_reference_expression.ready
		end

	initialize_indexer_expression (a_source: SYSTEM_DLL_CODE_INDEXER_EXPRESSION; an_indexer_expression: ECD_INDEXER_EXPRESSION) is
			-- | Get type from target object and retrieve `EG_GENERATED_TYPE' using `eg_generated_types' with CodeDom type name.
			-- | Call `item' or `put' (or equivalent feature of the type) with appropriate indice.
			-- | Support only one indice at the moment.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_indexer_expression: an_indexer_expression /= Void
		local
			i: INTEGER			
			target: SYSTEM_DLL_CODE_EXPRESSION
			indices: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
		do
			if current_type /= Void then
				target := a_source.target_object
				if target /= Void then
					code_dom_generator.generate_expression_from_dom (target)
					an_indexer_expression.set_target_object (last_expression)
				end
				
				indices := a_source.indices
				from
				until
					i = indices.count
				loop
					code_dom_generator.generate_expression_from_dom (indices.item (i))
					an_indexer_expression.add_indice (last_expression)
					i := i + 1
				end
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_current_type, ["indexer expression"])
			end
		end

	initialize_object_create_expression (a_source: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION; an_object_create_expression: ECD_OBJECT_CREATE_EXPRESSION) is
			-- | Retrieve object type name and get `EG_GENERATED_TYPE' from `eg_generated_types'.
			-- | Search on `creation_routines' to find routines matching the arguments given.
			-- | If several matching, choose the first possible creation routine.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_object_create_expression: an_object_create_expression /= Void
		local
			create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
			create_type_name: STRING
		do
			create_type := a_source.create_type
			if create_type /= Void then
				code_dom_generator.generate_type_reference_from_dom (create_type)
				create create_type_name.make_from_cil (create_type.base_type)
				an_object_create_expression.set_target_type (create_type_name)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_creation_type, ["object create expression"])
			end
			generate_creation_arguments (a_source, an_object_create_expression)
			an_object_create_expression.set_constructor_name ("make")
		end		

	generate_creation_arguments (a_source: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION; an_object_create_expression: ECD_OBJECT_CREATE_EXPRESSION) is
			-- | Call in loop to `generate_expression_from_dom'.

			-- Generate arguments for object creation routine.
		require
			non_void_source: a_source /= Void
			non_void_object_create_expression: an_object_create_expression /= Void
		local
			i: INTEGER
			l_parameters: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
		do
			l_parameters := a_source.parameters
			if l_parameters /= Void then
				from
				until
					i = l_parameters.count
				loop
					code_dom_generator.generate_expression_from_dom (l_parameters.item (i))
					an_object_create_expression.add_argument (last_expression)
					i := i + 1
				end
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_parameters, ["object create expression"])
			end
		end

	initialize_primitive_expression (a_source: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION; a_primitive_expression: ECD_PRIMITIVE_EXPRESSION) is
			-- | Set `value'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_primitive_expression: a_primitive_expression /= Void
		do
			a_primitive_expression.set_value (a_source.value)
		end

	initialize_snippet_expression (a_source: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION; a_snippet_expression: ECD_SNIPPET_EXPRESSION) is
			-- | Set `value'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_snippet_expression: a_snippet_expression /= Void
		do
			a_snippet_expression.set_value (a_source.value)
		end

	initialize_type_of_expression (a_source: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION; a_type_of_expression: ECD_TYPE_OF_EXPRESSION) is
			-- | NOT SUPPORTED YET !!

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_type_of_expression: a_type_of_expression /= Void
		local			
			a_type_name: STRING
		do
			(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Not_implemented, ["typeof expression"])
			create a_type_name.make_from_cil (a_source.type.base_type)
			if not Resolver.is_generated_type (a_type_name) then
				Resolver.add_external_type (a_type_name)
			end
			a_type_of_expression.set_target (a_type_name)
		end

	initialize_type_reference_expression (a_source: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION; a_type_reference_expression: ECD_TYPE_REFERENCE_EXPRESSION) is
			-- | Use `eg_generated_types' to set `type' if already built, else
			-- | build `EG_TYPE' and put it in the `eg_types' table.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_type_reference_expression: a_type_reference_expression /= Void
		local			
			a_type_name: STRING
		do
			create a_type_name.make_from_cil (a_source.type.base_type)
			if not Resolver.is_generated_type (a_type_name) then
				Resolver.add_external_type (a_type_name)
			end
			a_type_reference_expression.set_referred_type (a_type_name)
		ensure
			type_reference_expression_ready: a_type_reference_expression.ready
		end

	initialize_variable_reference_expression (a_source: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION; a_variable_reference_expression: ECD_VARIABLE_REFERENCE_EXPRESSION) is
			-- | Set `variable_name'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_variable_reference_expression: a_variable_reference_expression /= Void
		do
			a_variable_reference_expression.set_variable_name (a_source.variable_name)
		ensure
			variable_reference_expression_ready: a_variable_reference_expression.ready
		end

end -- class ECD_EXPRESSION_FACTORY

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