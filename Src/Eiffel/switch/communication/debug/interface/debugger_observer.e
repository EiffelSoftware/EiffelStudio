indexing
	description: "Objects that observer a DEBUGGER_MANAGER..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEBUGGER_OBSERVER

feature {DEBUGGER_MANAGER} -- Observe

	attach_to_debugger (a_dm: like internal_debugger) is
			-- Observe `a_dm'
		require
			a_dm_not_void: a_dm /= Void
			not_attached: not is_attached_to (a_dm)
		do
			internal_debugger := a_dm
			a_dm.add_observer (Current)
		ensure
			is_attached: is_attached_to (a_dm)
		end

	unattach_from_debugger is
			-- Un-observe `internal_debugger'
		require
			is_attached: is_attached_to (internal_debugger)
		do
			if internal_debugger /= Void then
				internal_debugger.remove_observer (Current)
				internal_debugger := Void
			end
		ensure
			is_not_attached: not is_attached_to (internal_debugger)
		end

feature {DEBUGGER_MANAGER, DEBUGGER_OBSERVER} -- Status

	is_attached: BOOLEAN is
			-- Is attached ?
		do
			Result := is_attached_to (internal_debugger)
		end

	is_attached_to (a_dm: like internal_debugger): BOOLEAN is
			-- Is current attached to `a_dm' ?
			--| Note: if `internal_debugger' is Void, then Current is not attached to any debugger
		do
			Result := internal_debugger /= Void and then a_dm = internal_debugger
		end

feature {DEBUGGER_MANAGER} -- Properties

	internal_debugger: DEBUGGER_MANAGER
			-- Associated Debugger

feature {DEBUGGER_MANAGER} -- Event handling

	on_application_launched (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has just been launched.
		require
			same_debugger: dbg = internal_debugger
		do
		end

	on_application_resumed (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has been resumed after a stop.
		require
			same_debugger: dbg = internal_debugger
		do
		end

	on_application_paused (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has paused
		require
			same_debugger: dbg = internal_debugger
		do
		end

	on_application_stopped (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has stopped
		require
			same_debugger: dbg = internal_debugger
		do
		end

	on_application_quit (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has just died (exited).
		require
			same_debugger: dbg = internal_debugger
		do
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

end -- class EB_DEBUGGER_OBSERVER
