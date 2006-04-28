indexing
	description : "Objects that help doing update/real_update mecanism"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred
class
	DEBUGGING_UPDATE_ON_IDLE

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	create_update_on_idle_agent is
		do
			update_on_idle_agent := agent real_update_on_idle
		end

feature -- update

	request_update is
			-- Request an update, this should call update only
			-- once per debugging "operation"
			-- This is to avoid computing twice the data
			-- on specific cases
		do
			if not update_already_done then
				update
			end
		end

	update is
		local
			l_status: APPLICATION_STATUS
		do
			cancel_process_real_update_on_idle
			l_status := debugger_manager.application.status
			if l_status /= Void then
				process_real_update_on_idle (l_status.is_stopped)
			end
				-- To redefine
		end

	cancel_idled_update is
		do
			cancel_process_real_update_on_idle
		end

feature {NONE} -- real_update

	reset_update_on_idle is
		do
			last_real_update_id := 0
		end

	last_real_update_id: NATURAL_32

	update_already_done: BOOLEAN is
		do
			Result := debugger_manager.debugging_operation_id = last_real_update_id
		end

	real_update_on_idle is
		local
			l_dbg_is_stopped: BOOLEAN
		do
			l_dbg_is_stopped := real_update_on_idle_called_on_stopped
			debug ("update_on_idle")
				print (generator +".real_update_on_idle : dbg_is_stopped="+l_dbg_is_stopped.out+"%N")
			end
			cancel_process_real_update_on_idle
			if real_update_allowed (l_dbg_is_stopped) then
				real_update_on_idle_processing_cell.replace (True)
				real_update (l_dbg_is_stopped)
				real_update_on_idle_processing_cell.replace (False)
			else
				postpone_real_update_on_next_idle (l_dbg_is_stopped)
			end
		end

	real_update_allowed (dbg_was_stopped: BOOLEAN): BOOLEAN is
		do
			Result := not is_real_update_on_idle_processing
				and (
					not debugger_manager.application_is_dotnet
					or else not debugger_manager.application.imp_dotnet.callback_notification_processing
					)
		end

	real_update (arg_is_stopped: BOOLEAN) is
			-- Display current execution status.
		do
			last_real_update_id := Debugger_manager.debugging_operation_id
		end

	postpone_real_update_on_next_idle (a_dbg_stopped: BOOLEAN) is
		do
			debug ("update_on_idle")
				print (generator +".postpone_real_update_on_next_idle (dbg_is_stopped="
					+ a_dbg_stopped.out + ") %N")
			end
			process_real_update_on_idle (a_dbg_stopped)
		end

feature {NONE} -- Implementation

	debugger_manager: DEBUGGER_MANAGER is
		deferred
		end

	is_real_update_on_idle_processing: BOOLEAN is
		do
			Result := real_update_on_idle_processing_cell.item
		end

	real_update_on_idle_processing_cell: CELL [BOOLEAN] is
		once
			create Result
		end

	real_update_on_idle_called_on_stopped: BOOLEAN

	process_real_update_on_idle (a_dbg_stopped: BOOLEAN) is
			-- Call `real_update' on idle action
		do
			real_update_on_idle_called_on_stopped := a_dbg_stopped
			ev_application.idle_actions.extend (update_on_idle_agent)
		end

	cancel_process_real_update_on_idle is
			-- cancel any calls to `real_update' on idle action	
		do
			real_update_on_idle_called_on_stopped := False
			ev_application.idle_actions.prune_all (update_on_idle_agent)
		end

	update_on_idle_agent: PROCEDURE [ANY, TUPLE]; --TUPLE [BOOLEAN]]
			-- Procedure used in the update on idle mecanism

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
