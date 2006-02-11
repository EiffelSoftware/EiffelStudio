indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_TOOLHELP_CONSTANTS

feature -- Process access rights

	cwin_process_all_access: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_ALL_ACCESS"
		end

	cwin_process_terminate: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_TERMINATE"
		end

	cwin_process_create_process: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_CREATE_PROCESS"
		end

	cwin_process_dup_handle: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_DUP_HANDLE"
		end

	cwin_process_query_information: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_QUERY_INFORMATION"
		end

	cwin_process_set_quota: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_SET_QUOTA"
		end

	cwin_process_set_information: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_SET_INFORMATION"
		end

	cwin_process_vm_operation: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_VM_OPERATION"
		end

	cwin_process_vm_read: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_VM_READ"
		end

	cwin_process_vm_write: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"PROCESS_VM_WRITE"
		end

	cwin_process_synchronize: INTEGER is
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"SYNCHRONIZE"
		end

end
