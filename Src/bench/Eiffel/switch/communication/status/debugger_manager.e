indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	DEBUGGER_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

--create
--	make

feature -- Initialization

	make is
		require
			not Application_initialized
		do
			build_shared_application_execution (Current)
		ensure
			Application_initialized
		end

feature -- Output helpers

	debugger_message (msg: STRING) is
		require
			msg /= Void
		deferred
		end

feature -- Status

	can_debug: BOOLEAN is
		deferred
		end

feature -- Access

	application_is_dotnet: BOOLEAN is
		do
			Result := application.is_dotnet
		end

	application_is_executing: BOOLEAN is
		do
			Result := Application.is_running
		end

	application_is_stopped: BOOLEAN is
		require
			application_is_executing
		do
			Result := Application.is_stopped
		end

	maximum_stack_depth: INTEGER is
		deferred
		end

	windows_handle: POINTER is
		require
			is_windows_platform: (create {PLATFORM}).is_windows
		deferred
		end

feature -- Change

	set_current_thread_id (tid: INTEGER) is
			-- Set Current thread id to `tid'
		deferred
		end

	set_maximum_stack_depth (nb: INTEGER) is
			-- Set the maximum number of stack elements to be displayed to `nb'.
		require
			valid_nb: nb = -1 or nb > 0
		deferred
		end

	notify_breakpoints_changes is
		deferred
		end

	enable_debug is
			-- Allow debugging.
		deferred
		ensure
			can_debug
		end

	disable_debug is
			-- Disallow debugging.
		deferred
		ensure
			not can_debug
		end


feature -- Debugging events

	on_application_before_launching is
		deferred
		end

	on_application_launched is
		deferred
		end

	on_application_before_stopped is
		deferred
		end

	on_application_just_stopped is
		require
			app_is_executing: application.is_running and then application.is_stopped
		deferred
		end

	on_application_before_resuming is
		require
			app_is_executing: application.is_running and then application.is_stopped
		deferred
		end

	on_application_resumed is
		require
			app_is_executing: application.is_running and then not application.is_stopped
		deferred
		end

	on_application_quit is
		deferred
		end

invariant

	Application /= Void and then Application.debugger_manager = Current

end
