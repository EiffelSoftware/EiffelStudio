indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogPermission"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_EVENT_LOG_PERMISSION

inherit
	SYSTEM_DLL_RESOURCE_PERMISSION_BASE
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_system_dll_event_log_permission_2,
	make_system_dll_event_log_permission_3,
	make_system_dll_event_log_permission_1,
	make_system_dll_event_log_permission

feature {NONE} -- Initialization

	frozen make_system_dll_event_log_permission_2 (permission_access: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS; machine_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Diagnostics.EventLogPermissionAccess, System.String) use System.Diagnostics.EventLogPermission"
		end

	frozen make_system_dll_event_log_permission_3 (permission_access_entries: NATIVE_ARRAY [SYSTEM_DLL_EVENT_LOG_PERMISSION_ENTRY]) is
		external
			"IL creator signature (System.Diagnostics.EventLogPermissionEntry[]) use System.Diagnostics.EventLogPermission"
		end

	frozen make_system_dll_event_log_permission_1 (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Diagnostics.EventLogPermission"
		end

	frozen make_system_dll_event_log_permission is
		external
			"IL creator use System.Diagnostics.EventLogPermission"
		end

feature -- Access

	frozen get_permission_entries_event_log_permission_entry_collection: SYSTEM_DLL_EVENT_LOG_PERMISSION_ENTRY_COLLECTION is
		external
			"IL signature (): System.Diagnostics.EventLogPermissionEntryCollection use System.Diagnostics.EventLogPermission"
		alias
			"get_PermissionEntries"
		end

end -- class SYSTEM_DLL_EVENT_LOG_PERMISSION
