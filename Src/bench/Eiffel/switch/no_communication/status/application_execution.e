indexing

	description: 
		"Dummy class for batch compiler.";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make is 
		do
		end;

feature -- Load and Save

	load_debug_info is
		do
		end

	save_debug_info is
		do
		end

feature

	add_feature (f: E_FEATURE) is
		do
		end

	eiffel_timeout_message: STRING is
		do
		end

	continue (kept_objects: LINKED_SET [STRING]) is
		do
		end

	removed_routines: LINKED_LIST [E_FEATURE] is
		do
 		end

	debugged_routines: LINKED_LIST [E_FEATURE] is
		do
 		end

	has_feature (f: E_FEATURE): BOOLEAN is
		do
		end

	switch_feature (F: E_FEATURE) is
		do
		end

	has_debugging_information: BOOLEAN is
		do
		end

	resynchronize_breakpoints is
		do
		end

	is_breakpoint_set (f: E_FEATURE; i: INTEGER): BOOLEAN is
		do
		end

	switch_breakpoint (f: E_FEATURE; i: INTEGER) is
		do
		end

	super_melt_feature (f: E_FEATURE) is
		do
		end

	super_melt_class (c: CLASS_C) is
		do
		end

	status: APPLICATION_STATUS is
		once
			!! Result
		end

	termination_command: E_CMD;

	application_launched_command: E_CMD;

	before_stopped_command: E_CMD;

	after_stopped_command: E_CMD;

	execution_mode: INTEGER;

	displayed_string_size: INTEGER;

	current_execution_stack_number: INTEGER;

	interrupt_number: INTEGER

	kill is
		do
		end

	interrupt is
		do
		end

	is_running: BOOLEAN is
		do
		end;

	is_stopped: BOOLEAN is
		do
		end;

	is_ignoring_stop_points: BOOLEAN is
		do
		end;

	valid_debugged_feature (f: E_FEATURE): BOOLEAN is
		do
		end;

	valid_breakpoint_for (f: E_FEATURE; i: INTEGER): BOOLEAN is
		do
		end;

	exists: BOOLEAN is
		do
		end;

	is_valid_object_address (addr: STRING): BOOLEAN is
		do
		end;

	number_of_stack_elements: INTEGER is
		do	
		end;

	has_breakpoints: BOOLEAN is
		do
		end

	has_breakpoint_set (f: E_FEATURE): BOOLEAN is
		do
		end;

	breakpoints_set_for (f: E_FEATURE): LIST [INTEGER] is
		do
		end;

feature -- Removal

	clear_debugging_information is
		do
		end;

	remove_feature (f: E_FEATURE) is
		do
		end;

	remove_class (c: CLASS_C) is
		do
		end;

	set_execution_mode (exec_mode: like execution_mode) is
		do
		end;

	set_interrupt_number (a_nbr: like interrupt_number) is
		do
		end;

	set_launched_command (cmd: like application_launched_command) is
		do
		end;

	set_after_stopped_command (cmd: like after_stopped_command) is
		do
		end;

	set_before_stopped_command (cmd: like before_stopped_command) is
		do
		end;

	set_termination_command (cmd: like termination_command) is
		do
		end;

	set_displayed_string_size (i: like displayed_string_size) is
		do
		end;

	set_current_execution_stack (i: INTEGER) is
		do
		end;

	set_status (s: like status) is
		do
		end

	run (args: STRING) is
		do
		end

end -- class APPLICATION_EXECUTION
