indexing
	description: "implementation for DEBUGGER_MANAGER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_MANAGER_IMP

inherit
	DEBUGGER_MANAGER_IMP
		redefine
			interface
		end

	THREAD_CONTROL

create {DEBUGGER_MANAGER}
	make

feature {DEBUGGER_MANAGER} -- Access

	tty_wait_until_application_is_dead is
		local
--			stop_process_loop_on_events: BOOLEAN
		do
			io.put_string ("Console based debugger is not yet ready on non windows platforms%N")
			interface.application.kill
--			from
--				stop_process_loop_on_events := False
--			until
--				stop_process_loop_on_events
--			loop
--				if interface.application_initialized then
--					sleep (10 * 1000)
--				else
--					stop_process_loop_on_events := True
--				end
--			end
		end

feature {NONE} -- Interface

	interface: TTY_DEBUGGER_MANAGER;

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
