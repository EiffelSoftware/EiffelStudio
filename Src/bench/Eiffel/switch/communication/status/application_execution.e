indexing
	description	: "Controls execution of debugged application."
	date		: "$Date$"
	revision	: "$Revision $"

class APPLICATION_EXECUTION

inherit
	PROJECT_CONTEXT
		export
			{NONE} all
		end

	OBJECT_ADDR
		export
			{NONE} all
		end

	EXEC_MODES

	IPC_SHARED

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
			{ANY} Eiffel_project
		end

	SHARED_CONFIGURE_RESOURCES

	EB_ERROR_MANAGER

creation {SHARED_APPLICATION_EXECUTION}
	make

feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			create debug_info.make
			displayed_string_size := 50
			current_execution_stack_number := 1
			critical_stack_depth := -1
			create {APPLICATION_STOPPED_CMD} before_stopped_command
			create {APPLICATION_STOPPED_CMD} after_stopped_command
		ensure
			displayed_string_size: displayed_string_size = 50
			current_execution_stack_number_is_one: current_execution_stack_number = 1
		end

feature -- load and save
	
	load_debug_info is
			-- Load debug information (so far only the breakpoints)
		local
			load_filename: FILE_NAME
		do
			create load_filename.make
			load_filename.set_directory (Workbench_generation_path)
			load_filename.set_file_name (Debug_info_name + Debug_info_extension)

			if debug_info = Void then
				create debug_info.make
			end
			debug_info.load (load_filename)
			resynchronize_breakpoints
		end

	save_debug_info is
			-- Save debug information (so far only the breakpoints)
		local
			save_filename: FILE_NAME
		do
			create save_filename.make
			save_filename.set_directory(Workbench_generation_path)
			save_filename.set_file_name(Debug_info_name + Debug_info_extension)
		
			if debug_info = Void then
				create debug_info.make
			end
			debug_info.save(save_filename)
		rescue
			set_error_message ("Unable to save project properties%N%
					%Cause: Unable to open " + save_filename + " for writing")
		end

feature -- Properties

	status: APPLICATION_STATUS
			-- Status of the running application

	termination_command: E_CMD
			-- Command executed after application has been terminated
			-- (is_running will be false after executing this command)

	application_launched_command: E_CMD
			-- Command executed after application has been launced
			-- (If `is_running' is false then application was unable to
			-- be executed because of a timeout)

	before_stopped_command: E_CMD
			-- Command executed before receiving information from
			-- the application when an exception occur or a breakpoint
			-- has been reached (useful to set waiting cursor and
			-- `is_stopped' has not been flagged to true)

	after_stopped_command: E_CMD
			-- Command executed after the application is stopped due
			-- to an exception or a breakpoint
			-- (status.is_stopped is true when `after_stopped_command'
			-- is called)

	execution_mode: INTEGER
			-- Execution mode (Step by step, stop at stoop points, ...)

	displayed_string_size: INTEGER
			-- Size of string to be retrieved from the application
			-- when debugging (size of `string_value' in REFERENCE_VALUE)
			-- (Default value is 50)

	current_execution_stack_number: INTEGER
			-- Stack number currently displaying the locals and arguments

	interrupt_number: INTEGER
			-- Number that specifies the `n' breakable points in	
			-- which the application will check if an interrupt was pressed

	critical_stack_depth: INTEGER
			-- Call stack depth at which we warn the user against a possible stack overflow.

	is_running: BOOLEAN is
			-- Is the application running?
		do
			Result := status /= Void
		ensure
			yes_implies_non_void_status: Result implies status /= Void
		end

	is_stopped: BOOLEAN is
			-- Is the application stopped in its execution?
		require
			is_running: is_running
		do
			Result := status.is_stopped
		ensure
			yes_implies_status_is_stop: Result implies status.is_stopped
		end

	is_ignoring_stop_points: BOOLEAN is
			-- Is the application ignoring all stop points?
		do
			Result := execution_mode = No_stop_points
		end

	exists: BOOLEAN is
			-- Does the application file exists?
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (Eiffel_system.application_name (True))
			Result := f.exists
		end

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		require
			valid_addr: addr /= Void
			is_running: is_running
			is_stopped: is_stopped
		do
			Result := is_hector_addr (addr)
		end

	error_in_bkpts: BOOLEAN is
			-- Has an error occurred in the last modification/examination of breakpoints?
		do
			Result := debug_info.error_in_bkpts
		end

	has_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints (enabled or disabled) ?
		do
			Result := debug_info.has_breakpoints
		end

	has_enabled_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints enabled ?
		do
			Result := debug_info.has_enabled_breakpoints
		end

	has_disabled_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints disabled ?
		do
			Result := debug_info.has_disabled_breakpoints
		end

feature -- Access

	eiffel_timeout_message: STRING is
			-- Message displayed when ebench is unable to launch
			-- the system (because of a timeout)
		external
			"C"
		alias
			"eif_timeout_msg"
		end

	number_of_stack_elements: INTEGER is
			-- Total number of the call stack elements in
			-- exception stack
		require
			is_running: is_running
			is_stopped: is_stopped
		do	
			Result := status.where.count
		end

feature -- Element change

	switch_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- Switch the `i'-th breakpoint of `f'
		require
			positive_i: i > 0
		do
			debug_info.switch_breakpoint (f, i)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	remove_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- remove the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', do nothing
		require
			positive_i: i > 0
		do
			debug_info.remove_breakpoint (f, i)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	enable_breakpoint, set_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- enable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a breakpoint is created
		require
			positive_i: i > 0
		do
			debug_info.enable_breakpoint (f, i)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	disable_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- disable the `i'-th breakpoint of `f'
			-- if no breakpoint already exists for 'f' at 'i', a disabled breakpoint is created
		require
			positive_i: i > 0
		do
			debug_info.disable_breakpoint (f, i)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	set_breakpoint_status (f: E_FEATURE; i: INTEGER; bp_status: INTEGER) is
			-- set the status of the `i'-th breakpoint of `f', on the bench
			-- side. DO NOT NOTIFY the application of the change if the application
			-- is running. 
			-- 
			-- bp_status =  0 <=> the breakpoint is not set,
			-- bp_status =  1 <=> the breakpoint is set,
			-- bp_status = -1 <=> the breakpoint is disabled
		do
			inspect bp_status
			when 0 then
				debug_info.remove_breakpoint (f, i)
			when 1 then
				debug_info.enable_breakpoint (f, i)
			when -1 then
				debug_info.disable_breakpoint (f, i)
			end
		end

	set_condition (f: E_FEATURE; i: INTEGER; expr: EB_EXPRESSION) is
			-- Make the breakpoint located at (`f',`i') conditional with condition `expr'.
			-- Create an enabled breakpoint if is doesn't already exist.
		require
			valid_f: f /= Void and then f.is_debuggable
			valid_i: i > 0 and i <= f.number_of_breakpoint_slots
			valid_expr: expr /= Void and then not expr.syntax_error
			good_semantics: expr.is_condition (f)
		do
			debug_info.set_condition (f, i, expr)
		end

	remove_condition (f: E_FEATURE; i: INTEGER) is
			-- Make the breakpoint located at (`f',`i') unconditional.
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			debug_info.remove_condition (f, i)
		end

feature -- Access

	condition (f: E_FEATURE; i: INTEGER): EB_EXPRESSION is
			-- Make the breakpoint located at (`f',`i') unconditional.
		require
			valid_breakpoint: is_breakpoint_set (f, i)
		do
			Result := debug_info.condition (f, i)
		end

	is_breakpoint_set (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set (enabled or disabled) ?
		do
			Result := debug_info.is_breakpoint_set(f, i)
		end

	is_breakpoint_enabled (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' enabled?
		do
			Result := debug_info.is_breakpoint_enabled(f, i)
		end

	is_breakpoint_disabled (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' disabled?
		do
			Result := debug_info.is_breakpoint_disabled(f, i)
		end

	breakpoint_status (f: E_FEATURE; i: INTEGER): INTEGER is
			-- Returns 0 if the breakpoint is not set,
			--         1 if the breakpoint is set and enabled,
			--		   2 if the breakpoint is enabled and has a condition,
			--         -1 if the breakpoint is set but disabled,
			--		   -2 if the breakpoint is disabled and has a condition
		do
			Result := debug_info.breakpoint_status(f, i)
		end

	has_breakpoint_set (f: E_FEATURE): BOOLEAN is
			-- Has `f' a breakpoint set to stop?
		require
			non_void_f: f /= Void
		do
			Result := debug_info.has_breakpoint_set(f)
		end

	breakpoints_set_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set for feature `f'
		do
			Result := debug_info.breakpoints_set_for(f)
		ensure
			non_void_result: Result /= Void
		end

	breakpoints_enabled_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set & enabled for feature `f'
		do
			Result := debug_info.breakpoints_enabled_for(f)
		ensure
			non_void_result: Result /= Void
		end

	breakpoints_disabled_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set & disabled for feature `f'
		do
			Result := debug_info.breakpoints_disabled_for(f)
		ensure
			non_void_result: Result /= Void
		end

	features_with_breakpoint_set: LIST[E_FEATURE] is
			-- returns the list of all features that contains at
			-- least one breakpoint set (enabled or disabled)
		do
			Result := debug_info.features_with_breakpoint_set
		ensure
			non_void_result: Result /= Void
		end

feature -- Removal

	remove_breakpoints_in_feature(f: E_FEATURE) is
		require
			non_void_f: f /= Void
		do
			debug_info.remove_breakpoints_in_feature(f)		
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	disable_breakpoints_in_feature(f: E_FEATURE) is
		require
			non_void_f: f /= Void
		do
			debug_info.disable_breakpoints_in_feature(f)		
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	enable_breakpoints_in_feature(f: E_FEATURE) is
		require
			non_void_f: f /= Void
		do
			if f.is_debuggable then
				debug_info.enable_breakpoints_in_feature(f)		
				if is_running and then not is_stopped then
					-- If the application is running (and not stopped), we
					-- must notify it to take the new breakpoint into account.
					notify_newbreakpoint
				end
			end
		end

	enable_first_breakpoint_of_feature (f: E_FEATURE) is
		require
			non_void_f: f /= Void
			debuggable: f.is_debuggable
		do
			debug_info.enable_first_breakpoint_of_feature (f)		
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	enable_first_breakpoints_in_class (c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debug_info.enable_first_breakpoints_in_class (c)		
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	remove_breakpoints_in_class (c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debug_info.remove_breakpoints_in_class(c)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	disable_breakpoints_in_class(c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debug_info.disable_breakpoints_in_class(c)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	enable_breakpoints_in_class(c: CLASS_C) is
		require
			non_void_c: c /= Void
		do
			debug_info.enable_breakpoints_in_class(c)
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	disable_all_breakpoints is
			-- disable all enabled breakpoints 
		do
			debug_info.disable_all_breakpoints	
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	enable_all_breakpoints is
			-- enable all enabled breakpoints 
		do
			debug_info.enable_all_breakpoints	
			if is_running and then not is_stopped then
				-- If the application is running (and not stopped), we
				-- must notify it to take the new breakpoint into account.
				notify_newbreakpoint
			end
		end

	clear_debugging_information is
			-- Clear the debugging information.
			-- Save the information if we want to restore it
			-- after the compilation (do not save the information
			-- if there are compilation errors).
		do
			if is_running then
					-- Need to individually remove the breakpoints
					-- since the sent_bp must be updated to
					-- not stop.
				debug_info.remove_all_breakpoints	
				if not is_stopped then
					-- If the application is running (and not stopped), we
					-- must notify it to take the new breakpoint into account.
					notify_newbreakpoint
				end
			else
				debug_info.wipe_out
			end
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
		require
			app_not_running: not is_running
			application_exists: exists
			non_negative_interrupt: interrupt_number >= 0
		local
			app: STRING
		do
			app := Eiffel_system.application_name (True)
			if args /= Void then
				app.extend (' ')
				app.append (args)
			end
			run_request.set_application_name (app)
			run_request.set_working_directory (cwd)
			run_request.send
			if status /= Void then
					-- Application was able to be started
				status.set_is_stopped (False)
			end
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end

	continue (kept_objects: LINKED_SET [STRING]) is
			-- Continue the running of the application and keep the 
			-- objects addresses in `kept_objects'. Objects that are not in 
			-- `kept_objects' will be removed and will be not under the 
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		require
			is_running: is_running
			is_stopped: is_stopped
			non_void_keep_objects: kept_objects /= Void
			non_negative_interrupt: interrupt_number >= 0
		do
			keep_objects (kept_objects)
			cont_request.send_breakpoints
			status.set_is_stopped (False)
			cont_request.send_rqst_3 (Rqst_resume, Resume_cont, interrupt_number, critical_stack_depth)
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		do	
			quit_request.make (Rqst_interrupt)
			quit_request.send
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		require
			app_is_running: is_running
			not_stopped: not is_stopped
		do	
			quit_request.make (Rqst_new_breakpoint)
			quit_request.send
		end
		

	kill is
			-- Ask the application to terminate itself.
		require
			app_is_running: is_running
		do
			quit_request.make (Rqst_kill)
			quit_request.send;		
			process_termination
				-- Don't wait until the next event loop to
				-- to process the actual termination of the application.
				-- `recv_dead' will wait until the application is dead.
			if quit_request.recv_dead then end
		ensure
			app_is_not_running: not is_running
		end

feature -- Setting

	set_execution_mode (exec_mode: like execution_mode) is
			-- Set `exec_mode' the new execution mode.
		require
			valid_exec_mode: exec_mode >= No_stop_points and then
					exec_mode <= Out_of_routine
		do
			execution_mode := exec_mode
		ensure
			set: execution_mode = exec_mode
		end

	set_interrupt_number (a_nbr: like interrupt_number) is
			-- Set `interrupt_number' to `a_nbr'.
		require
			non_negative_nbr: a_nbr >= 0
		do
			interrupt_number := a_nbr
		ensure
			set: interrupt_number = a_nbr
		end

	set_critical_stack_depth (d: INTEGER) is
			-- Call stack depth at which we warn the user against a possible stack overflow.
			-- -1 never warns the user.
		require
			valid_depth: d = -1 or d > 0
		do
			critical_stack_depth := d
		end

	set_launched_command (cmd: like application_launched_command) is
			-- Set `application_launched_command' to `cmd'.
		do
			application_launched_command := cmd
		ensure
			set: application_launched_command = cmd
		end

	set_after_stopped_command (cmd: like after_stopped_command) is
			-- Set `after_stopped_command' to `cmd'.
		do
			after_stopped_command := cmd
		ensure
			set: after_stopped_command = cmd
		end

	set_before_stopped_command (cmd: like before_stopped_command) is
			-- Set `before_stopped_command' to `cmd'.
		do
			before_stopped_command := cmd
		ensure
			set: before_stopped_command = cmd
		end

	set_termination_command (cmd: like termination_command) is
			-- Set `termination_command' to `cmd'.
		do
			termination_command := cmd
		ensure
			set: termination_command = cmd
		end

	set_displayed_string_size (i: like displayed_string_size) is
			-- Set `displayed_string_size' to `i'.
		require
			positive_i: i > 0
		do
			displayed_string_size := i
		ensure
			set: displayed_string_size = i
		end

	set_current_execution_stack (i: INTEGER) is
			-- Set the `current_execution_stack_number' to `i'.
			--| If `current_execution_stack_number' is greater than
			--| the number of stack elements then 
			--| `current_execution_stack_number' will be set
			--| to the last element.
		require
			is_stopped: is_stopped
			positive_i: i > 0
			small_enough: i <= number_of_stack_elements
		do
			current_execution_stack_number := i
		ensure
			set: current_execution_stack_number = i
		end

feature -- Implementation

	resynchronize_breakpoints is
			-- Resychronize the breakpoints after a compilation.
		do
			debug_info.resynchronize_breakpoints
		end

feature {DEAD_HDLR, RUN_REQUEST} -- Setting

	set_status (s: like status) is
			-- Set `status' to `s'.
		do
			status := s
		ensure
			set: status = s
		end

feature {DEAD_HDLR, STOPPED_HDLR, EDIT_ITEM, DEBUG_DYNAMIC_EVAL_HOLE} -- Implemenation

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		require
			is_running: is_running
		do
			debug_info.restore
			addr_table.clear_all
			if termination_command /= Void then
				termination_command.execute
			end
			status := Void
			current_execution_stack_number := 1
debug ("DEBUGGER_TRACE")
	io.error.putstring ("terminating project%N")
end
		ensure
			not_running: not is_running
			reset_current_execution_stack_number:
					current_execution_stack_number = 1
		end

feature {RUN_REQUEST} -- Implementation

	invoke_launched_command (successful: BOOLEAN) is
			-- Process after the launch of the application according
			-- to `successful' and the execute `application_launch_command'. 
		do
		end

feature {SHARED_DEBUG, STOPPOINTS_STATUS, OPEN_PROJECT, QUIT_PROJECT}

	debug_info: DEBUG_INFO

feature {APPLICATION_STATUS} 

	quit_request: EWB_REQUEST is
		once
			!! Result.make (Rqst_quit)
		end

	run_request: RUN_REQUEST is
		once
			!! Result.make (Rqst_application)
		end

	cont_request: EWB_REQUEST is
		once
			!! Result.make (Rqst_cont)
		end

invariant

	non_void_debug_info: debug_info /= Void

end -- class APPLICATION_EXECUTION
