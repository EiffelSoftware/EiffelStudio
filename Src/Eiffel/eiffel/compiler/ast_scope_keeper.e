note
	description: "Keeper for non-void entity scopes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_SCOPE_KEEPER

inherit
	AST_INITIALIZATION_KEEPER
		rename
			is_set as is_attached,
			set as start_scope
		export
			{AST_ARGUMENT_SCOPE_TRACKER} start_scope
		redefine
			update_sibling,
			start_scope
		end

feature {AST_CONTEXT} -- Status report

	is_sibling_dominating: BOOLEAN
			-- Does variable information of a sibling dominate the previous one (if any)?
		require
			is_nested: nesting_level > 0
		deferred
		end

feature {AST_ARGUMENT_SCOPE_TRACKER, AST_LOCAL_SCOPE_TRACKER} -- Modification: variables

	stop_scope (index: like count)
			-- Mark that a variable with the given `index' can be void.
		require
			index_large_enough: index > 0
			index_small_emough: index <= count
		deferred
		end

feature {AST_SCOPE_COMBINED_PRECONDITION, AST_CONTEXT, AST_CREATION_PROCEDURE_CHECKER} -- Modification: nesting

	update_sibling
			-- <Precursor>
		deferred
		ensure then
			is_sibling_dominating: is_sibling_dominating
		end

note
	copyright:	"Copyright (c) 2008-2009, Eiffel Software"
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

end
