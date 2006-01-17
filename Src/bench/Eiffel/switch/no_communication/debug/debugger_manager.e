indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
