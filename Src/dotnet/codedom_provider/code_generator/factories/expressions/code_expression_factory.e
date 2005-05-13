indexing
	description: "Code generator for expressions"
	date: "$$"
	revision: "$$"		
	
class
	CODE_EXPRESSION_FACTORY

inherit
	CODE_FACTORY

	EXCEPTIONS
		export
			{NONE} all
		end

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_base_reference_expression (a_source: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_base_reference_expression: CODE_BASE_REFERENCE_EXPRESSION
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.Not_implemented, ["base reference expression"])
			create a_base_reference_expression.make
			set_last_expression (a_base_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_binary_operator_expression (a_source: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			left_operator_expression: SYSTEM_DLL_CODE_EXPRESSION
			right_operator_expression: SYSTEM_DLL_CODE_EXPRESSION
			left_operand: CODE_EXPRESSION
		do
			left_operator_expression := a_source.left
			if left_operator_expression /= Void then
				right_operator_expression := a_source.right
				if right_operator_expression /= Void then
					code_dom_generator.generate_expression_from_dom (left_operator_expression)
					left_operand := last_expression		
					code_dom_generator.generate_expression_from_dom (right_operator_expression)
					set_last_expression (create {CODE_BINARY_OPERATOR_EXPRESSION}.make (left_operand, last_expression, a_source.operator))
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_right_operand, [current_context])
					set_last_expression (Empty_expression)
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_left_operand, [current_context])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_cast_expression (a_source: SYSTEM_DLL_CODE_CAST_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			if current_routine /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.expression)
				current_routine.add_cast_local (last_expression, Type_reference_factory.type_reference_from_reference (a_source.target_type))
				set_last_expression (create {CODE_CAST_EXPRESSION}.make (Type_reference_factory.type_reference_from_reference (a_source.target_type), current_routine.last_cast_variable))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_routine, ["cast expression"])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_direction_expression (a_source: SYSTEM_DLL_CODE_DIRECTION_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_direction: INTEGER
		do
			code_dom_generator.generate_expression_from_dom (a_source.expression)
			l_direction := direction_from_dom (a_source.direction)
			set_last_expression (create {CODE_DIRECTION_EXPRESSION}.make (last_expression, (l_direction = out_argument) or (l_direction = inout_argument)))
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_event_reference_expression (a_source: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			code_dom_generator.generate_expression_from_dom (a_source.target_object)
			set_last_expression (create {CODE_EVENT_REFERENCE_EXPRESSION}.make (a_source.event_name, last_expression))
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_attribute_reference_expression (a_source: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_target: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_target := a_source.target_object
			if l_target /= Void then
				code_dom_generator.generate_expression_from_dom (l_target)
				set_last_expression (create {CODE_ATTRIBUTE_REFERENCE_EXPRESSION}.make (a_source.field_name, last_expression))
			else
				set_last_expression (Empty_expression)
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_target_object, ["attribute reference expression in" + current_context])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_indexer_expression (a_source: SYSTEM_DLL_CODE_INDEXER_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_target: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_target := a_source.target_object
			if l_target /= Void then
				code_dom_generator.generate_expression_from_dom (l_target)
				set_last_expression (create {CODE_INDEXER_EXPRESSION}.make (last_expression, expressions_from_collection (a_source.indices)))
			else
				set_last_expression (Empty_expression)
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_target_object, ["indexer expression in " + current_context])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_object_create_expression (a_source: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			l_type := a_source.create_type
			if l_type /= Void then
				set_last_expression (create {CODE_OBJECT_CREATE_EXPRESSION}.make (Type_reference_factory.type_reference_from_reference (l_type), expressions_from_collection (a_source.parameters)))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_creation_type, ["object create expression"])
			end
		end	

	generate_primitive_expression (a_source: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			set_last_expression (create {CODE_PRIMITIVE_EXPRESSION}.make (a_source.value))
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_snippet_expression (a_source: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			set_last_expression (create {CODE_SNIPPET_EXPRESSION}.make (a_source.value))
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_this_reference_expression (a_source: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_this_reference_expression: CODE_THIS_REFERENCE_EXPRESSION
		do
			if current_type /= Void then
				create a_this_reference_expression.make (current_type)
				set_last_expression (a_this_reference_expression)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_type, ["This reference expression generation in " + current_context])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end	

	generate_type_of_expression (a_source: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			set_last_expression (create {CODE_TYPE_OF_EXPRESSION}.make (Type_reference_factory.type_reference_from_reference (a_source.type)))
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_type_reference_expression (a_source: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			set_last_expression (create {CODE_TYPE_REFERENCE_EXPRESSION}.make (Type_reference_factory.type_reference_from_reference (a_source.type)))
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_variable_reference_expression (a_source: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_routine: CODE_ROUTINE
			l_locals: LIST [CODE_VARIABLE]
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_variable: CODE_VARIABLE_REFERENCE
			l_name: STRING
		do
			l_name := a_source.variable_name
			if l_name /= Void then
				l_routine ?= current_feature
				if l_routine /= Void then
					l_locals := l_routine.locals
					from
						l_locals.start
					until
						l_locals.after or l_variable /= Void
					loop
						if l_locals.item.variable.name.is_equal (l_name) then
							l_variable := l_locals.item.variable
						end
						l_locals.forth
					end
					if l_variable = Void then
						l_arguments := l_routine.arguments
						from
							l_arguments.start
						until
							l_arguments.after or l_variable /= Void
						loop
							if l_arguments.item.variable.name.is_equal (l_name) then
								l_variable := l_arguments.item.variable
							end
							l_arguments.forth
						end
					end
					if l_variable /= Void then
						set_last_expression (create {CODE_VARIABLE_REFERENCE_EXPRESSION}.make (l_variable))
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_variable, [l_name, current_context])
						set_last_expression (Empty_expression)
					end
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Wrong_feature_kind, [current_context])
					set_last_expression (Empty_expression)
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_variable_name, [current_context])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

feature {NONE} -- Implementation

	expressions_from_collection (a_collection: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION): LIST [CODE_EXPRESSION] is
			-- Convert `a_collection' into a list of {CODE_EXPRESSION} instances
		local
			i, l_count: INTEGER
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			if a_collection /= Void then
				from
					l_count := a_collection.count
					create {ARRAYED_LIST [CODE_EXPRESSION]} Result.make (l_count)
				until
					i = l_count
				loop
					l_expression := a_collection.item (i)
					if l_expression /= Void then
						code_dom_generator.generate_expression_from_dom (l_expression)
						Result.extend (last_expression)
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_expression, [current_context])
					end
					i := i + 1
				end
			end
		end

end -- class CODE_EXPRESSION_FACTORY

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