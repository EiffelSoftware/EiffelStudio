note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {DEBUGGER_S} -- Event handlers

	on_application_launched (dbg: DEBUGGER_S)
			-- Called when application has just been launched
			--
			-- `dbg': The sender service of the event.
		require
			is_interface_usable: (attached {USABLE_I} Current as l_usable) implies l_usable.is_interface_usable
			dbg_is_interface_usable: dbg /= Void and then dbg.is_interface_usable
		do
		end

	on_application_resumed (dbg: DEBUGGER_S)
			-- Called when application has been resumed after a stop
			--
			-- `dbg': The sender service of the event.
		require
			is_interface_usable: (attached {USABLE_I} Current as l_usable) implies l_usable.is_interface_usable
			dbg_is_interface_usable: dbg /= Void and then dbg.is_interface_usable
		do
		end

	on_application_stopped (dbg: DEBUGGER_S)
			-- Called when application has just stopped (paused)
			--
			-- `dbg': The sender service of the event.
		require
			is_interface_usable: (attached {USABLE_I} Current as l_usable) implies l_usable.is_interface_usable
			dbg_is_interface_usable: dbg /= Void and then dbg.is_interface_usable
		do
		end

	on_application_exited (dbg: DEBUGGER_S)
			-- Called when application has just died (exited)
			--
			-- `dbg': The sender service of the event.
		require
			is_interface_usable: (attached {USABLE_I} Current as l_usable) implies l_usable.is_interface_usable
			dbg_is_interface_usable: dbg /= Void and then dbg.is_interface_usable
		do
		end

	on_debugging_terminated (dbg: DEBUGGER_S)
			-- Called when debugging is terminated
			--
			-- `dbg': The sender service of the event.
		require
			is_interface_usable: (attached {USABLE_I} Current as l_usable) implies l_usable.is_interface_usable
			dbg_is_interface_usable: dbg /= Void and then dbg.is_interface_usable
		do
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
