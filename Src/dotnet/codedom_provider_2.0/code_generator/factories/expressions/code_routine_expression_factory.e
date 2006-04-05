indexing
	description: "Code generator for routine expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ROUTINE_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_routine_invoke_expression (a_source: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_ROUTINE_INVOKE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_invoke_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			l_routine: CODE_REFERENCE_EXPRESSION
		do
			l_expression := a_source.method
			if l_expression /= Void then
				code_dom_generator.generate_expression_from_dom (l_expression)
				l_routine ?= last_expression
				if l_routine /= Void then
					set_last_expression (create {CODE_ROUTINE_INVOKE_EXPRESSION}.make(l_routine, expressions_from_collection (a_source.parameters)))
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_method, ["method invoke expression"])
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_method, ["method invoke expression"])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_routine_reference_expression (a_source: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_ROUTINE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_reference_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_target_object := a_source.target_object
			if l_target_object /= Void then
				code_dom_generator.generate_expression_from_dom (l_target_object)
				set_last_expression (create {CODE_ROUTINE_REFERENCE_EXPRESSION}.make (a_source.method_name, last_expression))
			else
				set_last_expression (create {CODE_ROUTINE_REFERENCE_EXPRESSION}.make (a_source.method_name, create {CODE_THIS_REFERENCE_EXPRESSION}.make (current_type)))
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
end -- class CODE_ROUTINE_EXPRESSION_FACTORY

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