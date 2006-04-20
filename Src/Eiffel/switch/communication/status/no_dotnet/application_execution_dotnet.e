indexing
	description	: "Controls execution of debugged application under dotnet."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class APPLICATION_EXECUTION_DOTNET

inherit
	APPLICATION_EXECUTION_IMP
		redefine
			make
		end

create {APPLICATION_EXECUTION}
	make

feature {APPLICATION_EXECUTION} -- Initialization

	make is
			--
		do
		end

feature {APPLICATION_EXECUTION} -- load and save

	load_dotnet_debug_info is
			-- Load debug information (so far only the breakpoints)
		do
		end

feature -- Properties

	status: APPLICATION_STATUS_DOTNET is
			-- Status of the running dotnet application
		do
			Result ?= Application.status
		end

feature {APPLICATION_EXECUTION} -- Properties

	is_valid_object_address (addr: STRING): BOOLEAN is
			-- Is object address `addr' valid?
			-- (i.e Does bench know about it)
		do
		end

	keep_only_objects (kept_objects: LIST [STRING]) is
			-- (export status {APPLICATION_EXECUTION})
		do
		end

	continue_ignoring_kept_objects is
		do
		end

	disable_assertion_check is
		do
		end

	restore_assertion_check is
		do
		end

feature -- access

	dump_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): DUMP_VALUE is
		do
		end

	debug_value_at_address_with_class (a_addr: STRING; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE is
		do
		end

	onces_values (flist: LIST [E_FEATURE]; a_addr: STRING; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE] is
		do
		end

feature -- Trigger eStudio done

	callback_notification_processing: BOOLEAN is False

feature -- Bridge to Debugger

	exception_occurred: BOOLEAN is
			-- Last callback is about exception ?
		do
		end

	exception_handled: BOOLEAN is False

	exception_message: STRING is
		do
		end

	exception_class_name: STRING is
		do
		end

	exception_module_name: STRING is
		do
		end

	exception_to_string: STRING is
			-- Exception to String
		do
		end

feature -- Bridge to Debugger

	eifnet_debugger: EIFNET_DEBUGGER
			-- Access to the Dotnet Debugger

feature -- Execution

	run (args, cwd: STRING) is
			-- Run application with arguments `args' in directory `cwd'.
			-- If `is_running' is false after the
			-- execution of this routine, it means that
			-- the application was unable to be launched
			-- due to the time_out (see `eiffel_timeout_message').
			-- Before running the application you must check
			-- to see if the debugged information is up to date.
		do
		end

	continue (kept_objects: LINKED_SET [STRING]) is
			-- Continue the running of the application and keep the
			-- objects addresses in `kept_objects'. Objects that are not in
			-- `kept_objects' will be removed and will be not under the
			-- control of bench. Therefore, these addresses cannot be
			-- referenced the next time we stop the application.
		do
		end

	interrupt is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
		do
		end

	notify_newbreakpoint is
			-- Send an interrupt to the application
			-- which will stop at the next breakable line number
			-- in order to record the new breakpoint(s) before
			-- automatically resuming its execution.
		do
		end

	kill is
			-- Ask the application to terminate itself.
		do
		end

	process_termination is
			-- Process the termination of the executed
			-- application. Also execute the `termination_command'.
		do
		end

feature -- Object Keeper

	kept_object_item (a_address: STRING): ABSTRACT_DEBUG_VALUE is
		do
		end

	know_about_kept_object (a_address: STRING): BOOLEAN is
		do
		end

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

end -- class APPLICATION_EXECUTION_DOTNET
