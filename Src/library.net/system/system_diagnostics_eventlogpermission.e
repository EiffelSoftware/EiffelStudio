indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogPermission"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_eventlogpermission_3,
	make_eventlogpermission_2,
	make_eventlogpermission_1,
	make_eventlogpermission

feature {NONE} -- Initialization

	frozen make_eventlogpermission_3 (permission_access_entries: ARRAY [SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY]) is
		external
			"IL creator signature (System.Diagnostics.EventLogPermissionEntry[]) use System.Diagnostics.EventLogPermission"
		end

	frozen make_eventlogpermission_2 (permission_access: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS; machine_name: STRING) is
		external
			"IL creator signature (System.Diagnostics.EventLogPermissionAccess, System.String) use System.Diagnostics.EventLogPermission"
		end

	frozen make_eventlogpermission_1 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Diagnostics.EventLogPermission"
		end

	frozen make_eventlogpermission is
		external
			"IL creator use System.Diagnostics.EventLogPermission"
		end

feature -- Access

	frozen get_permission_entries_event_log_permission_entry_collection: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRYCOLLECTION is
		external
			"IL signature (): System.Diagnostics.EventLogPermissionEntryCollection use System.Diagnostics.EventLogPermission"
		alias
			"get_PermissionEntries"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSION
