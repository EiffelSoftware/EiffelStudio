indexing
	description: "Objects to launch a process"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_LAUNCHER

inherit
	WEL_PROCESS_CREATION_CONSTANTS
		export
			{NONE} all
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

	WEL_STARTUP_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic Operations

	launch (a_command_line, a_working_directory: STRING) is
			-- Spawn process described in `a_command_line' from `a_working_directory'.
		require
			non_void_command_line: a_command_line /= Void
			not_empty_command_line: not a_command_line.is_empty
			non_void_working_directory: a_working_directory /= Void
			not_empty_working_directory: not a_working_directory.is_empty
		local
			a_wel_string1: WEL_STRING
			a_wel_string2: WEL_STRING
			last_launch_successful: BOOLEAN
		do
			create process_info.make
			create a_wel_string1.make (a_command_line)
			create a_wel_string2.make (a_working_directory)
			last_launch_successful := cwin_create_process (
				default_pointer, 
				a_wel_string1.item,
				default_pointer, 
				default_pointer, 
				True, 
				cwin_create_new_console, 
				default_pointer, 
				a_wel_string2.item,
				startup_info.item, 
				process_info.item)
		end
	
feature {NONE} -- Implementation

	process_info: WEL_PROCESS_INFO
			-- Process information
	
	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		do
			create Result.make
			Result.initialize
		end

feature {NONE} -- Externals

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN is
			-- SDK CreateProcess
		external
			"C [macro <winbase.h>] (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN"
		alias
			"CreateProcess"
		end

	cwin_create_new_console: INTEGER is
			-- SDK CREATE_NEW_CONSOLE constant
		external
			"C [macro <windows.h>]: EIF_INTEGER"
		alias
			"CREATE_NEW_CONSOLE"
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

end -- class PROCESS_LAUNCHER
