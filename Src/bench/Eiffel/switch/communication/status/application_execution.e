indexing

	description: 
		"Controls execution of debugged application.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_EXECUTION

inherit

	PROJECT_CONTEXT
		export
			{NONE} all
		end;
	OBJECT_ADDR
		export
			{NONE} all
		end;
	EXEC_MODES;
	IPC_SHARED;
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all;
			{ANY} Eiffel_project
		end;
	SHARED_CONFIGURE_RESOURCES

	WINDOWS

creation {SHARED_APPLICATION_EXECUTION}

	make

feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			!! debug_info.make;
			displayed_string_size := 100;
			current_execution_stack_number := 1
		ensure
			displayed_string_size: displayed_string_size = 100;
			current_execution_stack_number_is_one: current_execution_stack_number = 1
		end;

feature -- Properties

	status: APPLICATION_STATUS;
			-- Status of the running application

	termination_command: E_CMD;
			-- Command executed after application has been terminated
			-- (is_running will be false after executing this command)

	application_launched_command: E_CMD;
			-- Command executed after application has been launced
			-- (If `is_running' is false then application was unable to
			-- be executed because of a timeout)

	before_stopped_command: E_CMD;
			-- Command executed before receiving information from
			-- the application when an exception occur or a breakpoint
			-- has been reached (useful to set waiting cursor and
			-- `is_stopped' has not been flagged to true)

	after_stopped_command: E_CMD;
			-- Command executed after the application is stopped due
			-- to an exception or a breakpoint
			-- (status.is_stopped is true when `after_stopped_command'
			-- is called)

	execution_mode: INTEGER;
			-- Execution mode (Step by step, stop at stoop points, ...)

	displayed_string_size: INTEGER;
			-- Size of string to be retrieved from the application
			-- when debugging (size of `string_value' in REFERENCE_VALUE)
			-- (Default value is 50)

	current_execution_stack_number: INTEGER;
			-- Stack number currently displaying the locals and arguments

	interrupt_number: INTEGER
			-- Number that specifies the `n' breakable points in	
			-- which the application will check if an interrupt was pressed

	debugged_routines: LINKED_LIST [E_FEATURE] is
			-- Routines that are currently debugged
		do
			Result := debug_info.debugged_routines
		ensure
			valid_result: Result = debug_info.debugged_routines
		end

	removed_routines: LINKED_LIST [E_FEATURE] is
			-- Routines that are not currently debugged
		do
			Result := debug_info.removed_routines
		ensure
			valid_result: Result = debug_info.removed_routines
		end

	is_running: BOOLEAN is
			-- Is the application running?
		do
			Result := status /= Void
		ensure
			yes_implies_non_void_status: Result implies status /= Void
		end;

	is_stopped: BOOLEAN is
			-- Is the application stop in its execution?
		require
			is_running: is_running
		do
			Result := status.is_stopped
		ensure
			yes_implies_status_is_stop: Result implies status.is_stopped
		end;

	is_ignoring_stop_points: BOOLEAN is
			-- Is the application ignoring all stop points?
		do
			Result := execution_mode = No_stop_points
		ensure
			yes_implies_status_is_stop: Result implies status.is_stopped
		end;

	valid_debugged_feature (f: E_FEATURE): BOOLEAN is
			-- Is the feature `f' valid for the
			-- debugger context?
		do
			Result := f /= Void and then f.is_debuggable
		ensure
			valid_result: Result implies f /= Void and then	
							f.is_debuggable
		end;

	valid_breakpoint_for (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is breakpoint `i' valid for feature `f'
		require
			has_feature: has_feature (f);
			positive_i: i > 0;
			valid_debugged_feature: valid_debugged_feature (f);
		local
			deb: LINKED_LIST [DEBUGGABLE]
		do
			deb := debug_info.debuggables (f)
			Result := i <= deb.first.breakable_points.count 
		end;

	exists: BOOLEAN is
			-- Does the application file exists?
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (Eiffel_system.application_name (True));
			Result := f.exists
		end;

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		require
			valid_addr: addr /= Void;
			is_running: is_running;
			is_stopped: is_stopped
		do
			Result := is_hector_addr (addr)
		end;

	has_debugging_information: BOOLEAN is
			-- Has Current have any debug information?
		do
			Result := not removed_routines.empty or else
			 		not debugged_routines.empty
		end

feature -- Access

	eiffel_timeout_message: STRING is
			-- Message displayed when ebench is unable to launch
			-- the system (because of a timeout)
		external
			"C"
		alias
			"eif_timeout_msg"
		end;

	has_feature (f: E_FEATURE): BOOLEAN is
			-- Has debuggable byte code already been 
			-- generated for feature `f'?
		do
			Result := debug_info.has_feature (f)
		end;

	number_of_stack_elements: INTEGER is
			-- Total number of the call stack elements in
			-- exception stack
		require
			is_running: is_running;
			is_stopped: is_stopped
		do	
			Result := status.where.count
		end;

feature -- Element change

	super_melt_feature (f: E_FEATURE; insert_breakpoint: BOOLEAN) is
			-- Super melt feature `f' if it has not been super melted.
		require
			valid_debugged_feature: valid_debugged_feature (f);	
			successful_compilation: Eiffel_project.successful
		do
			if not has_feature (f) then
				add_feature (f)
				if insert_breakpoint and then not is_breakpoint_set (f, 1) then
					switch_breakpoint (f, 1)
					Window_manager.routine_win_mgr.show_stoppoint (f, 1);
				end
			end
		end;

	super_melt_class (c: CLASS_C; insert_breakpoint: BOOLEAN) is
			-- Super melt all features written in class `c'.
		require
			valid_c: c /= Void
		local
			list: LIST [E_FEATURE]
		do
			list := c.written_in_features;
			from
				list.start
			until	
				list.after
			loop
				if list.item.is_debuggable then
					super_melt_feature (list.item, insert_breakpoint);
				end;
				list.forth
			end
		end;

	add_feature (f: E_FEATURE) is
			-- Generate debuggable byte code corresponding to
			-- `e_feature' and record the corresponding information.
			-- Do nothing if `f' has previously been added.
		require
			valid_debugged_feature: valid_debugged_feature (f);	
			successful_compilation: Eiffel_project.successful
		do
			debug_info.add_feature (f)
		ensure
			has_feature: has_feature (f)
		end;

	has_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints?
		require
			successful_compilation: Eiffel_project.successful
		do
			Result := debug_info.has_breakpoints
		end

	switch_feature (f: E_FEATURE) is
			-- Switch `f' from debugged to removed or from removed to debugged.
		require
			has_feature: has_feature (f)
			valid_debugged_feature: valid_debugged_feature (f);	
			successful_compilation: Eiffel_project.successful;
		do
			debug_info.switch_feature (f)
		end

	switch_breakpoint (f: E_FEATURE; i: INTEGER) is
			-- Switch the `i'-th breakpoint of `f' ?
		require
			valid_debugged_feature: valid_debugged_feature (f);	
			positive_i: i > 0;
			valid_i: valid_breakpoint_for (f, i);
			successful_compilation: Eiffel_project.successful
		do
			debug_info.switch_breakpoint (f, i)
		end

	is_breakpoint_set (f: E_FEATURE; i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakpoint of `f' set?
		require
			valid_debugged_feature: valid_debugged_feature (f);	
		do
			Result := debug_info.is_breakpoint_set (f, i)
		end;

	has_breakpoint_set (f: E_FEATURE): BOOLEAN is
			-- Has `f' a breakpoint set to stop?
		require
			non_void_f: f /= Void
		do
			Result := debug_info.has_breakpoint_set (f)
		end;

	breakpoints_set_for (f: E_FEATURE): LIST [INTEGER] is
			-- Breakpoints set for feature `f'
		require
			valid_debugged_feature: valid_debugged_feature (f);	
		do
			Result := debug_info.breakpoints_set_for (f)
		ensure
			non_void_result: Result /= Void
		end;

feature -- Removal

	clear_debugging_information is
			-- Clear the debugging information.
			-- Save the information if we want to restore it
			-- after the compilation (do not save the information
			-- if there are compilation errors).
		local
			list: LINKED_LIST [E_FEATURE]
		do
			if is_running then
					-- Need to individually remove the breakpoints
					-- since the sent_bp must be updated to
					-- not stop.
				!! list.make;
				list.append (debugged_routines);
				list.append (removed_routines);
				from
					list.start
				until
					list.after
				loop
					remove_feature (list.item);
					list.forth
				end
			else
				debug_info.wipe_out;
			end;
		ensure
			empty_removed_routines: removed_routines.empty;
			empty_debugged_routines: debugged_routines.empty;
		end;

	remove_feature (f: E_FEATURE) is
			-- Remove debugging information for feature `f'.
		require
			successful_compilation: Eiffel_project.successful;
			valid_debugged_feature: valid_debugged_feature (f);	
			has_feature: has_feature (f)
		do
			debug_info.remove_feature (f)
		ensure
			not_has_f: not has_feature (f)
		end;

	remove_class (c: CLASS_C) is
			-- Remove debugging information for features written in `c'.
		require
			valid_c: c /= Void
		local
			list: LINKED_LIST [E_FEATURE];
			f: E_FEATURE;
			cid: CLASS_ID
		do
			cid := c.id;
			removed_routines.start;
			list := removed_routines.duplicate (removed_routines.count);
			debugged_routines.start;
			list.append (debugged_routines.duplicate (debugged_routines.count));
			from
				list.start
			until	
				list.after
			loop
				f := list.item;
				if cid.is_equal (f.written_in) then
					remove_feature (list.item);
				end;
				list.forth
			end
		end;

feature -- Execution

	run (args: STRING) is
			-- Run application with arguments `args'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		require
			app_not_running: not is_running;
			application_exists: exists;
			non_negative_interrupt: interrupt_number >= 0
		local
			app: STRING
		do
			app := Eiffel_system.application_name (True);
			if args /= Void then
				app.extend (' ');
				app.append (args)
			end
			run_request.set_application_name (app);
			run_request.send;
			if status /= Void then
					-- Application was able to be started
				status.set_is_stopped (False);
			end
		ensure
			successful_app_is_not_stopped: is_running implies not is_stopped
		end;

	continue (kept_objects: LINKED_SET [STRING]) is
			-- Continue the running of the application and keep the 
			-- objects addresses in `kept_objects'. Objects that are not in 
			-- `kept_objects' will be removed and will be not under the 
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		require
			is_running: is_running;
			is_stopped: is_stopped;
			non_void_keep_objects: kept_objects /= Void;
			non_negative_interrupt: interrupt_number >= 0
		local
			ok: BOOLEAN
		do
			keep_objects (kept_objects);
			ok := cont_request.send_byte_code;
			if ok then
				cont_request.send_breakpoints
			end;
			debug_info.tenure;
			status.set_is_stopped (False);
			cont_request.send_rqst_2 (Rqst_resume, Resume_cont, 
				interrupt_number);
		end;

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next melted/super
			-- melted routine.
		require
			app_is_running: is_running;
			not_stopped: not is_stopped
		do
			quit_request.make (Rqst_interrupt);
			quit_request.send
		end;

	kill is
			-- Ask the application to terminate itself.
		require
			app_is_running: is_running;
		do
			quit_request.make (Rqst_kill);
			quit_request.send;		
			process_termination;
				-- Don't wait until the next event loop to
				-- to process the actual termination of the application.
				-- `recv_dead' will wait until the application is dead.
			if quit_request.recv_dead then end;
		ensure
			app_is_not_running: not is_running;
		end;

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
		end;

	set_interrupt_number (a_nbr: like interrupt_number) is
			-- Set `interrupt_number' to `a_nbr'.
		require
			non_negative_nbr: a_nbr >= 0
		do
			interrupt_number := a_nbr
		ensure
			set: interrupt_number = a_nbr
		end;

	set_launched_command (cmd: like application_launched_command) is
			-- Set `application_launched_command' to `cmd'.
		do
			application_launched_command := cmd;
		ensure
			set: application_launched_command = cmd
		end;

	set_after_stopped_command (cmd: like after_stopped_command) is
			-- Set `after_stopped_command' to `cmd'.
		do
			after_stopped_command := cmd;
		ensure
			set: after_stopped_command = cmd
		end;

	set_before_stopped_command (cmd: like before_stopped_command) is
			-- Set `before_stopped_command' to `cmd'.
		do
			before_stopped_command := cmd;
		ensure
			set: before_stopped_command = cmd
		end;

	set_termination_command (cmd: like termination_command) is
			-- Set `termination_command' to `cmd'.
		do
			termination_command := cmd;
		ensure
			set: termination_command = cmd
		end;

	set_displayed_string_size (i: like displayed_string_size) is
			-- Set `displayed_string_size' to `i'.
		require
			positive_i: i > 0
		do
			displayed_string_size := i;
		ensure
			set: displayed_string_size = i
		end;

	set_current_execution_stack (i: INTEGER) is
			-- Set the `current_execution_stack_number' to `i'.
			--| If `current_execution_stack_number' is greater than
			--| the number of stack elements then 
			--| `current_execution_stack_number' will be set
			--| to the last element.
		require
			is_stopped: is_stopped;
			positive_i: i > 0;
			small_enough: i <= number_of_stack_elements
		do
			current_execution_stack_number := i
		ensure
			set: current_execution_stack_number = i
		end;

feature {E_PROJECT} -- Implementation

	resynchronize_breakpoints is
			-- Resychronize the breakpoints after a compilation.
		do
			debug_info.resynchronize_breakpoints
		end;

feature {DEAD_HDLR, RUN_REQUEST} -- Setting

	set_status (s: like status) is
			-- Set `status' to `s'.
		do
			status := s;
		ensure
			set: status = s
		end

feature {DEAD_HDLR} -- Implemenation

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		require
			is_running: is_running
		do
			debug_info.restore;
				-- Get rid of adopted objects
			addr_table.clear_all;
			if termination_command /= Void then
				termination_command.execute
			end;
			status := Void;
			current_execution_stack_number := 1;
debug ("DEBUGGER_TRACE")
	io.error.putstring ("terminating project%N")
end
		ensure
			not_running: not is_running;
			reset_current_execution_stack_number:
					current_execution_stack_number = 1
		end;

feature {RUN_REQUEST} -- Implementation

	invoke_launched_command (successful: BOOLEAN) is
			-- Process after the launch of the application according
			-- to `successful' and the execute `application_launch_command'. 
		do
		end;

feature {SHARED_DEBUG} -- Implementation

	debug_info: DEBUG_INFO;

feature {NONE} -- Implementation

	quit_request: EWB_REQUEST is
		once
			!! Result.make (Rqst_quit)
		end

	run_request: RUN_REQUEST is
		once
			!! Result.make (Rqst_application)
		end;

	cont_request: EWB_REQUEST is
		once
			!! Result.make (Rqst_cont)
		end;

invariant

	non_void_debug_info: debug_info /= Void;

end -- class APPLICATION_EXECUTION
