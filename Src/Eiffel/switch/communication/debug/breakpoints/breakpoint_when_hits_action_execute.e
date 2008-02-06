indexing
	description: "When breakpoint hits execute `execution_action' ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINT_WHEN_HITS_ACTION_EXECUTE

inherit
	BREAKPOINT_WHEN_HITS_ACTION_I

create
	make

feature {NONE} -- Initialization

	make (a_action: BOOLEAN) is
		do
			set_execute_action (a_action)
		end

feature -- Access

	execute_action: PROCEDURE [ANY, TUPLE [BREAKPOINT, DEBUGGER_MANAGER]]
			-- Action to execute.

feature -- Change

	set_execute_action (a_action: like execute_action) is
			-- Set `execute_action' with `a_action'
		do
			execute_action := a_action
		end

feature -- Execute

	execute (a_bp: BREAKPOINT; a_dm: DEBUGGER_MANAGER) is
		do
			if execute_action /= Void then
				execute_action.call ([a_bp, a_dm])
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
