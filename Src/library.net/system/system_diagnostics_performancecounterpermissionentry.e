indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.PerformanceCounterPermissionEntry"

external class
	SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONENTRY

create
	make

feature {NONE} -- Initialization

	frozen make (permission_access: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS; machine_name: STRING; category_name: STRING) is
		external
			"IL creator signature (System.Diagnostics.PerformanceCounterPermissionAccess, System.String, System.String) use System.Diagnostics.PerformanceCounterPermissionEntry"
		end

feature -- Access

	frozen get_category_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionEntry"
		alias
			"get_CategoryName"
		end

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionEntry"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionEntry"
		alias
			"get_PermissionAccess"
		end

end -- class SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONENTRY
