indexing
	description: "Code generator for argument expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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