note
	description: "Tracker for scopes of local variables."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_LOCAL_SCOPE_TRACKER

inherit
	AST_LOCAL_INITIALIZATION_TRACKER
		rename
			is_local_set as is_local_attached,
			is_result_set as is_result_attached,
			keeper as initialization_keeper,
			scope_keeper as keeper,
			set_local as start_local_scope,
			set_result as start_result_scope
		export
			{AST_CONTEXT} keeper
		end

create
	make

feature {AST_CONTEXT} -- Element change

	stop_local_scope (position: like local_count)
			-- Mark that a local with the given `position' can be void.
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		do
			keeper.stop_scope (position)
		ensure
			is_local_not_attached: not is_local_attached (position)
		end

	stop_result_scope
			-- Mark that "Result" can be void.
		do
			keeper.stop_scope (result_index)
		ensure
			is_result_not_attached: not is_result_attached
		end

note
	copyright:	"Copyright (c) 2009, Eiffel Software"
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
