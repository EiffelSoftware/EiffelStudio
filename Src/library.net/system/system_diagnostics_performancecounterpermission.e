indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.PerformanceCounterPermission"

external class
	SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_PERMISSIONS_RESOURCEPERMISSIONBASE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_performancecounterpermission,
	make_performancecounterpermission_3,
	make_performancecounterpermission_2,
	make_performancecounterpermission_1

feature {NONE} -- Initialization

	frozen make_performancecounterpermission is
		external
			"IL creator use System.Diagnostics.PerformanceCounterPermission"
		end

	frozen make_performancecounterpermission_3 (permission_access_entries: ARRAY [SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONENTRY]) is
		external
			"IL creator signature (System.Diagnostics.PerformanceCounterPermissionEntry[]) use System.Diagnostics.PerformanceCounterPermission"
		end

	frozen make_performancecounterpermission_2 (permission_access: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS; machine_name: STRING; category_name: STRING) is
		external
			"IL creator signature (System.Diagnostics.PerformanceCounterPermissionAccess, System.String, System.String) use System.Diagnostics.PerformanceCounterPermission"
		end

	frozen make_performancecounterpermission_1 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Diagnostics.PerformanceCounterPermission"
		end

feature -- Access

	frozen get_permission_entries_performance_counter_permission_entry_collection: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONENTRYCOLLECTION is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterPermissionEntryCollection use System.Diagnostics.PerformanceCounterPermission"
		alias
			"get_PermissionEntries"
		end

end -- class SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSION
