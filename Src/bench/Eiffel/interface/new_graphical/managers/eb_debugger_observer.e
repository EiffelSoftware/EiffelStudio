indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_DEBUGGER_OBSERVER

feature {EB_DEBUGGER_MANAGER} -- Event handling

	on_application_launched is
			-- The debugged application has just been launched.
		do
			
		end

	on_application_stopped is
			-- The debugged application has just stopped (paused).
		do
			
		end

	on_application_killed is
			-- The debugged application has just died (exited).
		do
			
		end

end -- class EB_DEBUGGER_OBSERVER
