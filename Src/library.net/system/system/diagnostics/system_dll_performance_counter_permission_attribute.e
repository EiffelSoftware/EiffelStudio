indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.PerformanceCounterPermissionAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_system_dll_performance_counter_permission_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_performance_counter_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Diagnostics.PerformanceCounterPermissionAttribute"
		end

feature -- Access

	frozen get_category_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"get_CategoryName"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ACCESS is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"get_PermissionAccess"
		end

feature -- Element Change

	frozen set_permission_access (value: SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ACCESS) is
		external
			"IL signature (System.Diagnostics.PerformanceCounterPermissionAccess): System.Void use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"set_PermissionAccess"
		end

	frozen set_machine_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"set_MachineName"
		end

	frozen set_category_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"set_CategoryName"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ATTRIBUTE
