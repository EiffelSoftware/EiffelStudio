indexing
	description: "Objects to launch a process"
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

end -- class PROCESS_LAUNCHER
