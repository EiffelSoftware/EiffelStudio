indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.PerformanceCounterPermission"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION

inherit
	SYSTEM_DLL_RESOURCE_PERMISSION_BASE
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_system_dll_performance_counter_permission_2,
	make_system_dll_performance_counter_permission_3,
	make_system_dll_performance_counter_permission_1,
	make_system_dll_performance_counter_permission

feature {NONE} -- Initialization

	frozen make_system_dll_performance_counter_permission_2 (permission_access: SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ACCESS; machine_name: SYSTEM_STRING; category_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Diagnostics.PerformanceCounterPermissionAccess, System.String, System.String) use System.Diagnostics.PerformanceCounterPermission"
		end

	frozen make_system_dll_performance_counter_permission_3 (permission_access_entries: NATIVE_ARRAY [SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ENTRY]) is
		external
			"IL creator signature (System.Diagnostics.PerformanceCounterPermissionEntry[]) use System.Diagnostics.PerformanceCounterPermission"
		end

	frozen make_system_dll_performance_counter_permission_1 (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Diagnostics.PerformanceCounterPermission"
		end

	frozen make_system_dll_performance_counter_permission is
		external
			"IL creator use System.Diagnostics.PerformanceCounterPermission"
		end

feature -- Access

	frozen get_permission_entries_performance_counter_permission_entry_collection: SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION_ENTRY_COLLECTION is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterPermissionEntryCollection use System.Diagnostics.PerformanceCounterPermission"
		alias
			"get_PermissionEntries"
		end

end -- class SYSTEM_DLL_PERFORMANCE_COUNTER_PERMISSION
