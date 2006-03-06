indexing
	description: "Code generator for argument expressions"
	date: "$$"
	revision: "$$"		

class
	CODE_ARGUMENT_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_argument_reference_expression (a_source: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_name: STRING
			l_routine: CODE_ROUTINE
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_variable: CODE_VARIABLE_REFERENCE
		do
			if a_source.parameter_name /= Void then
				l_name := a_source.parameter_name
			end
			if l_name /= Void then
				l_routine := current_routine
				if l_routine /= Void then	
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
					if l_variable /= Void then
						set_last_expression (create {CODE_ARGUMENT_REFERENCE_EXPRESSION}.make (l_variable))
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_argument, [l_name, current_context])
					end
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Wrong_feature_kind, [current_context])
					set_last_expression (Empty_expression)
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_argument_name, [current_context])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end			

	generate_parameter_declaration_expression (a_source: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_variable: CODE_VARIABLE_REFERENCE
		do
			if a_source.name /= Void then
				if a_source.type /= Void then
					create l_variable.make (a_source.name, Type_reference_factory.type_reference_from_reference (a_source.type), Type_reference_factory.type_reference_from_code (current_type))
					set_last_expression (create {CODE_PARAMETER_DECLARATION_EXPRESSION}.make (l_variable, direction_from_dom (a_source.direction)))
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_argument_type, [a_source.name, current_context])
					set_last_expression (Empty_expression)
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_argument_name, [current_context])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end			

end -- class CODE_ARGUMENT_EXPRESSION_FACTORY

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