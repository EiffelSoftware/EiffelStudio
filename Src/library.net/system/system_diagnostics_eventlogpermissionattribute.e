indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogPermissionAttribute"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_eventlogpermissionattribute

feature {NONE} -- Initialization

	frozen make_eventlogpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Diagnostics.EventLogPermissionAttribute"
		end

feature -- Access

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogPermissionAttribute"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS is
		external
			"IL signature (): System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAttribute"
		alias
			"get_PermissionAccess"
		end

feature -- Element Change

	frozen set_permission_access (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS) is
		external
			"IL signature (System.Diagnostics.EventLogPermissionAccess): System.Void use System.Diagnostics.EventLogPermissionAttribute"
		alias
			"set_PermissionAccess"
		end

	frozen set_machine_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLogPermissionAttribute"
		alias
			"set_MachineName"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Diagnostics.EventLogPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONATTRIBUTE
