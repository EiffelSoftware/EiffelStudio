indexing
	description: "Constants for `create_process' from WEL_WINDOWS_ROUTINES."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_CREATION_CONSTANTS

inherit
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

feature -- Access

	create_default_error_mode: INTEGER is
			-- New process does not inherit error mode of calling process but use default error mode.
		external
			"C [macro <winbase.h>]"
		alias
			"CREATE_DEFAULT_ERROR_MODE"
		end

	create_new_console: INTEGER is
			-- New process has a new console, instead of inheriting parent’s console.
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
 
	detached_process: INTEGER is
			-- For console processes, new process does not have access to parent's console.
		external
			"C [macro <winbase.h>]"
		alias
			"DETACHED_PROCESS"
		end
 
 	is_valid_creation_constant (a_constant: INTEGER): BOOLEAN is
			-- Is `a_constant' a valid process creation constant?
		do
			Result := flag_set (create_default_error_mode + create_new_console +
								create_new_process_group + detached_process, a_constant) and
						(flag_set (a_constant, create_new_console) implies not flag_set (a_constant, detached_process)) and
						(flag_set (a_constant, detached_process) implies not flag_set (a_constant, create_new_console))
		end

end -- class WEL_PROCESS_CREATION_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

