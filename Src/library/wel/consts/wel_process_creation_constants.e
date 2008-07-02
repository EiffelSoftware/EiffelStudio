indexing
	description: "Constants for `create_process' from WEL_WINDOWS_ROUTINES."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_CREATION_CONSTANTS

feature -- Access

	create_default_error_mode: INTEGER is
			-- New process does not inherit error mode of calling process but use default error mode.
		external
			"C [macro <winbase.h>]"
		alias
			"CREATE_DEFAULT_ERROR_MODE"
		end

	create_new_console: INTEGER is
			-- New process has a new console, instead of inheriting parent's console.
		external
			"C [macro <winbase.h>]"
		alias
			"CREATE_NEW_CONSOLE"
		end

	create_new_process_group: INTEGER is
			-- New process is root process of a new process group.
		external
			"C [macro <winbase.h>]"
		alias
			"CREATE_NEW_PROCESS_GROUP"
		end

	create_no_window: INTEGER is 0x08000000
			-- New process is console application run without console window.
			-- Valid only when starting console application.
			-- Windows Me/98/95:  Not supported.

	detached_process: INTEGER is
			-- For console processes, new process does not have access to parent's console.
		external
			"C [macro <winbase.h>]"
		alias
			"DETACHED_PROCESS"
		end

	create_unicode_environment: INTEGER is
			-- Environment variables passed to new process uses Unicode characters instead of ANSI characters.
		external
			"C [macro <winbase.h>]"
		alias
			"CREATE_UNICODE_ENVIRONMENT"
		end

	create_suspended: INTEGER is
			-- The primary thread of the new process is created in a suspended state, and does not run until the ResumeThread function is called.
		external
			"C [macro <winbase.h>]"
		alias
			"CREATE_SUSPENDED"
		end

 	is_valid_creation_constant (a_constant: INTEGER): BOOLEAN is
			-- Is `a_constant' a valid process creation constant?
		do
			Result := a_constant = (a_constant & (create_default_error_mode | create_new_console |
				create_new_process_group | detached_process | create_no_window | create_unicode_environment))
			Result := Result and
				((a_constant & (create_new_console | detached_process)) /= (create_new_console | detached_process))
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_PROCESS_CREATION_CONSTANTS

