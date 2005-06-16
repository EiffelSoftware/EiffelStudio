indexing
	description	: "Controls execution of debugged application."
	date		: "$Date$"
	revision	: "$Revision $"

deferred class APPLICATION_EXECUTION_IMP

inherit
	ANY

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
			{ANY} Application
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_DEBUG
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
		end

feature -- recycling data

	recycle is
		do
			Debugged_object_manager.reset			
		end

feature -- Properties

	status: APPLICATION_STATUS is
			-- Status of the running application
		deferred
		end

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		require
			valid_addr: addr /= Void
			is_running: Application.is_running
			is_stopped: Application.is_stopped
		deferred
--			Result := is_hector_addr (addr)
--			Result := False
		end

feature {APPLICATION_EXECUTION} -- Implemenation

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		require
			is_running: Application.is_running
		deferred
		end

feature {APPLICATION_EXECUTION} -- Execution

	run (args, cwd: STRING) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		require
			app_not_running: not Application.is_running
			application_exists: Application.exists
			non_negative_interrupt: Application.interrupt_number >= 0
		deferred
		ensure
			successful_app_is_not_stopped: Application.is_running implies not Application.is_stopped
		end

	continue (kept_objects: LINKED_SET [STRING]) is
			-- Continue the running of the application and keep the 
			-- objects addresses in `kept_objects'. Objects that are not in 
			-- `kept_objects' will be removed and will be not under the 
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		require
			is_running: Application.is_running
			is_stopped: Application.is_stopped
			non_void_keep_objects: kept_objects /= Void
			non_negative_interrupt: Application.interrupt_number >= 0
		deferred
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		require
			app_is_running: Application.is_running
			not_stopped: not Application.is_stopped
		deferred
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		require
			app_is_running: Application.is_running
			not_stopped: not Application.is_stopped
		deferred
		end
		
	kill is
			-- Ask the application to terminate itself.
		require
			app_is_running: Application.is_running
		deferred
		end

end -- class APPLICATION_EXECUTION_IMP
