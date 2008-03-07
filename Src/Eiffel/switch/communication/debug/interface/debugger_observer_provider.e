indexing
	description: "Debugger observer provider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_OBSERVER_PROVIDER

inherit
	DEBUGGER_OBSERVER
		redefine
			on_application_launched,
			on_application_resumed,
			on_application_stopped,
			on_application_exited,
			on_debugging_terminated
		end

create {DEBUGGER_MANAGER}
	make

feature {NONE} -- Initialization

	make is
			-- Instanciate Current
		do
			create application_launched_actions
			create application_resumed_actions
			create application_stopped_actions
			create application_exited_actions
			create debugging_terminated_actions
		end

feature -- Recycling

	recycle
			-- Recycling Current
		do
			application_exited_actions.wipe_out
			application_launched_actions.wipe_out
			application_resumed_actions.wipe_out
			application_stopped_actions.wipe_out
			unattach_from_debugger
		end

feature -- Actions

	application_launched_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
			-- Application launched

	application_resumed_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
			-- Application resumed

	application_stopped_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
			-- Application stopped

	application_exited_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
			-- Application exited

	debugging_terminated_actions: ACTION_SEQUENCE [TUPLE [DEBUGGER_MANAGER]]
			-- Debugging terminated

feature {DEBUGGER_MANAGER} -- Implementation

	on_application_launched (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has just been launched.
		do
			application_launched_actions.call ([dbg])
		end

	on_application_resumed (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has been resumed after a stop.
		do
			application_resumed_actions.call ([dbg])
		end

	on_application_stopped (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has just stopped (paused).
		do
			application_stopped_actions.call ([dbg])
		end

	on_application_exited (dbg: DEBUGGER_MANAGER) is
			-- The debugged application has just died (exited).
		do
			application_exited_actions.call ([dbg])
		end

	on_debugging_terminated (dbg: DEBUGGER_MANAGER) is
			-- The debugging is terminated.
		do
			debugging_terminated_actions.call ([dbg])
		end

invariant

	application_launched_actions_not_void: application_launched_actions /= Void
	application_resumed_actions_not_void: application_resumed_actions /= Void
	application_stopped_actions_not_void: application_stopped_actions /= Void
	application_exited_actions_not_void: application_exited_actions /= Void
	debugging_terminated_actions_not_void: debugging_terminated_actions /= Void

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
