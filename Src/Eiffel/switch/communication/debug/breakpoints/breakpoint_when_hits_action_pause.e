indexing
	description: "When breakpoint hits pause `delay' milliseconds ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINT_WHEN_HITS_ACTION_PAUSE

inherit
	BREAKPOINT_WHEN_HITS_ACTION_I

	THREAD_CONTROL

create
	make

feature {NONE} -- Initialization

	make (a_delay: INTEGER) is
		do
			delay := a_delay
		end

feature -- Access

	delay: INTEGER_32
		-- Pause for `delay' milliseconds.

feature -- Change

	set_delay (a_delay: like delay) is
			-- Set `delay' to `a_delay'
		do
			delay := a_delay
		end

feature -- Execute

	execute (a_bp: BREAKPOINT; a_dm: DEBUGGER_MANAGER) is
		local
			delay_ns: INTEGER_64
		do
			if delay > 0 then
				delay_ns := delay --| milliseconds
				delay_ns := delay_ns * 1_000 --| nanoseconds
				a_dm.debugger_message ("Waiting " + delay.out + " ms ...")
				sleep (delay_ns)
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
