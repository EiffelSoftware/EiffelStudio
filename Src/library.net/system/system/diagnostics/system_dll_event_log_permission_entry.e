indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogPermissionEntry"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_EVENT_LOG_PERMISSION_ENTRY

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (permission_access: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS; machine_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Diagnostics.EventLogPermissionAccess, System.String) use System.Diagnostics.EventLogPermissionEntry"
		end

feature -- Access

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogPermissionEntry"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS is
		external
			"IL signature (): System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionEntry"
		alias
			"get_PermissionAccess"
		end

end -- class SYSTEM_DLL_EVENT_LOG_PERMISSION_ENTRY
