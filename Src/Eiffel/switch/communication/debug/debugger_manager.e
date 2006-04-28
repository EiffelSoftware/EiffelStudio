indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	DEBUGGER_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

	PROJECT_CONTEXT

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

feature -- Debug info access

	load_debug_info is
			-- Load debug information (so far only the breakpoints)
		local
			load_filename: FILE_NAME
		do
			create load_filename.make
			load_filename.set_directory (Workbench_generation_path)
			load_filename.set_file_name (Debug_info_name)
			load_filename.add_extension (Debug_info_extension)

			Application.load_debug_info_from (load_filename)
		end

	save_debug_info is
			-- Save debug information (so far only the breakpoints)
		local
			save_filename: FILE_NAME
		do
			create save_filename.make
			save_filename.set_directory (Workbench_generation_path)
			save_filename.set_file_name (Debug_info_name)
			save_filename.add_extension (Debug_info_extension)

			Application.save_debug_info_into (save_filename)
		end


feature -- Breakpoints access

	resynchronize_breakpoints is
			-- Resychronize the breakpoints (for instance after a compilation).
		do
			Application.resynchronize_breakpoints
		end

	has_breakpoints: BOOLEAN is
			-- Does the program have some breakpoints (enabled or disabled) ?
		do
			Result := Application.debug_info.has_breakpoints
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

	application_current_thread_id: INTEGER is
		require
			application_is_executing: application_is_executing
		do
			Result := Application.status.current_thread_id
		end

feature -- Change

	set_current_thread_id (tid: INTEGER) is
			-- Set Current thread id to `tid'
		do
			if Application_current_thread_id /= tid then
				Application.status.set_current_thread_id (tid)
				Application.status.switch_to_current_thread_id
				Application.status.reload_current_call_stack
			end
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

	debugging_operation_id: NATURAL_32

	on_application_before_launching is
		do
			debugging_operation_id := 0
		end

	on_application_launched is
		do
			debugging_operation_id := debugging_operation_id + 1
		end

	on_application_before_stopped is
		do
		end

	on_application_just_stopped is
		require
			app_is_executing: application.is_running and then application.is_stopped
		do
			debugging_operation_id := debugging_operation_id + 1
		end

	on_application_before_resuming is
		require
			app_is_executing: application.is_running and then application.is_stopped
		do
		end

	on_application_resumed is
		require
			app_is_executing: application.is_running and then not application.is_stopped
		do
			debugging_operation_id := debugging_operation_id + 1
		end

	on_application_quit is
		do
			debugging_operation_id := debugging_operation_id + 1
		end

invariant

	Application /= Void and then Application.debugger_manager = Current

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
