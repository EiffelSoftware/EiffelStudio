indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.PerformanceCounterPermissionAttribute"

external class
	SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_performancecounterpermissionattribute

feature {NONE} -- Initialization

	frozen make_performancecounterpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Diagnostics.PerformanceCounterPermissionAttribute"
		end

feature -- Access

	frozen get_category_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"get_CategoryName"
		end

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS is
		external
			"IL signature (): System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"get_PermissionAccess"
		end

feature -- Element Change

	frozen set_permission_access (value: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS) is
		external
			"IL signature (System.Diagnostics.PerformanceCounterPermissionAccess): System.Void use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"set_PermissionAccess"
		end

	frozen set_machine_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"set_MachineName"
		end

	frozen set_category_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"set_CategoryName"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Diagnostics.PerformanceCounterPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONATTRIBUTE
