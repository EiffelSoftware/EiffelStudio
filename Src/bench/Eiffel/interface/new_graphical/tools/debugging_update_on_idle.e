indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred
class
	DEBUGGING_UPDATE_ON_IDLE

inherit

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

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

	update is
		local
			l_status: APPLICATION_STATUS
		do
			cancel_process_real_update_on_idle
			l_status := application.status
			if l_status /= Void then
				process_real_update_on_idle (l_status.is_stopped)
			end
			-- To redefine
		end

feature {NONE} -- real_update

	real_update_on_idle is
		local
			l_dbg_is_stopped: BOOLEAN
		do
			l_dbg_is_stopped := real_update_on_idle_called_on_stopped
			cancel_process_real_update_on_idle
			real_update (l_dbg_is_stopped)
		end

	real_update (arg_is_stopped: BOOLEAN) is
			-- Display current execution status.
		deferred
		end

feature {NONE} -- Implementation

	real_update_on_idle_called_on_stopped: BOOLEAN

	process_real_update_on_idle (a_dbg_stopped: BOOLEAN) is
			-- Call `real_update' on idle action
		do
			real_update_on_idle_called_on_stopped := a_dbg_stopped
			print (generator + ".update : " + a_dbg_stopped.out + "%N")
--			update_on_idle_agent.set_operands ([a_dbg_stopped])
			ev_application.idle_actions.extend (update_on_idle_agent)			
		end
	
	cancel_process_real_update_on_idle is
			-- cancel any calls to `real_update' on idle action	
		do
			real_update_on_idle_called_on_stopped := False
			ev_application.idle_actions.prune_all (update_on_idle_agent)			
		end	

	update_on_idle_agent: PROCEDURE [ANY, TUPLE] --TUPLE [BOOLEAN]]
			-- Procedure used in the update on idle mecanism

end
