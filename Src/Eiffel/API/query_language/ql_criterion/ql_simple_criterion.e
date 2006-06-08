indexing
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

	make (a_agent: like evaluate_agent; a_require_compiled: BOOLEAN) is
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

feature -- Status report

	require_compiled: BOOLEAN is
			-- Does current criterion require a compiled item?
		do
			Result := require_compiled_internal
		end

feature -- Evaluate

	is_satisfied_by (a_item: like item_type): BOOLEAN is
			-- Evaluate `a_item'.
		do
			Result := evaluate_agent.item ([a_item])
		end

feature{NONE} -- Implementation

	evaluate_agent: FUNCTION [ANY, TUPLE [like item_type], BOOLEAN]
			-- Agent used to evaluate current criterion against a given item

	require_compiled_internal: BOOLEAN
			-- Implementation of `require_compiled"

invariant
	evaluate_agent_attached: evaluate_agent /= Void

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


end
