indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.PerformanceCounterPermissionEntry"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ENTRY

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (permission_access: SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ACCESS; machine_name: SYSTEM_STRING; category_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Diagnostics.PerformanceCounterPermissionAccess, System.String, System.String) use System.Diagnostics.PerformanceCounterPermissionEntry"
		end

feature -- Access

	frozen get_category_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionEntry"
		alias
			"get_CategoryName"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionEntry"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ACCESS is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionEntry"
		alias
			"get_PermissionAccess"
		end

end -- class SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ENTRY
