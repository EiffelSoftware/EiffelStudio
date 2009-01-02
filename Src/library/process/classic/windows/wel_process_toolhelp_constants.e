note
	description: "Constants for process rights"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_TOOLHELP_CONSTANTS

feature -- Process access rights

	cwin_process_all_access: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_ALL_ACCESS"
		end

	cwin_process_terminate: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_TERMINATE"
		end

	cwin_process_create_process: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_CREATE_PROCESS"
		end

	cwin_process_dup_handle: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_DUP_HANDLE"
		end

	cwin_process_query_information: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_QUERY_INFORMATION"
		end

	cwin_process_set_quota: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_SET_QUOTA"
		end

	cwin_process_set_information: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_SET_INFORMATION"
		end

	cwin_process_vm_operation: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_VM_OPERATION"
		end

	cwin_process_vm_read: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_VM_READ"
		end

	cwin_process_vm_write: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_VM_WRITE"
		end

	cwin_process_synchronize: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"SYNCHRONIZE"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
