indexing
	description: "Code generator for event statements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	CODE_EVENT_STATEMENT_FACTORY

inherit
	CODE_STATEMENT_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_attach_event_statement (a_source: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT) is
			-- | Create instance of `CODE_ATTACH_EVENT_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_attach_event_statement'
			-- | Set `last_statement'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_event: CODE_EVENT_REFERENCE_EXPRESSION
		do
			code_dom_generator.generate_expression_from_dom (a_source.event)
			l_event ?= last_expression
			if l_event /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.listener)
				set_last_statement (create {CODE_ATTACH_EVENT_STATEMENT}.make (l_event, last_expression))
			end
		ensure
			non_void_last_statement: last_statement /= Void
		end

	generate_remove_event_statement (a_source: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT) is
			-- | Create instance of `CODE_REMOVE_EVENT_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_remove_event_statement'
			-- | Set `last_statement'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_event: CODE_EVENT_REFERENCE_EXPRESSION
		do
			code_dom_generator.generate_expression_from_dom (a_source.event)
			l_event ?= last_expression
			if l_event /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.listener)
				set_last_statement (create {CODE_REMOVE_EVENT_STATEMENT}.make (l_event, last_expression))
			end
		ensure
			non_void_last_statement: last_statement /= Void
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
end -- class CODE_EVENT_STATEMENT_FACTORY

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