indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

create
	make

feature -- Initialization

	make is
		do
		end

feature -- Output helpers

	debugger_message (msg: STRING) is
		do
		end

feature -- Status

	can_debug: BOOLEAN is
		do
		end

feature -- File access

	load_debug_info is
			-- Load debug information (so far only the breakpoints)
		do
		end

	save_debug_info is
			-- Save debug information (so far only the breakpoints)
		do
		end

feature -- Breakpoints access

	resynchronize_breakpoints is
			-- Resychronize the breakpoints (for instance after a compilation).
		do
		end

	has_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints (enabled or disabled) ?
		do
		end

feature -- Access

	application_is_dotnet: BOOLEAN is
		do
		end

	application_is_executing: BOOLEAN is
		do
		end

	application_is_stopped: BOOLEAN is
		do
		end

	maximum_stack_depth: INTEGER is
		do
		end

	windows_handle: POINTER is
		do
		end

feature -- Change

	set_current_thread_id (tid: INTEGER) is
			-- Set Current thread id to `tid'
		do
		end

	set_maximum_stack_depth (nb: INTEGER) is
			-- Set the maximum number of stack elements to be displayed to `nb'.
		do
		end

	notify_breakpoints_changes is
		do
		end

	enable_debug is
			-- Allow debugging.
		do
		end

	disable_debug is
			-- Disallow debugging.
		do
		end

feature -- Debugging events

	on_application_before_launching is
		do
		end

	on_application_launched is
		do
		end

	on_application_before_stopped is
		do
		end

	on_application_just_stopped is
		do
		end

	on_application_before_resuming is
		do
		end

	on_application_resumed is
		do
		end

	on_application_quit is
		do
		end

end
