note
	description: "Symple criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_SIMPLE_CRITERION

inherit
	QL_CRITERION
		redefine
			require_compiled
		end

feature{NONE} -- Initialization

	make (a_agent: like evaluate_agent; a_require_compiled: BOOLEAN)
			-- Initialize `evaluate_agent' with `a_agent' and
			-- `require_compiled' with `a_require_compiled'.
		require
			a_agent_attached: a_agent /= Void
		do
			evaluate_agent := a_agent
			require_compiled_internal := a_require_compiled
		ensure
			evaluate_agent_set: evaluate_agent = a_agent
			require_compiled_internal_set: require_compiled_internal = a_require_compiled
		end

	make_without_evaluate_agent (a_require_compiled: BOOLEAN)
			-- Initialize `require_compiled' with `a_require_compiled'.
		do
			require_compiled_internal := a_require_compiled
		ensure
			require_compiled_internal_set: require_compiled_internal = a_require_compiled
		end

feature -- Status report

	require_compiled: BOOLEAN
			-- Does current criterion require a compiled item?
		do
			Result := require_compiled_internal
		end

feature -- Evaluate

	is_satisfied_by (a_item: like item_type): BOOLEAN
			-- Evaluate `a_item'.
		local
			l_evaluate_agent: like evaluate_agent
			l_tuple: TUPLE [value: like item_type]
		do
			l_evaluate_agent := evaluate_agent
			if l_evaluate_agent /= Void  then
				l_tuple := l_evaluate_agent.empty_operands
				l_tuple.value := a_item
				Result := l_evaluate_agent.item (l_tuple)
			end
		end

feature -- Setting

	set_evaluate_agent (a_evaluate_agent: like evaluate_agent)
			-- Set `evaluate_agent' with `a_evaluate_agent'.
		do
			evaluate_agent := a_evaluate_agent
		ensure
			evaluate_agent_set: evaluate_agent = a_evaluate_agent
		end

feature{NONE} -- Implementation

	evaluate_agent: FUNCTION [ANY, TUPLE [like item_type], BOOLEAN]
			-- Agent used to evaluate current criterion against a given item

	require_compiled_internal: BOOLEAN
			-- Implementation of `require_compiled"

invariant
--	evaluate_agent_attached: evaluate_agent /= Void

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
