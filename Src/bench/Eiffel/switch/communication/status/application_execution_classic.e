indexing
	description	: "Controls execution of debugged application."
	date		: "$Date$"
	revision	: "$Revision $"

class APPLICATION_EXECUTION_CLASSIC

inherit

	APPLICATION_EXECUTION_IMP
		redefine
			make
		end

	OBJECT_ADDR
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end		
	
create {SHARED_APPLICATION_EXECUTION}
	make
	
feature {SHARED_APPLICATION_EXECUTION} -- Initialization
	
	make is
			-- 
		do
			Precursor
		end

feature -- Properties

	status: APPLICATION_STATUS_CLASSIC is
			-- Status of the running application
		do
			Result ?= Application.status
		end
			
feature {APPLICATION_EXECUTION} -- Properties

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
			Result := is_object_kept (addr)
		end			
			
feature -- Execution

	run (args, cwd: STRING) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		local
			app: STRING
			l_status: APPLICATION_STATUS
		do
			app := Eiffel_system.application_name (True)
			if args /= Void then
				app.extend (' ')
				app.append (args)
			end
			run_request.set_application_name (app)
			run_request.set_working_directory (cwd)
			run_request.send
			l_status := status
			if l_status /= Void then
					-- Application was able to be started
				l_status.set_is_stopped (False)
			end
		end

	continue_ignoring_kept_objects is
		do
			cont_request.send_breakpoints
			status.set_is_stopped (False)
			cont_request.send_rqst_3_integer (Rqst_resume, Resume_cont, Application.interrupt_number, application.critical_stack_depth)
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do	
			quit_request.make (Rqst_interrupt)
			quit_request.send
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do	
			quit_request.make (Rqst_new_breakpoint)
			quit_request.send
		end

	kill is
			-- Ask the application to terminate itself.
		do
			Application.process_termination
			
			quit_request.make (Rqst_kill)
			quit_request.send;		

				-- Don't wait until the next event loop to
				-- to process the actual termination of the application.
				-- `recv_dead' will process all other messages sent by
				-- the application until the application is dead.
			from
			until
				quit_request.recv_dead
			loop
			end
		ensure then
			app_is_not_running: not Application.is_running			
		end		
			
	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
			release_all_objects
		end

feature -- Query

	dump_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): DUMP_VALUE is
		do
			create Result.make_object (a_addr, a_cl)
		end

	debug_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE is
		do
--			debugged_object_manager.classic_debugged_object_with_class (a_addr, a_cl)
--			Result := dump_value_at_address_with_class (a_addr, a_cl).
			to_implement ("Need to be implemented, but for now this is not used.")
			check FALSE end
		end

feature {RUN_REQUEST} -- Implementation

	invoke_launched_command (successful: BOOLEAN) is
			-- Process after the launch of the application according
			-- to `successful' and the execute `application_launch_command'. 
		do
		end
		
feature {APPLICATION_STATUS} 

	quit_request: EWB_REQUEST is
		once
			create Result.make (Rqst_quit)
		end

	run_request: RUN_REQUEST is
		once
			create Result.make (Rqst_application)
		end

	cont_request: EWB_REQUEST is
		once
			create Result.make (Rqst_cont)
		end

end -- class APPLICATION_EXECUTION_CLASSIC

